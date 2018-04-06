package com.iteyes.works.skill.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

import com.iteyes.works.skill.service.SkillService;

@Controller
public class SkillController implements ISkillController{
	
	
	@Autowired
	private SkillService skillService;

	@Override
	public String Skill(Model model) {
		
		model.addAttribute("searchDrop", "선택");
		
		return "/skill";
	}
	
	
	

}
