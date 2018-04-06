package com.iteyes.works.emplist.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jboss.logging.MessageLogger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.iteyes.works.emplist.mapper.EmplistMapper;

@Service
public class EmplistService {
	
	@Autowired
	private EmplistMapper emplistMapper;

	public List<HashMap<String,String>> getEmpList(Map pageParam) {
		
		//List<String> returnList = new ArrayList<String>();
		//ArrayList<HashMap<String,String>> list = new ArrayList<>();
		
		List<HashMap<String, String>> emplist = emplistMapper.getEmpList(pageParam);
		
		//list.addAll(emplist);
		
		System.out.println("77777777777777777777");
		System.out.println("77777777777777777777");
		System.out.println("77777777777777777777");
		System.out.println("77777777777777777777");
		
		System.out.println(emplistMapper.getEmpList(pageParam).toString());
		
		return emplist;
	}
	
	public int getListCount() {
		
		int count = emplistMapper.getListCount();		
		return count;
	}

	public List<HashMap<String,String>> getEmpSearchList(Map<String, Object> param) {
		
		List<HashMap<String,String>> searchList = emplistMapper.getEmpSearchList(param);
		
		return searchList;
	}

}
