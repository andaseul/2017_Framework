<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" type="text/css" href="../css/bbs_detail_table.css"/>
		<title>한빛 교육센터 LMS - 공지사항</title>
		<style type="text/css">
			
		</style>
		<script type="text/javascript" src="../js/jquery-1.12.4.js"></script>
	</head>
	<jsp:useBean scope = "request" id = "dto" class = "com.team1.admin.dto.Admin_NoticeDTO"></jsp:useBean>
	<body>
		<%@ include file="template/LMS_header.jspf" %>
		<div id="content">
			<div id="con-title">
				<h3>한빛 교육센터 > 공지 사항 > 공지 상세</h3>
			</div>
			<table class="t2">
				<thead>
					<tr>
						<th width="15%">번호 : <jsp:getProperty property="idx" name="dto"/></th>
						<th colspan="2"><jsp:getProperty property="title" name="dto"/></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th>조회수 : <jsp:getProperty property="hit" name="dto"/></th>
						<th>작성자 : <jsp:getProperty property="username" name="dto"/></th>
						<th>작성일 : <jsp:getProperty property="curdate" name="dto"/> / <jsp:getProperty property="curtime" name="dto"/></th>
					</tr>
					<tr>
						<td colspan="3" valign="top">
							<!-- <textarea style="width: 100%" rows="30" readonly="readonly"><jsp:getProperty property="memo" name="dto"/></textarea> -->
							<div id="memo-span" contenteditable="true"><jsp:getProperty property="memo" name="dto"/></div>
						</td>
					</tr>
				</tbody>			
			</table>
			<div id="con-btn">
				<p>
					<button type="button" OnClick="window.location='notice_bbs.hb?page=1'">목록</button>
					<% if(hb_code==2) { %><button type="button" OnClick="window.location='notice_edit.hb?idx=<%=dto.getIdx()%>'">수정</button><% } %>
					<% if(hb_code==2) { %><button type="button" OnClick="window.location='notice_del.hb?idx=<%=dto.getIdx()%>'">삭제</button><% } %>
				</p>
			</div>
		</div><!-- end content -->
		<%@ include file="template/LMS_footer.jspf" %>
	</body>
</html>