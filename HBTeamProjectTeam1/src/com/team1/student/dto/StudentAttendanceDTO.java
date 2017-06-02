package com.team1.student.dto;


public class StudentAttendanceDTO {
	private String class_title, start_date, end_date;
	private int full_attend, real_attend, late, absence;
	private double full_attendance_rate, month_attendance_rate;
	
	public StudentAttendanceDTO() {
		// TODO Auto-generated constructor stub
	}

	public String getClass_title() {
		return class_title;
	}

	public void setClass_title(String class_title) {
		this.class_title = class_title;
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

	public int getFull_attend() {
		return full_attend;
	}

	public void setFull_attend(int full_attend) {
		this.full_attend = full_attend;
	}

	public int getReal_attend() {
		return real_attend;
	}

	public void setReal_attend(int real_attend) {
		this.real_attend = real_attend;
	}

	public int getLate() {
		return late;
	}

	public void setLate(int late) {
		this.late = late;
	}

	public int getAbsence() {
		return absence;
	}

	public void setAbsence(int absence) {
		this.absence = absence;
	}

	public double getFull_attendance_rate() {
		return full_attendance_rate;
	}

	public void setFull_attendance_rate(double full_attendance_rate) {
		this.full_attendance_rate = full_attendance_rate;
	}

	public double getMonth_attendance_rate() {
		return month_attendance_rate;
	}

	public void setMonth_attendance_rate(double month_attendance_rate) {
		this.month_attendance_rate = month_attendance_rate;
	}

}
