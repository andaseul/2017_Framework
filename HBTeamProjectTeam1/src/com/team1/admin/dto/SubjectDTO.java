package com.team1.admin.dto;

public class SubjectDTO {
	private String code, title, class_code, class_title;
	private int exam, qcnt;
	
	public SubjectDTO() {
		// TODO Auto-generated constructor stub
	}
	
	public String getClass_title() {
		return class_title;
	}

	public void setClass_title(String class_title) {
		this.class_title = class_title;
	}

	public int getQcnt() {
		return qcnt;
	}

	public void setQcnt(int qcnt) {
		this.qcnt = qcnt;
	}

	public int getExam() {
		return exam;
	}


	public void setExam(int exam) {
		this.exam = exam;
	}


	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getClass_code() {
		return class_code;
	}

	public void setClass_code(String class_code) {
		this.class_code = class_code;
	}
	
}
