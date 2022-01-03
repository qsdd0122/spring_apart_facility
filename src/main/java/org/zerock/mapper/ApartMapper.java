package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.ApartVO;
import org.zerock.domain.Criteria;

public interface ApartMapper {

	List<ApartVO> getList();
	
	int insert(ApartVO apartVO);
	
	ApartVO read(Long apt_bno);
	
	int delete(Long apt_bno);
	
	int update(ApartVO apartVO);
	
	int getTotalCount(Criteria cri);
	
	List<ApartVO> getListWithPaging(Criteria cri);
}
