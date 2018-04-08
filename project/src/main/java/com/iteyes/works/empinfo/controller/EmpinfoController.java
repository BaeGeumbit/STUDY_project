package com.iteyes.works.empinfo.controller;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.iteyes.works.empinfo.service.EmpinfoService;
import com.iteyes.works.util.AES256Security;

@Controller
public class EmpinfoController implements IEmpinfoController{
	 
	@Autowired
	private EmpinfoService empinfoService;	
	
	
	public Model getEmpinfo(Model model, String emp_no, String check) throws Exception{
		
		Map<String, List<Map<String, String>>> groupCode = empinfoService.getGroupCode();	
		Map<String, String> empBasicinfo = empinfoService.getEmpBasicinfo(emp_no);

		if(empBasicinfo.get("RSDN_REG_NO") != null && ! empBasicinfo.get("RSDN_REG_NO").equals("")) {
			String reg_no = empBasicinfo.get("RSDN_REG_NO");
			reg_no = AES256Security.decrypt(reg_no);
			empBasicinfo.put("RSDN_REG_NO", reg_no);
		}
		model.addAttribute("groupCode", groupCode);	
		model.addAttribute("empBasicinfo", empBasicinfo);
		
		List<Map<String, String>> grdn_lst = groupCode.get("GRDN_CLS_CODE");
		List<Map<String, String>> degr_lst = groupCode.get("DEGR_CLS_CODE");
		List<Map<String, String>> wrk_lst = groupCode.get("WRK_CLS_CODE");
		String grdn_str = "";
		String degr_str = "";
		String wrk_str = "";
		String key = "CODE_ID";
		String name = "CODE_NAME";
		
		for(int i=0; i<grdn_lst.size(); i++) {
			grdn_str += "<option value='"+grdn_lst.get(i).get(key)+"'>" 		
		             +  grdn_lst.get(i).get(name)
		             +  "</option>";
		}
		for(int i=0; i<degr_lst.size(); i++) {
			degr_str += "<option value='"+degr_lst.get(i).get(key)+"'>" 		
		             +  degr_lst.get(i).get(name)
		             +  "</option>";
		}
		for(int i=0; i<wrk_lst.size(); i++) {
			wrk_str += "<option value='"+wrk_lst.get(i).get(key)+"'>" 		
		             +  wrk_lst.get(i).get(name)
		             +  "</option>";
		}
		model.addAttribute("grdn_str",grdn_str);
		model.addAttribute("degr_str",degr_str);
		model.addAttribute("wrk_str",wrk_str);
		
		if(check.equals("old")) {
			List<HashMap<String, String>> empEducationinfo = empinfoService.getEducationinfo(emp_no);
			List<HashMap<String, String>> empCareerinfo = empinfoService.getCareerinfo(emp_no);
			
			model.addAttribute("empEducationinfo", empEducationinfo);
			model.addAttribute("empCareerinfo", empCareerinfo);
		}
		
		
		return model;
	}
	
	/**
	 *  사원 상세 정보
	 */
	@Override
	public String empinfo(Model model, String emp_no) throws Exception{
		
		getEmpinfo(model, emp_no , "old");
		
		model.addAttribute("first_check", "old");
		
		return "/empinfo";
	}
	
	/**
	 * 사원 신규 등록
	 */
	@Override
	public String newMember(Model model, Model model2) throws Exception{
		
		String new_emp_no = empinfoService.getNewEmpNo();

		//세션아이디로 바꾸기
		getEmpinfo(model, "2" , "new");
		
		Map basicMap =  (Map) model.asMap().get("empBasicinfo");
		Set key = basicMap.keySet();
		//String new_id = "new";
		
	    for (Iterator iterator = key.iterator(); iterator.hasNext();) {
	           String keyName = (String) iterator.next();
	           //String valueName = (String) basicMap.get(keyName);
	           if(keyName.equals("EMP_NO")) {
	        	   basicMap.put(keyName, new_emp_no);
	           }else {
	        	   basicMap.put(keyName, "");
	           }
	           
	           //System.out.println(keyName +" = " +valueName);
	    }

	    model.addAttribute("empBasicinfo", basicMap);
	    model.addAttribute("first_check", "new");
		model.addAttribute("new_emp_no", new_emp_no);
		
		System.out.println("----------------------");
		System.out.println("----------------------");
		System.out.println("----------------------");
		
		System.out.println(model.asMap().get("empBasicinfo").toString());
		System.out.println(model.asMap().get("first_check"));
		
		return "/empinfo";
	}
	
	
	
	@Override
	public String address(Model model) {
	
		return "/address";
	}

	@Override
	public List<Map<String,String>> searchAddr(@RequestParam Map param) {
		
		String textparam = (String) param.get("searchAddr");
		
		List<Map<String,String>> addrlist = empinfoService.getAddr(textparam);
		
		return addrlist;
	}

	@Override
	public String dpt(Model model, @RequestParam("dpt_name") String dpt_name) {
		
		model.addAttribute("searchDrop", "선택");
		model.addAttribute("searchText","");
		model.addAttribute("dpt_name", dpt_name);
		
		//System.out.println(emp_no);
		
		return "/dpt";
	}
	
	/**
	 * 부서 검색
	 */
	@Override
	public @ResponseBody Map<String, List<Map<String, ?>>> getDptinfo(@RequestParam Map<String, String> param) {

		
	
		/*if(param.get("searchDrop") != null && param.get("searchText") != null) {
			if(param.get("searchDrop").equals("DPT_CODE")) {
				dptParam.put("dpt_no", param.get("searchText"));
				dptParam.put("dpt_name", "");
				
			}else if(param.get("searchDrop").equals("DPT_NAME")) {
				dptParam.put("dpt_no", "");
				dptParam.put("dpt_name", param.get("searchText"));
				
			}else {
				dptParam.put("dpt_no", "");
				dptParam.put("dpt_name", "");
			}
		}else {
			dptParam.put("dpt_no", "");
			dptParam.put("dpt_name", "");
		}*/
	
		Map<String, List<Map<String, ?>>> list = empinfoService.getDpt(param);
		
		return list;
	}
	
	@Override
	public int join(@RequestParam Map<String, String> param) throws Exception{
		
		int result = empinfoService.join(param);
		
		return result;
	}
	
}











