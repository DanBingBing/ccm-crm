package com.study.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.study.bean.Employee;
import com.study.bean.Message;
import com.study.service.EmployeeService;

/**
 * 员工管理控制器的实现
 * 
 * url:
 * 查询员工	/emp/{id}	get
 * 保存员工	/emp		post
 * 修改员工	/emp/{id}	put
 * 删除员工	/emp/{id}	delete
 * 
 * @author danbingbing
 *
 */
@Controller
public class EmployeeController {

	@Autowired
	private EmployeeService employeeService;
	
	/**
	 * 根据empId删除单个员工信息的方法
	 * 单个、批量都可以
	 * 		批量：1-2-3...
	 * 		单个：1
	 * 
	 * @param empId
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	public Message deleteEmp(@PathVariable("ids") String ids) {
		// ids字符串中是否包含 -
		if(ids.contains("-")) {
			// 将ids字符串中的数字分割出来
			List<Integer> del_ids = new ArrayList<>();
			String[] str_ids =  ids.split("-");
			for(String strings: str_ids) {
				del_ids.add(Integer.parseInt(strings));
				//System.out.println(strings);
			}
			// 批量删除
			employeeService.deleteBatch(del_ids);
		}else {
			Integer empId = Integer.parseInt(ids);
			// 单个删除
			employeeService.deleteEmp(empId);
		}
		
		return Message.success();
	}
	
	/**
	 * 更新员工信息的方法
	 * /emp/{empId} 里的参数要与方法中传的参数的参数名相同（这里该bean中包含了empId也可以）
	 * 和下面根据员工id查询的方法不同，它是直接从路径中取出的
	 * 
	 * @param employee
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	public Message saveEmp(Employee employee) {
		//System.out.println("将要更新的员工数据："+employee);
		employeeService.updateEmp(employee);
		return Message.success();
	}
	
	/**
	 * 根据员工id查询
	 * 指定参数从路径中取出，   @PathVariable("") 
	 * @param empId
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	public Message getEmp(@PathVariable("id") int empId) {
		Employee emp = employeeService.getEmp(empId);
		return Message.success().add("emp", emp);
	}
	
	/**
	 * 检验用户名是否重复
	 * @RequestParam("empName") 明确的告诉springMvc要取出empName的值
	 * 
	 * @param empName
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/checkUser")
	public Message checkUser(@RequestParam("empName")String empName) {
		// 先判断用户名是否是合法
		String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
		if(!empName.matches(regx)) {
			return Message.failed().add("va_msg", "用户名可以是6-16位的英文或者是2-5位的中文组合！");
		}
		
		boolean flag = employeeService.checkUser(empName);
		if(flag) {
			return Message.success();
		}else {
			return Message.failed().add("va_msg", "用户名不可用！");
		}
	}
	
	/**
	 * 员工信息保存
	 * 使用@Valid 表示该对象要进行数据校验
	 * 使用BindingResult来封装校验结果
	 * @return
	 */
	@RequestMapping(method=RequestMethod.POST,value="/emp")
	@ResponseBody
	public Message saveEmp(@Valid Employee employee,BindingResult result) {
		if(result.hasErrors()) {
			Map<String,Object> map = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for(FieldError fieldError:errors) {
				//System.out.println("错误的字段名："+fieldError.getField());
				//System.out.println("错误信息："+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Message.failed().add("errorFields", map);
		}else {
			employeeService.saveEmp(employee);
			//System.out.println(employee);
			return Message.success();
		}
	}
	
	/**
	 * 要使@ResponseBody正常工作，需要导入jackson包，将数据分装为json字符串
	 * @param pageNumber
	 * @param model
	 * @return
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Message getEmpsWithJson(@RequestParam(value="pageNumber",defaultValue="1") Integer pageNumber,Model model) {
		// 使用PageHelper分页插件(https://github.com/pagehelper)
		// 在查询之前调用，传入页码、以及每页大小
		PageHelper.startPage(pageNumber, 5);
		// startPage之后的一个查询就是分页的
		List<Employee> emps = employeeService.getAllEmps();
		// 使用pageInfo来封装list集合
		// 因为它里面封装了可在页面使用的数据信息（包括详细的分页信息及查询到的数据）,传入页面中要连续显示的页数
		PageInfo page = new PageInfo(emps,5);
		
		return Message.success().add("pageInfo", page);
	}
	
	/**
	 * 查询所有员工且带部门信息
	 * @return
	 */
	//@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pageNumber",defaultValue="1") Integer pageNumber,Model model) {
		// 使用PageHelper分页插件(https://github.com/pagehelper)
		// 在查询之前调用，传入页码、以及每页大小
		PageHelper.startPage(pageNumber, 5);
		// startPage之后的一个查询就是分页的
		List<Employee> emps = employeeService.getAllEmps();
		// 使用pageInfo来封装list集合
		// 因为它里面封装了可在页面使用的数据信息（包括详细的分页信息及查询到的数据）,传入连续显示的页数
		PageInfo page = new PageInfo(emps,5);
		model.addAttribute("pageInfo",page);
		return "list";
	}
	
}
