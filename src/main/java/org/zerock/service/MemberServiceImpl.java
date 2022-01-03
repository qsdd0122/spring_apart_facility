package org.zerock.service;

import org.springframework.stereotype.Service;
import org.zerock.domain.MemberVO;
import org.zerock.mapper.MemberMapper;

import lombok.RequiredArgsConstructor;
import lombok.ToString;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@RequiredArgsConstructor
@ToString
public class MemberServiceImpl implements MemberService{
	
	private final MemberMapper memberMapper;
	
	@Override
	public int insert(MemberVO memberVO) {
		// TODO Auto-generated method stub
		return memberMapper.insert(memberVO);
	}

	@Override
	public int delete(MemberVO memberVO) {
		// TODO Auto-generated method stub
		return memberMapper.delete(memberVO);
	}

	@Override
	public MemberVO read(String userId) {
		// TODO Auto-generated method stub
		return memberMapper.read(userId);
	}

}
