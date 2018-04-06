package com.iteyes.works.index.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IndexMapper {

	public Map selectTopInfo(String id);

}
