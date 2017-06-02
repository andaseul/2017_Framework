<%@page import="com.team1.student.dto.ScoreDTO"%>
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
		ArrayList<ScoreDTO> list = (ArrayList<ScoreDTO>) request.getAttribute("score_list");
	%>
	<body>
		<%@ include file="template/LMS_header.jspf" %>
		<div id="content">
			<div id="con-title">
				<h3>내 강의 > 성적 확인</h3>
			</div>
			<table class="t1">
				<thead>
					<tr>
						<th width="10%">연번</th>
						<th width="50%">과목 명</th>
						<th width="20%">점 수</th>
						<th width="20%">비 고</th>
					</tr>
				</thead>
				<tbody>
					<% for(int i=0; i<list.size(); i++) { %>
					<tr>
						<td><%=(i+1) %></td>
						<td><%=list.get(i).getTitle() %></td>
						<td>
							<%=list.get(i).getScore() %> / <%=list.get(i).getTotal_score() %>
						</td>
						<td>
							
						</td>
					</tr>
					<% } %>
				</tbody>
			</table>
		</div>
		<%@ include file="template/LMS_footer.jspf" %>
	</body>
</html>