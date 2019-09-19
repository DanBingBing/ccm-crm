package com.study.test;

import java.util.List;
import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.study.bean.Department;
import com.study.bean.Employee;
import com.study.dao.DepartmentMapper;
import com.study.dao.EmployeeMapper;

/**
 * 1.导入springTest模块
 * 2.@ContextConfiguration指定Spring配置文件的位置
 * 3.直接autowired要使用的组件即可
 * @author danbingbing
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:spring/applicationContext-dao.xml"})
public class MapperTest {
	
	@Autowired
	private DepartmentMapper departmentMapper;
	
	@Autowired
	private EmployeeMapper employeeMapper;
	
	@Autowired
	private SqlSession sqlSession;
	
	@Test
	public void test() {
		/*// 以前用的方式
		// 1.创建IOC容器
		ApplicationContext ioc = new ClassPathXmlApplicationContext("spring/applicationContext-dao.xml");
		// 2.从容器中获取mapper
		DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);*/
	
		// 测试mapper代理是否成功
		System.out.println(departmentMapper);
		
		// 在部门表中插入数据
		//departmentMapper.insertSelective(new Department(null,"开发部"));
		//departmentMapper.insertSelective(new Department(null,"测试部"));
		
		// 在员工表中插入数据
		//employeeMapper.insertSelective(new Employee(null,"zhangsan","M","zhangsan@qq.com",1));
		//employeeMapper.insertSelective(new Employee(null,"lisi","M","li@qq.com",2));
		//employeeMapper.insertSelective(new Employee(null,"test",null,null,null));
		
		// 在员工表中批量插入数据，使用可以执行批量操作的sqlsession
		/*// 这样插入不是批量操作
		  for(int i=0;i<100;i++) {
			mployeeMapper.insertSelective(new Employee(null,"lisi","M","li@qq.com",2));
		}*/
		
		/*EmployeeMapper employeeMapper = sqlSession.getMapper(EmployeeMapper.class);
		for(int i=0;i<100;i++) {
			// substring(0, 5)截取随机生成字符串的前5位
			String uid = UUID.randomUUID().toString().substring(0, 5)+i;
			//System.out.println(uid);
			employeeMapper.insertSelective(new Employee(null, uid, "M", uid+"@qq.com" ,2));
		}
		System.out.println("批量插入完成！");*/
				
		// 查询所有的员工及其部门信息
		List<Employee> list = employeeMapper.selectByExampleWithDept(null);
		for(Employee employee : list) {
			System.out.println(employee);
		}
		
	}
}
