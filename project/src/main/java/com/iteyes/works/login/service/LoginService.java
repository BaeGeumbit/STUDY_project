package com.iteyes.works.login.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.iteyes.works.login.mapper.LoginMapper;


@Service
public class LoginService {
	 
	@Autowired
	private LoginMapper loginMapper;
	
	/**
	 * 
	 * @param Map
	 */
	public int login(Map param) {
		
		int result = loginMapper.selectLogin(param);
		
		return result;	
	}
	
	public HashMap<String, String> selectSessionInfo(String emp_no){
		
		HashMap<String, String> map = loginMapper.selectSessionInfo(emp_no);
		
		return map;
	}
	

}
