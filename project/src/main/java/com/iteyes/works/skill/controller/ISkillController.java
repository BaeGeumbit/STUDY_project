package com.iteyes.works.skill.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

public interface ISkillController {
	
	
	@RequestMapping("/skillList")
	public String Skill();
	
	

}
