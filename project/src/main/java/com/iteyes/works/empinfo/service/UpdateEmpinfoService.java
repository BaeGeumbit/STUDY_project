package com.iteyes.works.empinfo.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.iteyes.works.empinfo.mapper.UpdateEmpinfoMapper;
import com.iteyes.works.util.AES256Security;

@Service
public class UpdateEmpinfoService {
	
	@Autowired 
	private UpdateEmpinfoMapper updateMapper;
	
	private String proc_emp_no = "2";	
	private Map<String, String> param = new HashMap<>();	
	private String emp_no = "";

	/**
	 * 
	 * @param param
	 * 사원 정보 수정
	 */
	public void updateEmpinfo(Map<String, String> updateParam) throws Exception{
		
		param = updateParam;
		emp_no = param.get("data[emp_no]");
		
	    System.out.println("updateParam: "+param.toString() );

		updateEmpDptinfo();
		updateEmpEduinfo();
		updateEmpCareerinfo();
		updateEmpBasicinfo();

	}// updateEmpinfo
	

	/**
	 * 
	 * @param param
	 * 사원 기본 정보 수정
	 */
	public void updateEmpBasicinfo() throws Exception{

		Map<String, String> map = new HashMap<>();
		
		map.put("emp_no", emp_no);
		map.put("emp_stts_code", param.get("data[emp_stts_code]"));
		map.put("auth_cls_code", param.get("data[auth_cls_code]"));
		map.put("emp_name", param.get("data[emp_name]"));
		map.put("join_date", param.get("data[join_date]"));
		map.put("rsgn_date", param.get("data[rsgn_date]"));
		map.put("rnk_code", param.get("data[rnk_code]"));
		map.put("comp_email", param.get("data[comp_email]"));
		map.put("cntct_no", param.get("data[cntct_no]"));
		map.put("emp_eng_name", param.get("data[emp_eng_name]"));		
		map.put("emp_chn_name", param.get("data[emp_chn_name]"));
		map.put("brth_date", param.get("data[brth_date]"));
		map.put("gndr_code", param.get("data[gndr_code]"));		
		map.put("zip_code", param.get("data[zip_code]"));
		map.put("home_addr", param.get("data[home_addr]"));
		map.put("home_dtl_no", param.get("data[home_dtl_no]"));
		map.put("psnl_email", param.get("data[psnl_email]"));
		map.put("msvc_cls_code", param.get("data[msvc_cls_code]"));
		map.put("msvc_strt_date", param.get("data[msvc_strt_date]"));
		map.put("msvc_end_date", param.get("data[msvc_end_date]"));		
		map.put("emrg_cntct_no", param.get("data[emrg_cntct_no]"));
		map.put("mrrg_yn", param.get("data[mrrg_yn]"));
		map.put("mrrg_date", param.get("data[mrrg_date]"));
		map.put("proc_emp_no", proc_emp_no);
		
		String rsdn_reg_no = param.get("data[rsdn_reg_no]");
		if(rsdn_reg_no != null && !rsdn_reg_no.equals("")) {
			rsdn_reg_no = AES256Security.encrypt(rsdn_reg_no);
		}else {
			rsdn_reg_no = "";
		}
		map.put("rsdn_reg_no", rsdn_reg_no);

		map = setNull(map);
		
		updateMapper.updateBasic(map);
		
	} // 기본 사항 수정
	
	/**
	 * 
	 * @param param
	 * 사원 부서 소속 정보 수정
	 */
	public void updateEmpDptinfo() {
		
		String[] dpt_code = null;
		String[] dpt_strt_date = null;
		
		//System.out.println(param.get("data[dpt_code]"));
		
		if(param.get("data[dpt_code]") != "" && param.get("data[dpt_code]") != null) {
			
			dpt_code = param.get("data[dpt_code]").split(",");
			dpt_strt_date = param.get("data[dpt_strt_date]").split(",");

			for(int i=0; i<dpt_code.length; i++) {
				
				Map<String, String> map = new HashMap<>();
				
				map.put("dpt_code", dpt_code[i]);
				map.put("aply_strt_date", dpt_strt_date[i]);
				map.put("emp_no", emp_no);
				map.put("proc_emp_no", proc_emp_no);
				map.put("reg_emp_no", proc_emp_no);
				map.put("dpt_role_cls_code", param.get("data[dpt_role_cls_code]"));			
				
				System.out.println("$$$$$$$$$$$");
				System.out.println("$$$$$$$$$$$");
				System.out.println("$$$$$$$$$$$");
				
				System.out.println(map.toString());
				
				updateMapper.updateDpt(map);
			}	
		}
		
		
		
		
	
	} // 부서 소속 정보 수정

		
	/**
	 * 
	 * @param param
	 * 사원 학력 정보 수정
	 */
	public void updateEmpEduinfo() {
	
		List<String> edu_origin_lst = updateMapper.getEdu(emp_no);
		List<String> edu_insert_lst = null;
		if(param.get("edu_insert").equals("")) {
			edu_insert_lst = new ArrayList<>();
		}else {
			edu_insert_lst = new ArrayList<>(Arrays.asList((param.get("edu_insert")).split("/")));
		}
		List<String> edu_del_lst = new ArrayList<>();
		
		Map<String,List<String>> updateData = new HashMap<>();	
		updateData.put("origin_lst", edu_origin_lst);
		updateData.put("insert_lst", edu_insert_lst);
		updateData.put("del_lst", edu_del_lst);
		
		goSQL(updateData, "edu");
		
	} // 학력정보 수정		
	
	/**
	 * 
	 * @param param
	 * 사원 경력 정보 수정
	 */
	public void updateEmpCareerinfo() {
		
		List<String> career_origin_lst = updateMapper.getCareer(emp_no);
		List<String> career_insert_lst = null;
		if(param.get("work_insert").equals("")) {
			career_insert_lst = new ArrayList<>();
		}else {
			career_insert_lst = new ArrayList<>(Arrays.asList((param.get("work_insert")).split("/")));
		}
		List<String> career_del_lst = new ArrayList<>();
		
		Map<String,List<String>> updateData = new HashMap<>();		
		updateData.put("origin_lst", career_origin_lst);
		updateData.put("insert_lst", career_insert_lst);
		updateData.put("del_lst", career_del_lst);
		
		goSQL(updateData, "career");
		
	} // 경력 정보 수정

	public void insert(String check, String i) {
		
		Map<String, String> insertMap = new HashMap<>();	
		
		if(check.equals("career")) {		
			
				insertMap.put("emp_no", emp_no);
				insertMap.put("emp_carr_no", param.get("data[emp_carr_no_"+i+"]"));
				insertMap.put("offc_name", param.get("data[offc_name_"+i+"]"));
				insertMap.put("wrk_cls_code", param.get("data[wrk_cls_code_"+i+"]"));
				insertMap.put("wrk_strt_date", param.get("data[wrk_strt_date_"+i+"]"));
				insertMap.put("wrk_end_date", param.get("data[wrk_end_date_"+i+"]"));
				insertMap.put("wrk_dpt_name", param.get("data[wrk_dpt_name_"+i+"]"));
				insertMap.put("chrg_tsk_cntt", param.get("data[chrg_tsk_cntt_"+i+"]"));
				insertMap.put("rsgn_resn_cntt", param.get("data[rsgn_resn_cntt_"+i+"]"));
				insertMap.put("reg_emp_no", proc_emp_no);
				insertMap.put("proc_emp_no", proc_emp_no);

				updateMapper.insertCareer(insertMap);
			
		}else if(check.equals("edu")) {		
			
				insertMap.put("emp_no", emp_no);
				insertMap.put("emp_accr_no", param.get("data[emp_accr_no_"+i+"]"));
				insertMap.put("schl_name", param.get("data[schl_name_"+i+"]"));
				insertMap.put("entr_date", param.get("data[entr_date_"+i+"]"));
				insertMap.put("grdn_date", param.get("data[grdn_date_"+i+"]"));
				insertMap.put("majr_name", param.get("data[majr_name_"+i+"]"));
				insertMap.put("grad_val01", param.get("data[grad_val01_"+i+"]"));
				insertMap.put("grad_val02", param.get("data[grad_val02_"+i+"]"));
				insertMap.put("grdn_cls_code", param.get("data[grdn_cls_code_"+i+"]"));
				insertMap.put("degr_cls_code", param.get("data[degr_cls_code_"+i+"]"));
				insertMap.put("reg_emp_no", proc_emp_no);
				insertMap.put("proc_emp_no", proc_emp_no);
	
				updateMapper.insertEdu(insertMap);
			}
					
	} //insert
	
	public void update(String check, String i) {
		
		Map<String, String> updateMap = new HashMap<>();	
		
		if(check.equals("career")) {	
			
			updateMap.put("emp_no", emp_no);
			updateMap.put("emp_carr_no", param.get("data[emp_carr_no_"+i+"]"));
			updateMap.put("offc_name", param.get("data[offc_name_"+i+"]"));
			updateMap.put("wrk_cls_code", param.get("data[wrk_cls_code_"+i+"]"));
			updateMap.put("wrk_strt_date", param.get("data[wrk_strt_date_"+i+"]"));
			updateMap.put("wrk_end_date", param.get("data[wrk_end_date_"+i+"]"));
			updateMap.put("wrk_dpt_name", param.get("data[wrk_dpt_name_"+i+"]"));
			updateMap.put("chrg_tsk_cntt", param.get("data[chrg_tsk_cntt_"+i+"]"));
			updateMap.put("rsgn_resn_cntt", param.get("data[rsgn_resn_cntt_"+i+"]"));
			updateMap.put("proc_emp_no", proc_emp_no);
			
			updateMapper.updateCareer(updateMap);

		}else if(check.equals("edu")) {		
			
			updateMap.put("emp_no", emp_no);
			updateMap.put("emp_accr_no", param.get("data[emp_accr_no_"+i+"]"));
			updateMap.put("schl_name", param.get("data[schl_name_"+i+"]"));
			updateMap.put("entr_date", param.get("data[entr_date_"+i+"]"));
			updateMap.put("grdn_date", param.get("data[grdn_date_"+i+"]"));
			updateMap.put("majr_name", param.get("data[majr_name_"+i+"]"));
			updateMap.put("grad_val01", param.get("data[grad_val01_"+i+"]"));
			updateMap.put("grad_val02", param.get("data[grad_val02_"+i+"]"));
			updateMap.put("grdn_cls_code", param.get("data[grdn_cls_code_"+i+"]"));
			updateMap.put("degr_cls_code", param.get("data[degr_cls_code_"+i+"]"));
			updateMap.put("proc_emp_no", proc_emp_no);
			
			updateMapper.updateEdu(updateMap);
			
		}
	} // update

	
	public void goSQL(Map<String,List<String>> updateData, String check) {

		List<String> origin_lst = updateData.get("origin_lst");
		List<String> insert_lst = updateData.get("insert_lst");
		List<String> del_lst = updateData.get("del_lst");
		
		System.out.println("사잊아즞앙잇ㄴ앚사앙지즈즈즞");
		System.out.println(origin_lst.size());
		System.out.println(insert_lst.size());
		System.out.println(del_lst.size());

		if(origin_lst.size() != 0 && insert_lst.size() != 0) {
			
			for(int i=0; i<insert_lst.size(); i++) {
				
				for(int j=0; j<origin_lst.size(); j++) {

					if(insert_lst.get(i).equals(origin_lst.get(j))) {
						
						if(check.equals("career")) {
							update("career", insert_lst.get(i));
							del_lst.add(insert_lst.get(i));
			
						}else if(check.equals("edu")) {							
							update("edu", insert_lst.get(i));
							del_lst.add(insert_lst.get(i));
							
						}
					}
				} //insert for문
			} // orgin for문	
			
			for(int i=0; i<del_lst.size(); i++) {
				origin_lst.remove(del_lst.get(i));
				insert_lst.remove(del_lst.get(i));
			}
			
			if(insert_lst.size() != 0) {		

				for(int i=0; i<insert_lst.size(); i++) {					
					if(check.equals("career")) {						
						insert("career", insert_lst.get(i));
						
					}else if(check.equals("edu")) {						
						insert("edu", insert_lst.get(i));
						
					}
				}
			}
			
			if(origin_lst.size() != 0) {
				
				for(int i=0; i<origin_lst.size(); i++) {
					
					Map<String, String> delMap = new HashMap<>();
					
					if(check.equals("career")) {					
						delMap.put("emp_no", emp_no);
						delMap.put("emp_carr_no", origin_lst.get(i));					
						updateMapper.delCareer(delMap);
						
					}else if(check.equals("edu")) {					
						delMap.put("emp_no", emp_no);
						delMap.put("emp_accr_no", origin_lst.get(i));						
						updateMapper.delEdu(delMap);
					
					}
				}
			}
			
		}else {
			
			System.out.println("일로 왔다네");
			
			// 가져온 건 0인데 원래 값은 있다.
			// delete
			if(insert_lst.size() == 0 && origin_lst.size() != 0) {
				
				Map<String, String> delMap = new HashMap<>();
				
				for(int i=0; i<origin_lst.size(); i++) {				
					if(check.equals("career")) {						
						delMap.put("emp_no", emp_no);
						delMap.put("emp_carr_no", origin_lst.get(i));						
						updateMapper.delCareer(delMap);
						
					}else if(check.equals("edu")) {					
						delMap.put("emp_no", emp_no);
						delMap.put("emp_accr_no", origin_lst.get(i));						
						updateMapper.delEdu(delMap);
						
					}
				}
			
			// 가져온 건 값이 있는데 원래 값은 없다
			//insert
			}else if(insert_lst.size() != 0 && origin_lst.size() == 0){
				System.out.println("여기네 insert에 왔네");
				
				
				for(int i=0; i<insert_lst.size(); i++) {		
					if(check.equals("career")) {							
						insert("career", insert_lst.get(i));		
						
					}else if(check.equals("edu")) {										
						insert("edu", insert_lst.get(i));		
						
					}				
				}			
			}
		}
	}//goSQL

	public Map setNull(Map param) {	
		Set key = param.keySet();
	    for (Iterator iterator = key.iterator(); iterator.hasNext();) {
           String keyName = (String) iterator.next();
           String valueName = (String) param.get(keyName);         
           if(valueName == null) {
        	   param.put(keyName, " ");
           }           
	    }
		return param;
	} //setNull
	
} // class




