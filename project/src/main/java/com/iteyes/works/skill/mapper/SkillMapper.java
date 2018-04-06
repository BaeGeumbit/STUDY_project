package com.iteyes.works.skill.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SkillMapper {
	
	public Map<String, String> getinfo(String id);
}
