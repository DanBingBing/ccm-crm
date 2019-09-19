package com.study.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.study.bean.Department;
import com.study.bean.Message;
import com.study.service.DepartmentService;

/**
 * 部门信息控制器的实现
 * @author danbingbing
 *
 */
@Controller
public class DepartmentController {
	
	@Autowired
	private DepartmentService departmentService;

	/**
	 * 返回所有的部门信息
	 * @return
	 */
	@RequestMapping(value="/depts")
	@ResponseBody
	public Message getDepts() {
		List<Department> list = departmentService.getDepts();
		return Message.success().add("depts", list);
	}
}
