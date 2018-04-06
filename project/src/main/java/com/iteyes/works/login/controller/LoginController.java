package com.iteyes.works.login.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.iteyes.works.login.controller.ILoginController;
import com.iteyes.works.login.service.LoginService;


@Controller
public class LoginController implements ILoginController {
 
	@Autowired
	private LoginService loginService;

	@Override
	public String login() {		
		return "/login";
	}
	
	@Override
	public @ResponseBody String logincheck(Model model, HttpSession session , @RequestParam Map param) {	
		int logincheck = loginService.login(param);
		
		model.addAttribute("logincheck",logincheck);
		
		if(logincheck == 1) {
			HashMap<String, String> map = loginService.selectSessionInfo((String)param.get("id"));
			session.setAttribute("emp_no", map.get("EMP_NO"));
			session.setAttribute("auth_code", map.get("AUTH_CLS_CODE"));
			session.setAttribute("emp_name", map.get("EMP_NAME"));
		}
		
		return logincheck+"";
	}

	@Override
	public @ResponseBody String logout(HttpSession session) {
		
		session.removeAttribute("emp_no");
		session.removeAttribute("emp_name");
		session.removeAttribute("auth_code");
		
		String result = "";
		if( session.getAttribute("emp_no") == null) {
			result = "success";
		}else {
			result = "fail";
		}
		
		return result;
	}

}




