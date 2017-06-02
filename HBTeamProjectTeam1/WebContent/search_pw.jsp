<%@page import="com.team1.util.Hanbit_LMS_DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	int hb_code = Integer.parseInt((String) request.getParameter("hb_code"));
	String id = (String)request.getParameter("id");
	String name = (String)request.getParameter("name");
	String phone = (String)request.getParameter("phone");
	String table = "", pw = null;
	String str = "";
	
	if(name == null) name = "";
	if(phone == null) phone = "";
	
	if(hb_code == 1) table = "student";
	else if(hb_code == 2) table = "employee";
	
	Hanbit_LMS_DAO dao = new Hanbit_LMS_DAO();
	pw = dao.searchPW(table, id, name, phone); 
	
	if(pw == null) {
		out.print(pw);
	} else {
		out.print(pw);
	}
%>