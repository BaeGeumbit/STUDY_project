package com.iteyes.works.emplist.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface EmplistMapper {

	public List<HashMap<String, String>> getEmpList(Map pageParam);
	
	public int getListCount();

	public List<HashMap<String, String>> getEmpSearchList(Map<String, Object> param);

}
