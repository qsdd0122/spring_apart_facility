package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.ReserveVO;
import org.zerock.domain.SectionNumVO;

public interface ReserveMapper {
	
	List<String> getInfo(ReserveVO reserveVO);
	
	List<ReserveVO> getMyReserve(String userId);
	
	int insert(ReserveVO reserveVO);
	
	int delete(ReserveVO reserveVO);
	
	List<SectionNumVO> countSection(ReserveVO reserveVO);

}
