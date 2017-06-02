package com.team1.student.dto;

public class StudentDetailAttendanceDTO {
	
	private String curdate, curtime, name;
	private int state;
	
	public StudentDetailAttendanceDTO() {
		// TODO Auto-generated constructor stub
	}

	public String getCurdate() {
		return curdate;
	}

	public void setCurdate(String curdate) {
		this.curdate = curdate;
	}

	public String getCurtime() {
		return curtime;
	}

	public void setCurtime(String curtime) {
		this.curtime = curtime;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
