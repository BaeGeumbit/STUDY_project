package com.iteyes.works.login.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

public interface ILoginController {

	
	@RequestMapping("/login")
	public String login();
	
	@RequestMapping(value="/login/check", method=RequestMethod.POST)
	public @ResponseBody String logincheck(Model model, HttpSession session ,@RequestParam Map param);
	
	@RequestMapping("/logout")
	@ResponseBody
	public String logout(HttpSession session);
	
}
