package org.zerock.service;

import org.zerock.domain.MemberVO;

public interface MemberService {
	int insert(MemberVO memberVO);
	int delete(MemberVO memberVO);
	MemberVO read(String userId);

}
