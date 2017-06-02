<%@page import="com.team1.admin.dto.StudentJobDTO"%>
<%@page import="com.team1.admin.dto.PageDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<!DOCTYPE>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" type="text/css" href="../css/bbs_table.css"/>
		<title>한빛 교육센터 LMS - 취업 지원</title>
		<style type="text/css">
			
		</style>
		<script type="text/javascript" src="../js/jquery-1.12.4.js"></script>
		<script type="text/javascript">
			
		</script>
	</head>
	<%
		List<StudentJobDTO>list = (List<StudentJobDTO>)request.getAttribute("alist");
		PageDTO pg = (PageDTO)request.getAttribute("page_detail");
	%>
	<body>
		<%@ include file="template/LMS_header.jspf" %>
		<div id="content">
			<div id="con-title">
				<h3>취업 지원 > 취업자 관리</h3>
			</div>
			<div id="search-keyword">
				<div id="search-keyword-div2">
					<form action="stu_job_bbs.hb">
						<input type="text" name="page" hidden="hidden" value="1" />
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
			<form action="stu_job_update.hb" method="post">
				<input type="text" name="stu_job_size" hidden="hidden" value="<%=list.size() %>"/>
				<table class="t1">
					<thead>
						<tr>
							<th>연번</th>
							<th>아이디</th>
							<th>이 름</th>
							<th>강의 코드</th>
							<th>취업 상태</th>
							<th>취업 상태 변경</th>
						</tr>
					</thead>
					<tbody>
						<% for(int i=0; i<list.size(); i++) { %>
						<tr>
							<% System.out.println(pg.getPg()); %>
							<td><%=((pg.getPg()-1)*10) + (i+1) %></td>
							<td><%=list.get(i).getId() %></td>
							<td><%=list.get(i).getName() %></td>
							<td><%=list.get(i).getClass_code() %></td>
							<td>
								<% if(list.get(i).getJob() == 1) { %>취업성공
								<% } else { %>구직자<% } %>
							</td>
							<td>
								<input type="text" name="id<%=i %>" hidden="hidden" value="<%=list.get(i).getId() %>"/>
								<input id="ra1<%=i %>" type="radio" name="job<%=i %>" value="구직자"/>구직자
								<input id="ra2<%=i %>" type="radio" name="job<%=i %>" value="취업성공"/>취업성공
								<script type="text/javascript">
									var state = <%=list.get(i).getJob() %>;
									if(state == 0) $('#ra1<%=i %>').prop('checked', true);
									else if(state == 1) $('#ra2<%=i %>').prop('checked', true);
								</script>
							</td>
						</tr>
						<% } %>
					</tbody>
				</table>
				<div id="con-btn">
					<p>
						<button id="btn" type="submit">정보 수정</button>
					</p>
				</div>
			</form>
			<div class="page">
			<% if(pg.getStartPage() !=1) { 
				int index = pg.getPg() % 5;
				%>	<a href = "stu_job_bbs.hb?page=<%=pg.getPg()-index%>"><img class="tag" src = "../imgAll/icon/start.png"></a>
				<% } 
			 %>
			<% for(int i=pg.getStartPage();i<=pg.getEndPage();i++) { %>
				<div><a class="pg-num" href="stu_job_bbs.hb?page=<%=i %>"><%=i %></a></div>
			<% } 
			if(pg.getAllpage()>pg.getEndPage()){ %>
				<a href = "stu_job_bbs.hb?page=<%=pg.getEndPage()+1%>"><img class="tag" src = "../imgAll/icon/end.png"></a>
			<%} %>
			</div>
		</div>
		<%@ include file="template/LMS_footer.jspf" %>
	</body>