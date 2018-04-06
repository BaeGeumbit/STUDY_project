package com.iteyes.works.login.mapper;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LoginMapper {
	
	public int selectLogin(Map param);
	
	public HashMap<String, String> selectSessionInfo(String emp_no);

}
