package com.iteyes.works.index.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.iteyes.works.index.controller.IIndexController;
import com.iteyes.works.index.service.IndexService;


@Controller
public class IndexController implements IIndexController{
	
	@Autowired
	IndexService indexservice;

	@Override
	public String index(Model model, @RequestParam("id") String id) {
		
		Map topinfo = indexservice.getTopInfo(id);		
		model.addAttribute("topinfo",topinfo);
		
		return "/index";
	}

}
