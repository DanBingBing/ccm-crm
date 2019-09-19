package com.study.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;
import com.study.bean.Employee;

/**
 * 使用spring测试模块提供的测试请求功能，测试请求的正确性
 * spring4测试的时候，需要servlet3.0的支持
 * （在pom.xml文件中将javax.servlet-api的版本换成3.0以上的）
 * @author danbingbing
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:spring/applicationContext-dao.xml","classpath:spring/springmvc.xml"})
@WebAppConfiguration
public class SpringMvcTest {
	
	// 传入springMvc的ioc
	// 使用@Autowired只能自动注入WebApplicationContext里面的属性，不能自动注入它自己
	// 这里还需使用@WebAppConfiguration
	@Autowired
	WebApplicationContext context;
	
	// 虚拟mvc请求，获取到处理结果
	MockMvc mockMvc;
	
	// 每次用获取mockMvc都要先初始化一下
	@Before
	public void initMockMvc() {
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
	
	@Test
	public void pageTest() throws Exception {
		// 模拟请求拿到返回值
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pageNumber", "1")).andReturn();
		
		// 请求成功以后，请求域中会有pageInfo，此时可去除pageInfo来来验证结果
		MockHttpServletRequest request = result.getRequest();
		PageInfo pi = (PageInfo) request.getAttribute("pageInfo"); 
		System.out.println("当前页码："+pi.getPageNum());
		System.out.println("总页码："+pi.getPages());
		System.out.println("总记录数："+pi.getTotal());
		System.out.println("在页面需要连续显示的页码："+pi.getPageNum());
		int[] numbers = pi.getNavigatepageNums();
		for(int i : numbers) {
			// 使用print()不会换行
			System.out.print(" "+i);
		}
		// 换行
		System.out.println();
		
		// pageInfo中除了分页的详细信息，还有查询到的记录信息
		List<Employee> list = pi.getList();
		for(Employee employee : list) {
			System.out.println("ID:"+employee.getdId()+" ==> Name:"+employee.getEmpName());
		}
	}
	
	
}
