package com.iteyes.works.emplist.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

import com.iteyes.works.emplist.controller.IEmplistController;
import com.iteyes.works.emplist.service.EmplistService;

@Controller
public class EmplistController implements IEmplistController{

	@Autowired
	private EmplistService emplistService;
	
	private int row = 10;			// 한 페이지당 나올 row 개수
	private int pageSize = 5;		// 페이징할 사이즈
//	private int totalCount = 0;		// 사원목록 총 개수
//	private int totalPage = 0;		// 페이지 총 개수
// 
//	private int startPage = 0;		// 시작 페이지
//	private int endPage = 0;		// 마지막 페이지
//
//	private boolean pre = false;	// <<(이전페이지) 보여줄건지
//	private boolean next = false;	// >>(다음페이지)
	
	/**
	 *  사원 목록 조회
	 *  페이징 처리
	 */
	@Override
	public String emplist(Model model, @RequestParam("page") int page) {
		
		int totalCount = 0;		// 사원목록 총 개수
		int totalPage = 0;		// 페이지 총 개수
	 
		int startPage = 0;		// 시작 페이지
		int endPage = 0;		// 마지막 페이지
	
		boolean pre = false;	// <<(이전페이지) 보여줄건지
		boolean next = false;	// >>(다음페이지)
		
		Map<String, Integer> pageParam = new HashMap<>();		
		pageParam.put("page", page);
		pageParam.put("row", row);
		
		//System.out.println("page : "+page);
		
		List<HashMap<String,String>> emplist = emplistService.getEmpList(pageParam);
		
		totalCount = emplistService.getListCount();
		
		totalPage = ( (totalCount - 1) / row ) + 1;
		
		startPage = ( (page -1) / pageSize ) * pageSize + 1;
		
	
		endPage = ((startPage + pageSize -1) < totalPage)?startPage + pageSize -1 : totalPage;
		
		if(startPage != 1) pre = true;
		if(endPage < totalPage) next = true;
		
		model.addAttribute("emplist", emplist);
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("pre", pre);
		model.addAttribute("next", next);
		
		model.addAttribute("page",page);
		
		model.addAttribute("check", 1);
		
		model.addAttribute("searchText", "");
		model.addAttribute("searchDrop", "선택");
		
		return "/emplist";		
	}

	
	/**
	 *  사원 목록 조회
	 *  검색 시
	 */
	@Override
	public String emplistSearch(Model model, @RequestParam("page") int page, 
			@RequestParam("empSearchText") String searchText, @RequestParam("empSearchDrop") String searchDrop) {

		
		int totalCount = 0;		// 사원목록 총 개수
		int totalPage = 0;		// 페이지 총 개수
	 
		int startPage = 0;		// 시작 페이지
		int endPage = 0;		// 마지막 페이지
	
		boolean pre = false;	// <<(이전페이지) 보여줄건지
		boolean next = false;	// >>(다음페이지)
		
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("searchText", searchText);
		param.put("searchDrop", searchDrop);
		param.put("row", row);
		param.put("page", page);

		List<HashMap<String,String>> emplist = emplistService.getEmpSearchList(param);
		
		if(emplist.size() == 0) {
			model.addAttribute("check", 3);
			
		}else {	
			
			System.out.println("totalCount:"+totalCount);
			System.out.println("totalPage:"+totalPage);
			System.out.println("startPage:"+startPage);
			System.out.println("endPage:"+endPage);
			System.out.println("pre:"+pre);
			System.out.println("next:"+next);
			
			totalCount = Integer.parseInt(String.valueOf(emplist.get(0).get("TOTAL_CNT")));
			
			totalPage = ( (totalCount - 1) / row ) + 1;
			
			startPage = ( (page -1) / pageSize ) * pageSize + 1;

			endPage = ((startPage + pageSize -1) < totalPage)?startPage + pageSize -1 : totalPage;
			
			if(startPage != 1) pre = true;
			if(endPage < totalPage) next = true;
			
			System.out.println("totalpaeg : "+totalPage);
			System.out.println("endpage:"+endPage);
			
			model.addAttribute("emplist", emplist);
			
			model.addAttribute("pageSize", pageSize);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("pre", pre);
			model.addAttribute("next", next);
			
			model.addAttribute("page",page);
			
			model.addAttribute("check", 2);
			
			if(searchDrop.equals("EMP_NAME")) {
				searchDrop = "이름";
			}else if(searchDrop.equals("DPT_NAME")) {
				searchDrop = "부서";
			}else {
				searchDrop = "상태";
			}
			
			model.addAttribute("searchText", searchText);
			model.addAttribute("searchDrop", searchDrop);
		}
		
		
		
		return "/emplist";
	}

		
}
