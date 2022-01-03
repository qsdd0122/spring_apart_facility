package org.zerock.service;

import java.util.List;

import org.zerock.domain.ApartVO;
import org.zerock.domain.Criteria;

public interface ApartService {

	int register(ApartVO apartVO);
	
	ApartVO get(Long apt_bno);
	
	int modify(ApartVO apartVO);
	
	int remove(Long apt_bno);
	
	List<ApartVO> getList();
	
	List<ApartVO> getList(Criteria cri);
	
	int getTotal(Criteria cri);
}
