package com.team1.admin.dto;

public class StudentJobDTO {

	private String id, class_code;
	private int job;

	public StudentJobDTO() {
		// TODO Auto-generated constructor stub
	}
	
	public String getClass_code() {
		return class_code;
	}

	public void setClass_code(String class_code) {
		this.class_code = class_code;
	}

	private String name;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getJob() {
		return job;
	}

	public void setJob(int job) {
		this.job = job;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
