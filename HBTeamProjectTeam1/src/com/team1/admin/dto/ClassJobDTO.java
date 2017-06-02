package com.team1.admin.dto;

public class ClassJobDTO {
	private String class_code;
	private double job_suc, job_fail;
	
	public ClassJobDTO() {
		// TODO Auto-generated constructor stub
	}

	public String getClass_code() {
		return class_code;
	}

	public void setClass_code(String class_code) {
		this.class_code = class_code;
	}

	public double getJob_suc() {
		return job_suc;
	}

	public void setJob_suc(double job_suc) {
		this.job_suc = job_suc;
	}

	public double getJob_fail() {
		return job_fail;
	}

	public void setJob_fail(double job_fail) {
		this.job_fail = job_fail;
	}
	
}
