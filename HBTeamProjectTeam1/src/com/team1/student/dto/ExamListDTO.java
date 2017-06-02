package com.team1.student.dto;

public class ExamListDTO {
	private String sub_code, title;
	private int info;
	
	public ExamListDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getInfo() {
		return info;
	}
	
	public void setInfo(int info) {
		this.info = info;
	}
	
	public String getSub_code() {
		return sub_code;
	}

	public void setSub_code(String sub_code) {
		this.sub_code = sub_code;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
}
