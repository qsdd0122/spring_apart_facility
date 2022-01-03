package org.zerock.service;

import java.util.List;

import org.zerock.domain.ReserveVO;
import org.zerock.domain.SectionNumVO;

public interface ReserveService {
	
	int register(ReserveVO reserveVO);
	
	List<String> get(ReserveVO reserveVO);
	
	List<ReserveVO> getMyReserve(String userId);
	
	int remove(ReserveVO reserveVO);

	List<SectionNumVO> countSection(ReserveVO reserveVO);
}
