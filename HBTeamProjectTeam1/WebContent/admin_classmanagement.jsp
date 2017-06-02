<%@page import="com.team1.admin.dto.ClassDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" type="text/css" href="../css/bbs_table.css"/>
		<title>한빛 교육센터 LMS - 강의 관리</title>
		<script type="text/javascript" src="../js/jquery-1.12.4.js"></script>
		<style type="text/css">
			
		</style>
		<script type="text/javascript">
			$(document).ready(function() {
				$('#classadd').click(function() {
					window.location.replace("add_class.hb");	
				});
			});
		</script>
	</head>
	<%
		ArrayList<ClassDTO> list = (ArrayList<ClassDTO>) request.getAttribute("class_list");
	%>
	<body>
		<%@ include file="template/LMS_header.jspf" %>
		<div id="content">
			<div id="con-title">
				<h3>강의 관리 > 강의 목록</h3>
			</div>
			<table class="t1">
				<thead>
					<tr>
						<th width="10%">강의 코드</th>
						<th width="40%">강의 명</th>
						<th width="12%">강사 명</th>
						<th width="8%">수강 인원</th>
						<th width="15%">강의 시작일</th>
						<th width="15%">강의 종료일</th>
					</tr>
				</thead>
				<tbody>
					<% for(ClassDTO bean : list) { %>
					<tr>
						<td><%=bean.getCode() %></td>
						<td><a href="detail_class.hb?code=<%=bean.getCode() %>"><%=bean.getTitle() %></a></td>
						<td><%=bean.getTeacher_name() %></td>
						<td><%=bean.getCur_stunum() %> / <%=bean.getLimit() %></td>
						<td><%=bean.getStart_date() %></td>
						<td><%=bean.getEnd_date() %></td>
					</tr>
					<% } %>
				</tbody>
			</table>
			<div id="con-btn">
				<p>
					<button type="button" id="classadd">강의 개설</button>
				</p>
			</div>
		</div>
		<%@ include file="template/LMS_footer.jspf" %>
	</body>
</html>