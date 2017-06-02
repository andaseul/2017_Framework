<%@page import="com.team1.admin.dto.ScoreDTO"%>
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
		String sub_code = (String) request.getAttribute("sub_code");
		String title = (String) request.getAttribute("title");
		ArrayList<ScoreDTO> list = (ArrayList<ScoreDTO>) request.getAttribute("score_list");
	%>
	<body>
		<%@ include file="template/LMS_header.jspf" %>
		<div id="content">
			<div id="con-title">
				<h3>내 강의 > 학생 성적 관리 > 학생 성적 리스트 (과목:<%=title %>)</h3>
			</div>
			<table class="t1">
				<thead>
				<tr>
					<th width="10%">연 번</th>
					<th width="20%">이 름</th>
					<th width="20%">성 적</th>
					<th width="35%">성적 수정</th>
					<th width="15%">비 고</th>
				</tr>
				</thead>
				<tbody>
					<% for(int i=0; i<list.size(); i++) { %>
					<tr>
						<td><%=(i+1) %></td>
						<td><%=list.get(i).getName() %></td>
						<td><%=list.get(i).getScore() %> / <%=list.get(i).getTotal_score() %></td>
						<td>
							<form action="edit_score.hb" method="post">
								<input name="index" type="text" value="<%=i %>" hidden="hidden"/>
								<input name="sub_code" type="text" value="<%=sub_code %>" hidden="hidden"/>
								<input name="title" type="text" value="<%=title %>" hidden="hidden"/>
								<input name="id<%=i %>" type="text" value="<%=list.get(i).getId() %>" hidden="hidden"/>
								<input name="score<%=i %>" type="number" min="0" max="<%=list.get(i).getTotal_score() %>" value="<%=list.get(i).getScore() %>"/>
								<button type="submit">수정</button>
							</form>
						</td>
						<td></td>
					</tr>
					<% } %>
				</tbody>
			</table>
		</div>
		<%@ include file="template/LMS_footer.jspf" %>
	</body>
</html>