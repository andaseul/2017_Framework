<%@page import="com.team1.admin.dto.SubjectDTO"%>
<%@page import="com.team1.admin.dto.Admin_StudentAttendanceDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" type="text/css" href="../css/bbs_table.css"/>
		<title>한빛 교육센터 LMS - 성적 관리</title>
		<style type="text/css">
			
		</style>
		<script type="text/javascript" src="../js/jquery-1.12.4.js"></script>
	</head>
	<%
		ArrayList<SubjectDTO> list = (ArrayList<SubjectDTO>) request.getAttribute("sub_list");
	%>
	<body>
		<%@ include file="template/LMS_header.jspf" %>
		<div id="content">
			<div id="con-title">
				<h3>내 강의 > 학생 성적 관리</h3>
			</div>
			<table class="t1">
				<thead>
				<tr>
					<th width="10%">연번</th>
					<th width="40%">강좌 명</th>
					<th width="35%">과목 명</th>
					<th width="15%">성적 보기</th>
				</tr>
				</thead>
				<tbody>
					<% for(int i=0; i<list.size(); i++) { %>
					<tr>
						<td><%=(i+1) %></td>
						<td><%=list.get(i).getClass_title() %></td>
						<td><%=list.get(i).getTitle() %></td>
						<td><a href="detail_score.hb?sub_code=<%=list.get(i).getCode() %>&title=<%=list.get(i).getTitle() %>">성적 확인</a></td>
					</tr>
					<% } %>
				</tbody>
			</table>
		</div>
		<%@ include file="template/LMS_footer.jspf" %>
	</body>
</html>