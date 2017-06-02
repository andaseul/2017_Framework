<%@page import="com.team1.admin.dto.ClassQABBSDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" type="text/css" href="../css/bbs_detail_table.css"/>
		<title>한빛 교육센터 LMS - 강의 게시판</title>
		<style type="text/css">
			
		</style>
		<script type="text/javascript" src="../js/jquery-1.12.4.js"></script>
		<script type="text/javascript">  // 자바 스크립트 시작
		</script>
	</head>
	<body>
		<%@ include file="template/LMS_header.jspf" %>
		<%
			ClassQABBSDTO bean = (ClassQABBSDTO) request.getAttribute("bean");
			int img = (Integer) request.getAttribute("img");
			boolean flag = false;
			if(id.equals(bean.getUsername())) flag = true;
		%>
		<div id="content">
			<div id="con-title">
				<h3>내 강의 > 강의 게시판 > 강의 게시판 상세</h3>
			</div>
			<table class="t2">
				<thead>
					<tr>
						<th width="15%">번호 : <%=bean.getIdx() %></th>
						<th colspan="2"><%=bean.getTitle() %></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th>조회수 : <%=bean.getHit() %></th>
						<th>작성자 : <%=bean.getUsername() %></th>
						<th>작성일 : <%=bean.getCurdate() %> / <%=bean.getCurtime() %></th>
					</tr>
					<tr>
						<td colspan="3" valign="top">
							<!-- <textarea style="width: 100%" rows="30" readonly="readonly"></textarea> -->
							<div id="memo-span" contenteditable="true">
								<%
									String saveDir = request.getRealPath("/upload/classqa").replaceAll("\\\\", "/"); 
									String FileName = saveDir + "/" +bean.getFile(); 
								if(img==1) { %><img src="../xx_image_link.jsp?file=<%=FileName %>"/> <% } %>
								<%=bean.getMemo() %>
							</div>
						</td>
					</tr>
					<tr>
						<th>첨부 파일</th>
						<td colspan="2">
							<% if(bean.getFile()==null) { %>파일 없음
							<% } else { %><a href="classqa_down.hb?filename=<%=bean.getFile() %>"><%=bean.getFile() %></a><% } %>
						</td>
					</tr>
				</tbody>			
			</table>
			<div id="con-btn">
				<p>
					<button type="button" OnClick="window.location='classqa_bbs.hb?page=1'">목록</button>
					<% if(flag) { %><button type="button" OnClick="window.location='classqa_edit.hb?idx=<%=bean.getIdx()%>'">수정</button><% } %>
					<% if(flag) { %><button type="button" OnClick="window.location='classqa_del.hb?idx=<%=bean.getIdx()%>'">삭제</button><% } %>
					<button type="button" OnClick="window.location='classqa_reple.hb?idx=<%=bean.getIdx() %>'">답글</button>
				</p>
			</div>
		</div>
		<%@ include file="template/LMS_footer.jspf" %>
	</body>
</html>