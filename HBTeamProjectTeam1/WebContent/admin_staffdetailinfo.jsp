<%@page import="com.team1.admin.dto.EmployeeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">	
		<link rel="stylesheet" type="text/css" href="../css/mypage_table.css"/>
		<title>한빛 교육센터 LMS - 직원 관리</title>
		<style type="text/css">
			table.t2 {
				margin-top: 50px;
			}
		</style>
		<script type="text/javascript" src="../js/jquery-1.12.4.js"></script>
	</head>
	<%
		EmployeeDTO bean = (EmployeeDTO) request.getAttribute("info");
	%>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#golist').click(function() {
				window.location.replace("staff_management.hb");	
			});
			$('#staffdel').click(function() {
				window.location.replace("staff_infodelete.hb?id=<%=bean.getId() %>");	
			});
		});
	</script>
	<body>
		<%@ include file="template/LMS_header.jspf" %>
		<div id="content">
			<div id="con-title">
				<h3>직원 관리 > 직원 상세 정보</h3>
			</div>
			<form action="staff_infoedit.hb" method="post">
				<input type="text" name="id" value="<%=bean.getId() %>" hidden="hidden"/>
				<table class="t1">
					<thead>
						<tr>
							<th colspan="6">직원 소속 정보</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td></td>
						</tr>
						<tr>
							<th>소 속</th>
							<td><%=bean.getTeam() %></td>
							<th>입사 일</th>
							<td><%=bean.getJoindate() %></td>
								
						</tr>
						<tr>
							<th>은행 명</th>
							<td><%=bean.getAccount_name() %></td>
							<th>계좌 번호</th>
							<td><%=bean.getAccount() %></td>
						</tr>
					</tbody>
				</table>
				<table class="t1 t2">
					<thead>
						<tr>
							<th colspan="4">직원 개인 정보</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="4"></td>
						</tr>
						<tr>
							<th>아이디</th>
							<td><%=bean.getId() %></td>
							<th>이 름</th>
							<td><%=bean.getName() %></td>
						</tr>
						<tr>
							<th>성 별</th>
							<td><%=bean.getGender() %></td>
							<th>생 일</th>
							<td><%=bean.getBirthday() %></td>
						</tr>
						<tr>
							<th>전화 번호</th>
							<td colspan="3"><%=bean.getPhone() %></td>
						</tr>
						<tr>
							<th>주 소</th>
							<td colspan="3"><%=bean.getAddress() %></td>
						</tr>
						<tr>
							<th>메 일</th>
							<td colspan="3"><%=bean.getMail() %></td>
						</tr>
					</tbody>
				</table>
				<div id="con-btn">
					<p>
						<button type="button" id="golist">목 록</button>
						<button type="submit">수 정</button>
						<button type="button" id="staffdel">삭 제</button>
					</p>
				</div>
			</form>
		</div><!-- end content -->
		<%@ include file="template/LMS_footer.jspf" %>
	</body>
</html>