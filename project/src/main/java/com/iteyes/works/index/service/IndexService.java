package com.iteyes.works.index.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.iteyes.works.index.mapper.IndexMapper;

@Service
public class IndexService {
	
	@Autowired
	private IndexMapper indexmapper;

	public Map getTopInfo(String id) {		
		Map topinfo = indexmapper.selectTopInfo(id);	
		return topinfo;
	}
	
}
