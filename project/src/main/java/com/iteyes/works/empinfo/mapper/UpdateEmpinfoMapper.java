package com.iteyes.works.empinfo.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UpdateEmpinfoMapper {
	
	//기본
	public int updateBasic(Map<String, String> updateMap);
	
	//학력
	public List<String> getEdu(String emp_no);
	
	public int delEdu(Map<String, String> delMap);
	
	public int updateEdu(Map<String, String> updateMap);
	
	public int insertEdu(Map<String, String> insertMap);
	
	//경력
	public List<String> getCareer(String emp_no);
	
	public int delCareer(Map<String, String> delMap);
	
	public int updateCareer(Map<String, String> updateMap);
	
	public int insertCareer(Map<String, String> insertMap);
	
	
	//부서
	public List<String> getEmpDpt(String emp_no);
	
	public Map<String, String> getDetailDpt(String dpt_name);
	
	public Map<String, String> getDpt(String dpt_name);
	
	public int delDpt(Map<String, String> deleteMap);
	
	public int updateDpt(Map<String, String> updateMap);
	
	public int insertDpt(Map<String, String> insertMap);
	
	

}
