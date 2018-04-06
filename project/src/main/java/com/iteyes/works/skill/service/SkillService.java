package com.iteyes.works.skill.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.iteyes.works.skill.mapper.SkillMapper;

@Service
public class SkillService {
	
	@Autowired
	private SkillMapper skillMapper;

}
