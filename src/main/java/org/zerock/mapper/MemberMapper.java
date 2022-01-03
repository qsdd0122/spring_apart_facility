package org.zerock.mapper;

import org.zerock.domain.MemberVO;

public interface MemberMapper {
	int insert(MemberVO memberVO);
	MemberVO read(String userId);
	int delete(MemberVO memberVO);
}
