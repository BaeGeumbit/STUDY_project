package com.iteyes.works.empinfo.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.iteyes.works.empinfo.mapper.EmpinfoMapper;
import com.iteyes.works.util.AES256Security;

@Service
public class EmpinfoService {
	
	@Autowired
	private EmpinfoMapper empinfoMapper;

	public Map<String, String> getEmpBasicinfo(String emp_no) {
		
		Map<String, String> empBasicinfo = empinfoMapper.getEmpBasicinfo(emp_no);
		
		return empBasicinfo;
	}


	public List<HashMap<String, String>> getEducationinfo(String emp_no) {
		
		List<HashMap<String, String>> empEducationinfo = empinfoMapper.getEmpEducationinfo(emp_no);
		
		return empEducationinfo;
	}

	public List<HashMap<String, String>> getCareerinfo(String emp_no) {
		
		List<HashMap<String, String>> empCareerinfo = empinfoMapper.getEmpCareerinfo(emp_no);
		
		return empCareerinfo;
	}


	public Map<String, List<Map<String,String>>> getGroupCode() {
		
		List<Map<String, String>> groupCode = empinfoMapper.getGroupCode();
		Map<String, List<Map<String,String>>> getCodeParam = new HashMap<String,List<Map<String,String>>>();		
		
		for(int i=0; i<groupCode.size(); i++) {
			if(getCodeParam.containsKey(groupCode.get(i).get("CODE_GRP_ID"))) {
				
				List<Map<String,String>> list = getCodeParam.get(groupCode.get(i).get("CODE_GRP_ID"));
				Map<String,String> map = new HashMap<>();
				
				map.put("CODE_ID", groupCode.get(i).get("CODE_ID"));
				map.put("CODE_NAME", groupCode.get(i).get("CODE_NAME"));
				
				list.add(map);
			
			}else {
				
				List<Map<String,String>> list = new ArrayList<Map<String,String>>();
				Map<String,String> map = new HashMap<>();
				
				map.put("CODE_ID", groupCode.get(i).get("CODE_ID"));
				map.put("CODE_NAME", groupCode.get(i).get("CODE_NAME"));
				
				list.add(map);
				getCodeParam.put( groupCode.get(i).get("CODE_GRP_ID"), list);
			}	
			
		}

		return getCodeParam;
		
	}
	
	
	public List<Map<String, String>> getAddr(String searchAddr){
		
		List<Map<String, String>> addrlist = empinfoMapper.getAddr(searchAddr);
		
		return addrlist;
	}
	
	
	public Map<String, List<Map<String, ?>>> getDpt(Map<String, String> param, String emp_no){
		
		List<Map<String, ?>> dptlist = empinfoMapper.getDpt(param);
		
		List<Map<String, ?>> empDptlist = empinfoMapper.getEmpDptinfo(emp_no);
		
		//List<Map<String, List<Map<String, ?>>>> list = new ArrayList<>();
		
		Map<String, List<Map<String, ?>>> map = new HashMap<>();
		
		map.put("dptlist", dptlist);
		map.put("empDptlist", empDptlist);
		
		//list.add(map);
		
		System.out.println("listttttt:"+map.toString());
		
		return map;
	}
	
	/**
	 * 신규 등록할 사원 번호 select
	 * @return
	 */
	public String getNewEmpNo() {
		
		String new_emp_no = empinfoMapper.getNewEmpNo();
		
		return new_emp_no;
	}
	
	/**
	 * 사원 신규 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int join(Map<String, String> param) throws Exception{
		
		String passwd = AES256Security.encrypt(param.get("emp_no"));		
		param.put("passwd_no", passwd);		
		int check =empinfoMapper.joinNewMember(param);
		
		System.out.println("join result : "+check);
		
		return check;
	}

}








