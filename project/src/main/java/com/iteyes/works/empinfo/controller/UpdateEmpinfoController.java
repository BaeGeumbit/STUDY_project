package com.iteyes.works.empinfo.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.iteyes.works.empinfo.service.UpdateEmpinfoService;

@Controller
public class UpdateEmpinfoController {
	
	@Autowired 
	private UpdateEmpinfoService updateService;
	
	@RequestMapping("/updateEmpinfo")
	@ResponseBody
	public String updateEmpinfo(@RequestParam Map<?, ?> param) throws Exception{
	
		updateService.updateEmpinfo(param);
		
		System.out.println("^^^^^^^*********");
		System.out.println("^^^^^^^*********");
		System.out.println("^^^^^^^*********");
		
		
		return null;
	}
	
}










