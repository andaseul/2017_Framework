package com.team1.admin.dto;

public class ApplicantDTO {
	private String id, pw, name, gender, address, mail, birthday, class_code, class_title, start_date, end_date, teacher, phone;
	private int cur_stunum, limit_num;
	
	public ApplicantDTO() {
		// TODO Auto-generated constructor stub
	}

	public String getId() {
		return id;
	}

	public int getCur_stunum() {
		return cur_stunum;
	}

	public void setCur_stunum(int cur_stunum) {
		this.cur_stunum = cur_stunum;
	}

	public int getLimit_num() {
		return limit_num;
	}

	public void setLimit_num(int limit_num) {
		this.limit_num = limit_num;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getMail() {
		return mail;
	}

	public void setMail(String mail) {
		this.mail = mail;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getClass_code() {
		return class_code;
	}

	public void setClass_code(String class_code) {
		this.class_code = class_code;
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

	public String getTeacher() {
		return teacher;
	}

	public void setTeacher(String teacher) {
		this.teacher = teacher;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
}
