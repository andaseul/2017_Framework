<%@page import="com.team1.util.HanbitUserInfoDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">	
		<link rel="stylesheet" type="text/css" href="../css/mypage_table.css"/>
		<title>한빛 교육센터 LMS - MyPage</title>
		<style type="text/css">
			
		</style>
		<script type="text/javascript" src="../js/jquery-1.12.4.js"></script>
	</head>
	<%
		request.setCharacterEncoding("UTF-8");
		HanbitUserInfoDTO bean = (HanbitUserInfoDTO) request.getAttribute("bean");
	%>
	<body>
		<%@ include file="template/LMS_header.jspf" %>
		<div id="content">
			<div id="con-title">
				<h3>한빛 교육센터 > MyPage</h3>
			</div>
			<form action="mypage_edit.hb" method="post">
				<table class="t1">
					<thead>
						<tr>
							<th colspan="2">개인 신상 정보</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th width="25%">아이디</th>
							<td><%=bean.getId() %></td>
						</tr>
						<tr>
							<th>이 름</th>
							<td><%=bean.getName() %></td>
						</tr>
						<tr>
							<th>성 별</th>
							<td><%=bean.getGender() %></td>
						</tr>
						<tr>
							<th>생 일</th>
							<td><%=bean.getBirthday() %></td>
						</tr>
						<tr>
							<th>전화 번호</th>
							<td><%=bean.getPhone() %></td>
						</tr>
						<tr>
							<th>주 소</th>
							<td><%=bean.getAddress() %></td>
						</tr>
						<tr>
							<th>E-Mail</th>
							<td><%=bean.getMail() %></td>
						</tr>
					</tbody>
				</table>
				<div id="con-btn">
					<p>
						<button type="submit">개인정보 수정</button>
					</p>
				</div>
			</form>
		</div>
		<%@ include file="template/LMS_footer.jspf" %>
	</body>
</html>
