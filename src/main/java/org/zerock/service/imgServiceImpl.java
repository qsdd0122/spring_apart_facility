package org.zerock.service;

import java.util.Map;

import org.springframework.stereotype.Service;
import org.zerock.mapper.imageMapper;

import lombok.RequiredArgsConstructor;
import lombok.ToString;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@RequiredArgsConstructor
@ToString
public class imgServiceImpl implements imageService{
	private final imageMapper mapper;

	@Override
	public int insert(Map<String, Object> hmap) {
		// TODO Auto-generated method stub
		return mapper.insert(hmap);
	}

}
