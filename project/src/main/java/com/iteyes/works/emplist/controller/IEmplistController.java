package com.iteyes.works.emplist.controller;


import java.util.Map;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

public interface IEmplistController {
	

	@RequestMapping("/emplist")
	public String emplist(Model model, @RequestParam("page") int page);
	
	@RequestMapping(value="/emplist/search", method=RequestMethod.POST)
	public String emplistSearch(Model model, @RequestParam("page") int page,
				@RequestParam("empSearchText") String searchText, @RequestParam("empSearchDrop") String searchDrop);

}