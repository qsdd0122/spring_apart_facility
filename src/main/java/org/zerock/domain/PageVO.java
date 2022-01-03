package org.zerock.domain;

import lombok.Getter;
import lombok.ToString;

@ToString
@Getter
public class PageVO {

	private int startPage, endPage;
	private boolean prev, next;
	
	private int total;
	private Criteria cri;
	
	public PageVO(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;
		
		this.endPage = (int)(Math.ceil(cri.getPageNum()/10.0) * 10);
		
		this.startPage = endPage - 9;
		
		this.prev = cri.getPageNum() > 1;
		
		int realEnd = (int)(Math.ceil((total * 1.0) / cri.getAmount()));
		
		this.endPage = realEnd <= endPage? realEnd : endPage;
		
		this.next = this.endPage < realEnd;
		
	}
}
