package com.team1.admin.dto;

public class RealAttendanceListDTO {
	private String curdate, class_code;
	private int curmonth;

	public RealAttendanceListDTO() {
		// TODO Auto-generated constructor stub
	}

	public String getCurdate() {
		return curdate;
	}

	public void setCurdate(String curdate) {
		this.curdate = curdate;
	}

	public String getClass_code() {
		return class_code;
	}

	public void setClass_code(String class_code) {
		this.class_code = class_code;
	}

	public int getCurmonth() {
		return curmonth;
	}

	public void setCurmonth(int curmonth) {
		this.curmonth = curmonth;
	}
	
}

