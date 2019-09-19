package com.study.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.study.bean.Employee;

public interface EmployeeService {

	public List<Employee> getAllEmps();

	public void saveEmp(Employee employee);

	public boolean checkUser(String empName);

	public Employee getEmp(int empId);

	public void updateEmp(Employee employee);

	public void deleteEmp(int empId);

	public void deleteBatch(List<Integer> ids); 

}
