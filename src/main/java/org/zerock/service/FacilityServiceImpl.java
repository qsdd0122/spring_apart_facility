package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.domain.FacilityVO;
import org.zerock.mapper.FacilityMapper;

import lombok.RequiredArgsConstructor;
import lombok.ToString;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@RequiredArgsConstructor
@ToString
public class FacilityServiceImpl implements FacilityService{

	private final FacilityMapper facilityMapper;
	
	@Override
	public int register(FacilityVO facilityVO) {
		// TODO Auto-generated method stub
		return facilityMapper.insert(facilityVO);
	}

	@Override
	public FacilityVO get(Long fac_bno) {
		// TODO Auto-generated method stub
		FacilityVO fac = facilityMapper.read(fac_bno);
		String fac_info = fac.getFac_info();
		fac_info = org.springframework.web.util.HtmlUtils.htmlEscape(fac_info);
		fac_info = fac_info.replaceAll("\n", "<br/>");
		fac.setFac_info(fac_info);
		return fac;
	}

	@Override
	public int modify(FacilityVO facilityVO) {
		// TODO Auto-generated method stub
		return facilityMapper.updateUser(facilityVO);
	}

	@Override
	public int remove(Long fac_bno) {
		// TODO Auto-generated method stub
		return facilityMapper.delete(fac_bno);
	}


	@Override
	public List<FacilityVO> getList2(String aptname) {
		// TODO Auto-generated method stub
		return facilityMapper.getList2(aptname);
	}

	@Override
	public List<FacilityVO> getList() {
		// TODO Auto-generated method stub
		return facilityMapper.getList();
	}

}
