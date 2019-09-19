package com.study.test;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.study.bean.Employee;
import com.study.dao.EmployeeMapper;
import com.study.service.EmployeeService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:spring/applicationContext-dao.xml"})
public class HelperTest {
	
	@Autowired
	private EmployeeService employeeService;
	
	@Autowired
	private EmployeeMapper employeeMapper;
	
	@Test
	public void helperTest() {
		List<Employee> list = employeeMapper.selectByExample(null);
		System.out.println(list);
		
		int pageNumber = 2;
		PageHelper.startPage(pageNumber, 5);
		// startPage之后的一个查询就是分页的
		List<Employee> emps = employeeMapper.selectByExample(null);
		System.out.println(emps);
		// 使用pageInfo来封装list集合
		// 因为它里面封装了可在页面使用的数据信息（包括详细的分页信息及查询到的数据）,传入连续显示的页数
		PageInfo page = new PageInfo(emps);
		PageInfo<Employee> page1 = new PageInfo<Employee>(emps);
		System.out.println(page.toString());
		System.out.println(page1.getList().size());
	}
}
