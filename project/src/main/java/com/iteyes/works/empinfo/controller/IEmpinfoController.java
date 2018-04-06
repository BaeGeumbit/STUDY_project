package com.iteyes.works.empinfo.controller;

import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

public interface IEmpinfoController {

	@RequestMapping("/empinfo")
	public String empinfo(Model model, @RequestParam("emp_no") String emp_no) throws Exception;

	@RequestMapping("/empinfo/address")
	public String address(Model model);
	
	@RequestMapping(value="/address", method=RequestMethod.POST)
	@ResponseBody
	public List<Map<String,String>> searchAddr(@RequestParam Map param);
	
	@RequestMapping(value="/empinfo/dpt", method=RequestMethod.GET)
	public String dpt(Model model, @RequestParam("emp_no") String emp_no);
	
	@RequestMapping("/dpt/search")
	public Map<String, List<Map<String, ?>>> getDptinfo(@RequestParam Map<String, String> param);
	
	@RequestMapping("/newMember") 
	public String newMember(Model model,  Model model2) throws Exception;
	
	@RequestMapping(value="/join", method=RequestMethod.POST)
	@ResponseBody
	public int join(@RequestParam Map<String, String> param) throws Exception;

}
