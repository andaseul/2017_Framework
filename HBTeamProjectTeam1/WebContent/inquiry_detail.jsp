<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" type="text/css" href="../css/mypage_table.css"/>
		<title>한빛 교육센터 LMS - 문의사항</title>
		<style type="text/css">
			
		</style>
		<script type="text/javascript" src="../js/jquery-1.12.4.js"></script>
	</head>
	<jsp:useBean scope = "request" id = "dto" class = "com.team1.admin.dto.InquiryDTO"></jsp:useBean>
	<body>
		<%@ include file="template/LMS_header.jspf" %>
		<div id="content">
			<div id="con-title">
				<h3>한빛 교육센터 > 문의 사항 > 문의 상세</h3>
			</div>
			<table class="t1">
				<thead>
					<tr>
						<th width="20%">번호 : <jsp:getProperty property="idx" name="dto"/></th>
						<th colspan="3"><jsp:getProperty property="title" name="dto"/></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th width="20%">조회수</th>
						<td><jsp:getProperty property="hit" name="dto"/></td>
						<th width="20%">작성일</th>
						<td><jsp:getProperty property="curdate" name="dto"/> / <jsp:getProperty property="curtime" name="dto"/></td>
					</tr>
					<tr>
						<th width="20%">작성자</th>
						<td><jsp:getProperty property="name" name="dto"/></td>
						<th width="20%">연락처</th>
						<td><jsp:getProperty property="phone" name="dto"/></td>
					</tr>
					<tr>
						<td colspan="4" valign="top" height="400px">
							<!-- <textarea style="width: 100%" rows="30" readonly="readonly"><jsp:getProperty property="memo" name="dto"/></textarea> -->
							<div id="memo-span" contenteditable="true"><jsp:getProperty property="memo" name="dto"/></div>
						</td>
					</tr>
				</tbody>			
			</table>
			<div id="con-btn">
				<p>
					<button type="button" OnClick="window.location='inquiry_bbs.hb?page=1'">목록</button>
					<button type="button" OnClick="window.location='inquiry_success.hb?idx=<%=dto.getIdx()%>'">상담 완료</button>
					<button type="button" OnClick="window.location='inquiry_del.hb?idx=<%=dto.getIdx()%>'">삭제</button>
				</p>
			</div>
		</div><!-- end content -->
		<%@ include file="template/LMS_footer.jspf" %>
	</body>
</html>