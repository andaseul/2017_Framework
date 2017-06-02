<%@page import="com.team1.admin.dto.InquiryDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.team1.admin.dto.PageDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">	
		<link rel="stylesheet" type="text/css" href="../css/bbs_table.css"/>
		<title>한빛 교육센터 LMS - 문의사항</title>
		<style type="text/css">
			#inquiry-flag0 {
				color: red;
			}
			#inquiry-flag1 {
				color: blue;
			}
		</style>
		<script type="text/javascript" src="../js/jquery-1.12.4.js"></script>
	</head>
	<%
		ArrayList<InquiryDTO> list = (ArrayList<InquiryDTO>)request.getAttribute("alist");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String curdate = sdf.format(new Date());
		PageDTO pg = (PageDTO) request.getAttribute("page_detail");
	%>
	<body>
		<%@ include file="template/LMS_header.jspf" %>
		<div id="content">
			<div id="con-title">
				<h3>한빛 교육센터 > 문의 사항</h3>
			</div>
			<table class="t1">
				<thead>
					<tr>
						<th scope="col" width="7%">번호</th>
			            <th scope="col" width="40%">제 목</th>
			            <th scope="col" width="15%">작성자</th>
			            <th scope="col" width="15%">작성일</th>
						<th scope="col" width="13%">상 담</th>
						<th scope="col" width="10%">조회수</th>
					</tr>
				</thead>
				<tbody>
					<% for(InquiryDTO bean : list) { %>
					<tr>
						<td><%=bean.getIdx()%></td>
						<td id="t1-title">
							<a href = "inquiry_detail.hb?idx=<%=bean.getIdx() %>&hit=<%=bean.getHit() %>"><%=bean.getTitle() %></a>
							<% if(curdate.equals(bean.getCurdate())) { %>
							<img src="../imgAll/icon/ico-new.png">
							<% } %>
						</td>
						<td><%=bean.getName() %></td>
						<td>
							<% if(curdate.equals(bean.getCurdate())) { %>
							<%=bean.getCurtime() %>
							<% } else { %><%=bean.getCurdate() %><% } %>
						</td>
						<td>
							<% if(bean.getFlag()==0) { %><strong id="inquiry-flag0">처리중</strong>
							<% } else { %><strong id="inquiry-flag1">상담 완료</strong><% } %>
						</td>
						<td><%=bean.getHit() %></td>
					</tr>
					<% } %>
				</tbody>
			</table>
			<div id="con-btn">
				<p>
					<% if(hb_code==2) %><button type="button" OnClick="window.location='notice_write.hb'">게시물 등록</button>
				</p>
			</div>
			<div class="page">
			<% if(pg.getStartPage() !=1) { 
				if(pg.getAllpage()==pg.getEndPage()) { %>
					<a href = "inquiry_bbs.hb?page=<%=pg.getEndPage()-1%>"><img class="tag" src = "../imgAll/icon/start.png"></a>
				<% } else { %>
					<a href = "inquiry_bbs.hb?page=<%=pg.getEndPage()-5%>"><img class="tag" src = "../imgAll/icon/start.png"></a>
				<% } 
			} %>
			<% for(int i=pg.getStartPage();i<=pg.getEndPage();i++) { %>
				<div><a class="pg-num" href="inquiry_bbs.hb?page=<%=i %>"><%=i %></a></div>
			<% } 
			if(pg.getAllpage()>pg.getEndPage()){ %>
				<a href = "inquiry_bbs.hb?page=<%=pg.getEndPage()+1%>"><img class="tag" src = "../imgAll/icon/end.png"></a>
			<%} %>
			</div>
		</div>
		<%@ include file="template/LMS_footer.jspf" %>
	</body>
</html>
