<%@page import="com.team1.util.Hanbit_LMS_DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id= (String)request.getParameter("id");
	boolean tf=false;
	String str="";
	if(id == null){
		id="";
	}
	Hanbit_LMS_DAO dao = new Hanbit_LMS_DAO();
		
	tf = dao.idcheck(id);
	if(!tf) {
		str="NO";
		out.print(str);
	} else {
		str="YES";
		out.print(str);
	}
%>