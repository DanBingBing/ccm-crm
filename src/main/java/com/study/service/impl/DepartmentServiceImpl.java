package com.study.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.bean.Department;
import com.study.dao.DepartmentMapper;
import com.study.service.DepartmentService;

@Service
public class DepartmentServiceImpl implements DepartmentService {

	@Autowired
	private DepartmentMapper departmentMapper;
	
	public List<Department> getDepts(){
		List<Department> list = departmentMapper.selectByExample(null);
		return list;
	}

}
