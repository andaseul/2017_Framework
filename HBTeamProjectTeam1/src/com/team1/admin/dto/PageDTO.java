package com.team1.admin.dto;

public class PageDTO {
	private int pg; // 클릭한 페이지
	private int rowSize; // 한페이지에 보일 게시물
	private int block;// 아래 보일 페이지 개수
	private int allpage; // 전체페이지수
	private int startPage; // 시작블럭
	private int endPage; // 끝 블럭

	public int getPg() {
		return pg;
	}

	public void setPg(int pg) {
		this.pg = pg;
	}

	public int getRowSize() {
		return rowSize;
	}

	public void setRowSize(int rowSize) {
		this.rowSize = rowSize;
	}

	public int getBlock() {
		return block;
	}

	public void setBlock(int block) {
		this.block = block;
	}

	public int getAllpage() {
		return allpage;
	}

	public void setAllpage(int allpage) {
		this.allpage = allpage;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	@Override
	public String toString() {
		return "pageDTO [pg=" + pg + ", rowSize=" + rowSize + ", block="
				+ block + ", allpage=" + allpage + ", startPage=" + startPage
				+ ", endPage=" + endPage + "]";
	}
}
