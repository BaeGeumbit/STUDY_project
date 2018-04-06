package com.iteyes.works.skill.controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

public interface ISkillController {
	
	
	@RequestMapping("/skill")
	public String Skill(Model model);
	
	

}
