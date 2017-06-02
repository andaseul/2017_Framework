package com.team1.admin.dto;

public class ClassDTO {
	private String code, title, teacher_name, start_date, end_date;
	private int cur_stunum, limit, attendance_day;
	
	public ClassDTO() {
		// TODO Auto-generated constructor stub
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

	public String getTeacher_name() {
		return teacher_name;
	}

	public void setTeacher_name(String teacher_name) {
		this.teacher_name = teacher_name;
	}

	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	public String getEnd_date() {
		return end_date;
	}

	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}

	public int getAttendance_day() {
		return attendance_day;
	}

	public void setAttendance_day(int attendance_day) {
		this.attendance_day = attendance_day;
	}

	public int getCur_stunum() {
		return cur_stunum;
	}

	public void setCur_stunum(int cur_stunum) {
		this.cur_stunum = cur_stunum;
	}

	public int getLimit() {
		return limit;
	}

	public void setLimit(int limit) {
		this.limit = limit;
	}
	
	
}
