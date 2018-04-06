package com.iteyes.works.index.controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

public interface IIndexController {
	
	@RequestMapping("/index")
	public String index(Model model, @RequestParam("id") String id);
}
