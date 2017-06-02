<%@page import="com.team1.admin.dto.PageDTO"%>
<%@page import="com.team1.admin.dto.ClassQABBSDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" type="text/css" href="../css/bbs_table.css"/>
		<title>한빛 교육센터 LMS - 강의 게시판</title>
		<style type="text/css">
			
		</style>
		<script type="text/javascript" src="../js/jquery-1.12.4.js"></script>
	</head>
	<%
		List<ClassQABBSDTO> list = (List<ClassQABBSDTO>)request.getAttribute("alist");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String curdate = sdf.format(new Date());
		PageDTO pg = (PageDTO) request.getAttribute("page_detail");
		
		System.out.println(list.size());
	%>
	<body>
		<%@ include file="template/LMS_header.jspf" %>
		<div id="content">
			<div id="con-title">
				<h3><a>내 강의</a> > <a>강의 게시판</a></h3>
			</div>
			
			<table class="t1">
				<thead>
					<tr>
						<th scope="col" width="10%">번호</th>
			            <th scope="col" width="50%">제 목</th>
			            <th scope="col" width="15%">작성자</th>
			            <th scope="col" width="15%">작성일</th>
						<th scope="col" width="10%">조회수</th>
					</tr>
				</thead>
				<tbody>
					<% for(ClassQABBSDTO bean : list) { %>
					<tr>
						<td><%=bean.getIdx()%></td>
						<td id="t1-title">
							<% for(int i=0; i<bean.getLvl(); i++) { %>
									&nbsp;&nbsp;&nbsp;
							<% } %>
							<% if(bean.getLvl() != 0) { %>
							<img id="re-icon" alt="re" src="../imgAll/icon/re1.png">
							<% } %>
							<a href = "classqa_detail.hb?idx=<%=bean.getIdx() %>&hit=<%=bean.getHit() %>"><%=bean.getTitle() %></a>
							<% if(curdate.equals(bean.getCurdate())) { %>
							<img src="../imgAll/icon/ico-new.png">
							<% } %>
						</td>
						<td><%=bean.getUsername() %></td>
						<td>
							<% if(curdate.equals(bean.getCurdate())) { %>
							<%=bean.getCurtime() %>
							<% } else { %><%=bean.getCurdate() %><% } %>
						</td>
						<td><%=bean.getHit() %></td>
					</tr>	
					<% } %>
				</tbody>
			</table>
			
			
			<div id="con-btn">
				<p>
					<button type="button" OnClick="window.location='classqa_write.hb'">게시물 등록</button>
				</p>
			</div>
			<div class="page">
			<% if(pg.getStartPage() !=1) { 
				int index = pg.getPg() % 5;
				%>	<a href = "classqa_bbs.hb?page=<%=pg.getPg()-index%>"><img class="tag" src = "../imgAll/icon/start.png"></a>
				<% } 
			 %>
			<% for(int i=pg.getStartPage();i<=pg.getEndPage();i++) { %>
				<div><a class="pg-num" href="classqa_bbs.hb?page=<%=i %>"><%=i %></a></div>
			<% } 
			if(pg.getAllpage()>pg.getEndPage()){ %>
				<a href = "classqa_bbs.hb?page=<%=pg.getEndPage()+1%>"><img class="tag" src = "../imgAll/icon/end.png"></a>
			<%} %>
			</div>
		</div>
		<%@ include file="template/LMS_footer.jspf" %>
	</body>
</html>
