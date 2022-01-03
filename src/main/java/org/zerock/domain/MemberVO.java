package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class MemberVO {
	private Long bno;
	private String userId, nickcname, email;
	private Date regdate;

}
