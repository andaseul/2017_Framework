<%@page import="com.team1.util.Hanbit_LMS_DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	int hb_code = Integer.parseInt((String) request.getParameter("hb_code"));
	String name = (String)request.getParameter("name");
	String phone = (String)request.getParameter("phone");
	String table = "", id = null;
	String str = "";
	
	if(name == null) name = "";
	if(phone == null) phone = "";
	
	if(hb_code == 1) table = "student";
	else if(hb_code == 2) table = "employee";
	
	Hanbit_LMS_DAO dao = new Hanbit_LMS_DAO();
	id = dao.searchID(table, name, phone); 
	
	if(id == null) {
		out.print(id);
	} else {
		out.print(id);
	}
%>