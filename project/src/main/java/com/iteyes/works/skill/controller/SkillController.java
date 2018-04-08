package com.iteyes.works.skill.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.iteyes.works.skill.service.SkillService;

@Controller
public class SkillController implements ISkillController{
	
	
	@Autowired
	private SkillService skillService;
	
	@Override
	public String Skill() {
		
		//model.setViewName("/skillList");
		
		return "/skillList";
	}
	
	
/*
	@Override
	public ModelAndView Skill(ModelAndView model) {
		
		model.setViewName("/skillList");
		
		return model;
	}
	*/
	
	

}
