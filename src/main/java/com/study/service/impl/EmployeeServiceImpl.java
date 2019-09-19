package com.study.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.bean.Employee;
import com.study.bean.EmployeeExample;
import com.study.bean.EmployeeExample.Criteria;
import com.study.dao.EmployeeMapper;
import com.study.service.EmployeeService;


/**
 * 员工管理业务逻辑的实现
 * @author danbingbing
 *
 */
@Service
public class EmployeeServiceImpl implements EmployeeService {

	@Autowired
	private EmployeeMapper employeeMapper;
	
	/**
	 * 查询所有员工且带部门信息
	 */
	@Override
	public List<Employee> getAllEmps() {
		List<Employee> list = employeeMapper.selectByExampleWithDept(null);
		return list;
	}
	
	/**
	 * 保存员工的方法
	 */
	@Override
	public void saveEmp(Employee employee) {
		// 有选择的插入员工信息，因为员工id是自增的，不需要插入
		employeeMapper.insertSelective(employee);
	}

	/**
	 * 检验用户名是否重复
	 */
	@Override
	public boolean checkUser(String empName) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria  = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		// 因为countByExample在xml文件中的参数是EmployeeExample，
		// 所以要将传入的empName封装到EmployeeExample类中，否则sql出错
		Long count = employeeMapper.countByExample(example);
		
		return count == 0;
	}

	@Override
	public Employee getEmp(int empId) {
		Employee emp = employeeMapper.selectByPrimaryKey(empId);
		return emp;
	}

	@Override
	public void updateEmp(Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);
	}

	@Override
	public void deleteEmp(int empId) {
		employeeMapper.deleteByPrimaryKey(empId);
	}

	@Override
	public void deleteBatch(List<Integer> ids) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		// delete from tbl_emp where emp_id in(1,2,3)
		criteria.andEmpIdIn(ids);
		employeeMapper.deleteByExample(example);
	}

}
