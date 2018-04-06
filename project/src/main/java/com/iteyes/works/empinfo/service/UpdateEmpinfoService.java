package com.iteyes.works.empinfo.service;

import java.util.ArrayList;
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

	/**
	 * 
	 * @param param
	 * 사원 정보 수정
	 */
	public void updateEmpinfo(Map<?, ?> param) throws Exception{

		//updateEmpDptinfo(param);
		//updateEmpEduinfo(param);
		updateEmpCareerinfo(param);
		//updateEmpBasicinfo(param);
		
	}// updateEmpinfo
	
	public Map setNull(Map param) {
		
		Set key = param.keySet();
	    for (Iterator iterator = key.iterator(); iterator.hasNext();) {
	           String keyName = (String) iterator.next();
	           String valueName = (String) param.get(keyName);
	           
	           if(valueName == null) {
	        	   param.put(keyName, " ");
	           }           
	           //System.out.println(keyName +" = " +valueName);
	    }
		return param;
	}
	
	/**
	 * 
	 * @param param
	 * 사원 기본 정보 수정
	 */
	public int updateEmpBasicinfo(Map<?, ?> param) throws Exception{
		
		String emp_no = (String) param.get("emp_no");

		Map<String, String> map = new HashMap<>();
		map.put("emp_no", emp_no);
		map.put("emp_stts_code", (String)param.get("basicInfo[emp_stts_code]"));
		map.put("auth_cls_code", (String)param.get("basicInfo[auth_cls_code]"));
		map.put("emp_name", (String)param.get("basicInfo[emp_name]"));
		map.put("join_date", (String)param.get("basicInfo[join_date]"));
		map.put("rsgn_date", (String)param.get("basicInfo[rsgn_date]"));
		map.put("rnk_code", (String)param.get("basicInfo[rnk_code]"));
		map.put("comp_email", (String)param.get("basicInfo[comp_email]"));
		map.put("cntct_no", (String)param.get("basicInfo[cntct_no]"));
		map.put("emp_eng_name", (String)param.get("basicInfo[emp_eng_name]"));
		
		map.put("emp_chn_name", (String)param.get("basicInfo[emp_chn_name]"));
		map.put("brth_date", (String)param.get("basicInfo[brth_date]"));
		map.put("gndr_code", (String)param.get("basicInfo[gndr_code]"));		
		map.put("zip_code", (String)param.get("basicInfo[zip_code]"));
		map.put("home_addr", (String)param.get("basicInfo[home_addr]"));
		map.put("home_dtl_no", (String)param.get("basicInfo[home_dtl_no]"));
		map.put("psnl_email", (String)param.get("basicInfo[psnl_email]"));
		map.put("msvc_cls_code", (String)param.get("basicInfo[msvc_cls_code]"));
		map.put("msvc_strt_date", (String)param.get("basicInfo[msvc_strt_date]"));
		map.put("msvc_end_date", (String)param.get("basicInfo[msvc_end_date]"));
		
		map.put("emrg_cntct_no", (String)param.get("basicInfo[emrg_cntct_no]"));
		map.put("mrrg_yn", (String)param.get("basicInfo[mrrg_yn]"));
		map.put("mrrg_date", (String)param.get("basicInfo[mrrg_date]"));
		map.put("proc_emp_no", proc_emp_no);
		
		String rsdn_reg_no = (String)param.get("basicInfo[rsdn_reg_no]");
		if(rsdn_reg_no != null && !rsdn_reg_no.equals("")) {
			rsdn_reg_no = AES256Security.encrypt(rsdn_reg_no);
		}
		map.put("rsdn_reg_no", rsdn_reg_no);
		
		map = setNull(map);
		
		int basicResult = updateMapper.updateBasic(map);
		
		return basicResult;
		
	} // 기본 사항 수정
		
	/**
	 * 
	 * @param param
	 * 사원 부서 소속 정보 수정
	 */
	public void updateEmpDptinfo(Map<?, ?> param) {
		
		String emp_no = (String) param.get("emp_no");
		
		System.out.println("사원번호: "+emp_no);
		
		// 1.1 수정 전 사원의 부서 정보를 들고 온다.
		List<String> lst = updateMapper.getEmpDpt(emp_no);
		
		// 1.2 수정하기 위해 들고온 String을 List로 변환.
		String dpt_val = (String)param.get("dptInfo");
		List<String> dpt_arr = new ArrayList<>();
		
		if(dpt_val != null && ! dpt_val.equals("")) {
			String[] dpt_split = dpt_val.split(",");
			for(int i=0; i<dpt_split.length; i++) {
				dpt_arr.add(dpt_split[i]);
			}
		}

		// 둘다 값이 있다
		// 비교해서 update / delete / insert
		if(dpt_arr.size() != 0 && lst.size() != 0) {
			
			for(int i=0; i<dpt_arr.size(); i++) {
				for(int j=0; j<lst.size(); j++) {
					if(dpt_arr.size() != 0 && lst.size() != 0) {
						if(dpt_arr.get(i).equals(lst.get(j))) {
							
							System.out.println("$$$$$$$$$$$$$$");
							System.out.println("$$$$$$$$$$$$$$");
							System.out.println("$$$$$$$$$$$$$$");
							System.out.println("$$$$$$$$$$$$$$");
							
							System.out.println("updatePage 진입");
							
							Map<String, String> map = updateMapper.getDetailDpt(dpt_arr.get(i));					
							Map<String, String> updateMap = new HashMap<>();
							
							updateMap.put("emp_no", emp_no);
							updateMap.put("dpt_code", map.get("DPT_CODE"));
							updateMap.put("aply_strt_date", map.get("APLY_STRT_DATE"));
							updateMap.put("aply_end_date", map.get("APLY_END_DATE"));
							updateMap.put("proc_emp_no", proc_emp_no);
							updateMap.put("dpt_role_cls_code", (String)param.get("basicInfo[dpt_role_cls_code]"));
							
							updateMapper.updateDpt(updateMap);
							
							dpt_arr.remove(dpt_arr.get(i));
							lst.remove(lst.get(j));
							
							System.out.println("update 후 insert할 list : "+dpt_arr.toString());
							System.out.println("update 후 delete할 list : "+lst.toString());
						}
					}
				}
			}		
			
			if(dpt_arr.size() != 0) {		
				// dpt_arr로 추가
				for(int i=0; i<dpt_arr.size(); i++) {
					
					/*System.out.println("@@@@@@@@@@@@@@");
					System.out.println("@@@@@@@@@@@@@@");
					System.out.println("@@@@@@@@@@@@@@");
					System.out.println("@@@@@@@@@@@@@@");
					
					System.out.println("insertPage 진입");*/
					
					Map<String, String> map = updateMapper.getDetailDpt(dpt_arr.get(i));
					Map<String, String> insertMap = new HashMap<>();
					insertMap.put("emp_no", emp_no);
					insertMap.put("dpt_code", map.get("DPT_CODE"));
					insertMap.put("dpt_role_cls_code", (String)param.get("basicInfo[dpt_role_cls_code]"));
					insertMap.put("aply_strt_date", map.get("APLY_STRT_DATE"));
					insertMap.put("aply_end_date", map.get("APLY_END_DATE"));
					insertMap.put("reg_emp_no", "2");
					insertMap.put("proc_emp_no", proc_emp_no);
					
					updateMapper.insertDpt(insertMap);
				}
			}
			
			if(lst.size() != 0) {
				// lst로 삭제
				for(int i=0; i<lst.size(); i++) {
					
					Map<String, String> delMap = new HashMap<>();
					delMap.put("emp_no", emp_no);
					delMap.put("dpt_name", lst.get(i));
					
					updateMapper.delDpt(delMap);
				}
			}
		}else {
			
			// 가져온 건 0인데 원래 값은 있다.
			// delete
			if(dpt_arr.size() == 0 && lst.size() != 0) {
				for(int i=0; i<lst.size(); i++) {
					
					Map<String, String> delMap = new HashMap<>();
					delMap.put("emp_no", emp_no);
					delMap.put("dpt_name", lst.get(i));
					
					updateMapper.delDpt(delMap);
				}
			
			// 가져온 건 값이 있는데 원래 값은 없다
			//insert
			}else if(dpt_arr.size() != 0 && lst.size() == 0){
				
				for(int i=0; i<dpt_arr.size(); i++) {
					
					Map<String, String> map = updateMapper.getDetailDpt(dpt_arr.get(i));
	
					Map<String, String> insertMap = new HashMap<>();
					insertMap.put("emp_no", emp_no);
					insertMap.put("dpt_code", map.get("DPT_CODE"));
					insertMap.put("dpt_role_cls_code", (String)param.get("basicInfo[dpt_role_cls_code]"));
					insertMap.put("aply_strt_date", map.get("APLY_STRT_DATE"));
					insertMap.put("aply_end_date", map.get("APLY_END_DATE"));
					insertMap.put("reg_emp_no", "2");
					insertMap.put("proc_emp_no", proc_emp_no);
					
					insertMap = setNull(insertMap);
					
					//System.out.println("insertMap 입니다 : "+insertMap.toString());
					
					updateMapper.insertDpt(insertMap);
				}
			// 둘다 값이 없따
			// 아무것도 하지마
			}else if(dpt_arr.size() == 0 && lst.size() == 0){
				
			}
		}

	} // 부서 소속 정보 수정
	
	
	/**
	 * 
	 * @param param
	 * 사원 경력 정보 수정
	 */
	public void updateEmpCareerinfo(Map<?, ?> param) {
		
		String emp_no = (String) param.get("emp_no");
		String insert = (String)param.get("work_insert");
		
		// 현재 db에 있는 경력 번호 리스트
		List<String> carr_origin_lst = updateMapper.getCareer(emp_no);
		
		String[] in_split = insert.split("/");		
		List<String> insert_lst = new ArrayList<>();
		for(int i=0; i<in_split.length; i++) {			
			insert_lst.add(in_split[i]);
		}	

		System.out.println("경력사항 원본 리스트 ; "+carr_origin_lst.toString());
		System.out.println("경력사항 가져온 리스트 ; "+insert_lst.toString());
		
		if(carr_origin_lst.size() != 0 && insert_lst.size() != 0) {
			
			for(int i=0; i<insert_lst.size(); i++) {
				
				for(int j=0; j<carr_origin_lst.size(); j++) {
					
					
					
					if(carr_origin_lst.size() != 0 && insert_lst.size() != 0) {			
						
						
						if(insert_lst.get(i).equals(carr_origin_lst.get(j))) {
							
							//update
							Map<String, String> updateMap = new HashMap<>();	
							
							updateMap.put("emp_no", (String)param.get("workInfo["+insert_lst.get(i)+"][emp_no]"));
							updateMap.put("emp_carr_no", (String)param.get("workInfo["+insert_lst.get(i)+"][emp_carr_no]"));
							updateMap.put("offc_name", (String)param.get("workInfo["+insert_lst.get(i)+"][offc_name]"));
							updateMap.put("wrk_cls_code", (String)param.get("workInfo["+insert_lst.get(i)+"][wrk_cls_code]"));
							updateMap.put("wrk_strt_date", (String)param.get("workInfo["+insert_lst.get(i)+"][wrk_strt_date]"));
							updateMap.put("wrk_end_date", (String)param.get("workInfo["+insert_lst.get(i)+"][wrk_end_date]"));
							updateMap.put("wrk_dpt_name", (String)param.get("workInfo["+insert_lst.get(i)+"][wrk_dpt_name]"));
							updateMap.put("chrg_tsk_cntt", (String)param.get("workInfo["+insert_lst.get(i)+"][chrg_tsk_cntt]"));
							updateMap.put("rsgn_resn_cntt", (String)param.get("workInfo["+insert_lst.get(i)+"][rsgn_resn_cntt]"));
							updateMap.put("proc_emp_no", proc_emp_no);
							
							System.out.println("updATE 11:"+updateMap.toString());
							//updateMap = setNull(updateMap);
							
							updateMapper.updateCareer(updateMap);
							
							carr_origin_lst.remove(carr_origin_lst.get(j));
							insert_lst.remove(insert_lst.get(i));
							
						}
					}
				}
			}	
			
			System.out.println("나왔당");
			System.out.println(carr_origin_lst.size()+"사이주사이주"+insert_lst.size());
			if(insert_lst.size() != 0) {		
				// dpt_arr로 추가
				for(int i=0; i<insert_lst.size(); i++) {
					Map<String, String> insertMap = new HashMap<>();
					
					insertMap.put("emp_no", (String)param.get("workInfo["+insert_lst.get(i)+"][emp_no]"));
					insertMap.put("emp_carr_no", (String)param.get("workInfo["+insert_lst.get(i)+"][emp_carr_no]"));
					insertMap.put("offc_name", (String)param.get("workInfo["+insert_lst.get(i)+"][offc_name]"));
					insertMap.put("wrk_cls_code", (String)param.get("workInfo["+insert_lst.get(i)+"][wrk_cls_code]"));
					insertMap.put("wrk_strt_date", (String)param.get("workInfo["+insert_lst.get(i)+"][wrk_strt_date]"));
					insertMap.put("wrk_end_date", (String)param.get("workInfo["+insert_lst.get(i)+"][wrk_end_date]"));
					insertMap.put("wrk_dpt_name", (String)param.get("workInfo["+insert_lst.get(i)+"][wrk_dpt_name]"));
					insertMap.put("chrg_tsk_cntt", (String)param.get("workInfo["+insert_lst.get(i)+"][chrg_tsk_cntt]"));
					insertMap.put("rsgn_resn_cntt", (String)param.get("workInfo["+insert_lst.get(i)+"][rsgn_resn_cntt]"));
					insertMap.put("reg_emp_no", proc_emp_no);
					insertMap.put("proc_emp_no", proc_emp_no);
					
					insertMap = setNull(insertMap);
					
					System.out.println("경력정보 insertMap입니다1111 : "+insertMap.toString());			
					updateMapper.insertCareer(insertMap);
				}
			}
			
			if(carr_origin_lst.size() != 0) {
				// lst로 삭제
				for(int i=0; i<carr_origin_lst.size(); i++) {

					Map<String, String> delMap = new HashMap<>();
					delMap.put("emp_no", emp_no);
					delMap.put("emp_carr_no", carr_origin_lst.get(i));
					
					updateMapper.delCareer(delMap);
				}
			}
		}else {
			
			// 가져온 건 0인데 원래 값은 있다.
			// delete
			if(insert_lst.size() == 0 && carr_origin_lst.size() != 0) {
				for(int i=0; i<carr_origin_lst.size(); i++) {
					
					Map<String, String> delMap = new HashMap<>();
					delMap.put("emp_no", emp_no);
					delMap.put("emp_carr_no", carr_origin_lst.get(i));
					
					updateMapper.delCareer(delMap);
				}
			
			// 가져온 건 값이 있는데 원래 값은 없다
			//insert
			}else if(insert_lst.size() != 0 && carr_origin_lst.size() == 0){
				
				for(int i=0; i<insert_lst.size(); i++) {
					Map<String, String> insertMap = new HashMap<>();
					
					insertMap.put("emp_no", (String)param.get("workInfo["+insert_lst.get(i)+"][emp_no]"));
					insertMap.put("emp_carr_no", (String)param.get("workInfo["+insert_lst.get(i)+"][emp_carr_no]"));
					insertMap.put("offc_name", (String)param.get("workInfo["+insert_lst.get(i)+"][offc_name]"));
					insertMap.put("wrk_cls_code", (String)param.get("workInfo["+insert_lst.get(i)+"][wrk_cls_code]"));
					insertMap.put("wrk_strt_date", (String)param.get("workInfo["+insert_lst.get(i)+"][wrk_strt_date]"));
					insertMap.put("wrk_end_date", (String)param.get("workInfo["+insert_lst.get(i)+"][wrk_end_date]"));
					insertMap.put("wrk_dpt_name", (String)param.get("workInfo["+insert_lst.get(i)+"][wrk_dpt_name]"));
					insertMap.put("chrg_tsk_cntt", (String)param.get("workInfo["+insert_lst.get(i)+"][chrg_tsk_cntt]"));
					insertMap.put("rsgn_resn_cntt", (String)param.get("workInfo["+insert_lst.get(i)+"][rsgn_resn_cntt]"));
					insertMap.put("reg_emp_no", proc_emp_no);
					insertMap.put("proc_emp_no", proc_emp_no);
					
					insertMap = setNull(insertMap);
					
					System.out.println("경력정보 insertMap입니다2 : "+insertMap.toString());	
					updateMapper.insertCareer(insertMap);
				}
			// 둘다 값이 없따
			// 아무것도 하지마
			}else if(insert_lst.size() == 0 && carr_origin_lst.size() == 0){
				
			}
		}
		
	} // 경력 정보 수정
	
	
	/**
	 * 
	 * @param param
	 * 사원 학력 정보 수정
	 */
	public void updateEmpEduinfo(Map<?, ?> param) {
		
		String emp_no = (String) param.get("emp_no");
		String del = (String) param.get("edu_del");
		String insert = (String)param.get("edu_insert");
		
		// 현재 db에 있는 학력번호 리스트
		List<String> edu_origin_lst = updateMapper.getEdu(emp_no);

		String[] in_split = insert.split("/");		
		List<String> insert_lst = new ArrayList<>();
		for(int i=0; i<in_split.length; i++) {			
			insert_lst.add(in_split[i]);
		}
		
		if(edu_origin_lst.size() != 0 && insert_lst.size() != 0) {
			
			for(int i=0; i<insert_lst.size(); i++) {
				for(int j=0; j<edu_origin_lst.size(); j++) {
					if(edu_origin_lst.size() != 0 && insert_lst.size() != 0) {	
						if(insert_lst.get(i).equals(edu_origin_lst.get(j))) {
							//update
							Map<String, String> updateMap = new HashMap<>();	
							
							updateMap.put("emp_no", (String)param.get("eduInfo["+insert_lst.get(i)+"][emp_no]"));
							updateMap.put("emp_accr_no", (String)param.get("eduInfo["+insert_lst.get(i)+"][emp_accr_no]"));
							updateMap.put("schl_name", (String)param.get("eduInfo["+insert_lst.get(i)+"][schl_name]"));
							updateMap.put("entr_date", (String)param.get("eduInfo["+insert_lst.get(i)+"][entr_date]"));
							updateMap.put("grdn_date", (String)param.get("eduInfo["+insert_lst.get(i)+"][grdn_date]"));
							updateMap.put("majr_name", (String)param.get("eduInfo["+insert_lst.get(i)+"][majr_name]"));
							updateMap.put("grad_val01", (String)param.get("eduInfo["+insert_lst.get(i)+"][grad_val01]"));
							updateMap.put("grad_val02", (String)param.get("eduInfo["+insert_lst.get(i)+"][grad_val02]"));
							updateMap.put("grdn_cls_code", (String)param.get("eduInfo["+insert_lst.get(i)+"][grdn_cls_code]"));
							updateMap.put("degr_cls_code", (String)param.get("eduInfo["+insert_lst.get(i)+"][degr_cls_code]"));
							updateMap.put("proc_emp_no", proc_emp_no);
							
							updateMap = setNull(updateMap);
							
							updateMapper.updateEdu(updateMap);
							
							System.out.println("학력정보 updateMap입니다1111 : "+updateMap.toString());
							edu_origin_lst.remove(edu_origin_lst.get(j));
							insert_lst.remove(insert_lst.get(i));
						}
					}
				}
			}		
			
			if(insert_lst.size() != 0) {		
				// dpt_arr로 추가
				for(int i=0; i<insert_lst.size(); i++) {
					Map<String, String> insertMap = new HashMap<>();
					
					insertMap.put("emp_no", (String)param.get("eduInfo["+insert_lst.get(i)+"][emp_no]"));
					insertMap.put("emp_accr_no", (String)param.get("eduInfo["+insert_lst.get(i)+"][emp_accr_no]"));
					insertMap.put("schl_name", (String)param.get("eduInfo["+insert_lst.get(i)+"][schl_name]"));
					insertMap.put("entr_date", (String)param.get("eduInfo["+insert_lst.get(i)+"][entr_date]"));
					insertMap.put("grdn_date", (String)param.get("eduInfo["+insert_lst.get(i)+"][grdn_date]"));
					insertMap.put("majr_name", (String)param.get("eduInfo["+insert_lst.get(i)+"][majr_name]"));
					insertMap.put("grad_val01", (String)param.get("eduInfo["+insert_lst.get(i)+"][grad_val01]"));
					insertMap.put("grad_val02", (String)param.get("eduInfo["+insert_lst.get(i)+"][grad_val02]"));
					insertMap.put("grdn_cls_code", (String)param.get("eduInfo["+insert_lst.get(i)+"][grdn_cls_code]"));
					insertMap.put("degr_cls_code", (String)param.get("eduInfo["+insert_lst.get(i)+"][degr_cls_code]"));
					insertMap.put("reg_emp_no", proc_emp_no);
					insertMap.put("proc_emp_no", proc_emp_no);
					System.out.println("학력정보 insertMap입니다1111 : "+insertMap.toString());
					
					insertMap = setNull(insertMap);
					
					updateMapper.insertEdu(insertMap);
				}
			}
			
			if(edu_origin_lst.size() != 0) {
				// lst로 삭제
				for(int i=0; i<edu_origin_lst.size(); i++) {
					
					Map<String, String> delMap = new HashMap<>();
					delMap.put("emp_no", emp_no);
					delMap.put("emp_accr_no", edu_origin_lst.get(i));
					
					updateMapper.delEdu(delMap);
				}
			}
		}else {
			
			// 가져온 건 0인데 원래 값은 있다.
			// delete
			if(insert_lst.size() == 0 && edu_origin_lst.size() != 0) {
				for(int i=0; i<edu_origin_lst.size(); i++) {

					Map<String, String> delMap = new HashMap<>();
					delMap.put("emp_no", emp_no);
					delMap.put("emp_accr_no", edu_origin_lst.get(i));
					
					updateMapper.delEdu(delMap);
				}
			
			// 가져온 건 값이 있는데 원래 값은 없다
			//insert
			}else if(insert_lst.size() != 0 && edu_origin_lst.size() == 0){
				
				for(int i=0; i<insert_lst.size(); i++) {
					
					Map<String, String> insertMap = new HashMap<>();
					
					insertMap.put("emp_no", (String)param.get("eduInfo["+insert_lst.get(i)+"][emp_no]"));
					insertMap.put("emp_accr_no", (String)param.get("eduInfo["+insert_lst.get(i)+"][emp_accr_no]"));
					insertMap.put("schl_name", (String)param.get("eduInfo["+insert_lst.get(i)+"][schl_name]"));
					insertMap.put("entr_date", (String)param.get("eduInfo["+insert_lst.get(i)+"][entr_date]"));
					insertMap.put("grdn_date", (String)param.get("eduInfo["+insert_lst.get(i)+"][grdn_date]"));
					insertMap.put("majr_name", (String)param.get("eduInfo["+insert_lst.get(i)+"][majr_name]"));
					insertMap.put("grad_val01", (String)param.get("eduInfo["+insert_lst.get(i)+"][grad_val01]"));
					insertMap.put("grad_val02", (String)param.get("eduInfo["+insert_lst.get(i)+"][grad_val02]"));
					insertMap.put("grdn_cls_code", (String)param.get("eduInfo["+insert_lst.get(i)+"][grdn_cls_code]"));
					insertMap.put("degr_cls_code", (String)param.get("eduInfo["+insert_lst.get(i)+"][degr_cls_code]"));
					insertMap.put("reg_emp_no", proc_emp_no);
					insertMap.put("proc_emp_no", proc_emp_no);
					
					insertMap = setNull(insertMap);
					
					System.out.println("학력정보 insertMap입니다2222 : "+insertMap.toString());
					
					updateMapper.insertEdu(insertMap);
				}
			// 둘다 값이 없따
			// 아무것도 하지마
			}else if(insert_lst.size() == 0 && edu_origin_lst.size() == 0){
				
			}
		}
		
	} // 학력정보 수정

} // class




