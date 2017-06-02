<%@page import="com.team1.admin.dto.PageDTO"%>
<%@page import="com.team1.admin.dto.Admin_StudentAttListDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" type="text/css" href="../css/bbs_table.css"/>
		<title>한빛 교육센터 LMS - 수강생 관리</title>
		<style type="text/css">
			
		</style>
		<script type="text/javascript" src="../js/jquery-1.12.4.js"></script>
		<script type="text/javascript">
			$(document).ready(function() {
	            
	        });
		</script>
	</head>
	<% 
		PageDTO pg = (PageDTO) request.getAttribute("page_detail");
		ArrayList<Admin_StudentAttListDTO> list = (ArrayList<Admin_StudentAttListDTO>) request.getAttribute("st_att_list");
	%>
	<body>
		<%@ include file="template/LMS_header.jspf" %>
		<div id="content">
			<div id="con-title">
				<h3>수강생 관리 > 수강생 출결 관리</h3>
			</div>
			<div id="search-keyword">
				<div id="search-keyword-div2">
					<form action="admin_att.hb">
						<input type="text" name="page" value="1" hidden="hidden"/>
						<img id="search-keyword-icon" alt="search" src="../imgAll/icon/search.png"/>
						<select name="sel" id="sel">
							<option value="search">검색</option>
							<option value="id">아이디</option>
							<option value="name">이 름</option>
							<option value="class_code">강의 코드</option>
						</select>
						<input type="text" id="keyword" name="keyword"/>
						<button id="search-btn" type="submit">검색</button>
					</form>
				</div>
			</div>
			<table class="t1">
				<thead>
					<tr>
						<th width="8%">연번</th>
						<th width="12%">아이디</th>
						<th width="12%">이  름</th>
						<th width="12%">강의 코드</th>
						<th width="36%">강의 명</th>
						<th width="20%">상세 출결 정보</th>
					</tr>
				</thead>
				<tbody>
					<% for(int i=0; i<list.size(); i++) { %>
					<tr>
						<td><%=(i+1) %></td>
						<td><%=list.get(i).getId() %></td>
						<td><%=list.get(i).getName() %></td>
						<td><%=list.get(i).getClass_code() %></td>
						<td><%=list.get(i).getTitle() %></td>
						<td><a href="admin_attdatail.hb?stu_id=<%=list.get(i).getId() %>&name=<%=list.get(i).getName() %>">상세 현황</a></td>
					</tr>
					<% } %>
				</tbody>
			</table>
			<div class="page">
			<% if(pg.getStartPage() !=1) { 
				int index = pg.getPg() % 5;
				%>	<a href = "admin_att.hb?page=<%=pg.getPg()-index%>"><img class="tag" src = "../imgAll/icon/start.png"></a>
				<% } 
			 %>
			<% for(int i=pg.getStartPage();i<=pg.getEndPage();i++) { %>
				<div><a class="pg-num" href="admin_att.hb?page=<%=i %>"><%=i %></a></div>
			<% } 
			if(pg.getAllpage()>pg.getEndPage()){ %>
				<a href = "admin_att.hb?page=<%=pg.getEndPage()+1%>"><img class="tag" src = "../imgAll/icon/end.png"></a>
			<%} %>
			</div>
		</div><!-- end content -->
		<%@ include file="template/LMS_footer.jspf" %>
	</body>
</html>