package com.iteyes.works.empinfo.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface EmpinfoMapper {

	public Map<String, String> getEmpBasicinfo(String emp_no);
	
	public List<HashMap<String, String>> getEmpEducationinfo(String emp_no);

	public List<HashMap<String, String>> getEmpCareerinfo(String emp_no);

	public List<Map<String, String>> getGroupCode();

	public List<Map<String, String>> getAddr(String searchAddr);
	
	public List<Map<String, ?>> getDpt(Map<String, String> param);
	
	public List<Map<String, ?>> getEmpDptinfo(String emp_no);
	
	public String getNewEmpNo();
	
	public int joinNewMember(Map<String, String> param);

}
