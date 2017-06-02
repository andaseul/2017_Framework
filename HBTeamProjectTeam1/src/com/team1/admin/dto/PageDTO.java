package com.team1.admin.dto;

public class PageDTO {
	private int pg; // Ŭ���� ������
	private int rowSize; // ���������� ���� �Խù�
	private int block;// �Ʒ� ���� ������ ����
	private int allpage; // ��ü��������
	private int startPage; // ���ۺ�
	private int endPage; // �� ��

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
