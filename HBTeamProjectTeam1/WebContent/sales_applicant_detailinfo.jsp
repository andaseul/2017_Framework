<%@page import="com.team1.admin.dto.ApplicantDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" type="text/css" href="../css/mypage_table.css"/>
		<title>한빛 교육센터 LMS - 수강생 관리</title>
		<style type="text/css">
			
		</style>
		<script type="text/javascript" src="../js/jquery-1.12.4.js"></script>
	</head>
	<%
		ApplicantDTO bean = (ApplicantDTO) request.getAttribute("info");
	%>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#golist').click(function() {
				window.location.replace("applicant_management.hb");	
			});
			$('#studel').click(function() {
				window.location.replace("applicant_delete.hb?id=<%=bean.getId() %>");	
			});
		});
	</script>
	<body>
		<%@ include file="template/LMS_header.jspf" %>
		<div id="content">
			<div id="con-title">
				<h3>수강신청 관리 > 수강신청자 상세 정보</h3>
			</div>
			<form action="applicant_approve.hb" method="post">
				<input type="text" name="id" value="<%=bean.getId() %>" hidden="hidden"/>
				<input type="text" name="name" value="<%=bean.getName() %>" hidden="hidden"/>
				<input type="text" name="class_code" value="<%=bean.getClass_code() %>" hidden="hidden"/>
				<table class="t1">
					<thead>
						<tr>
							<th colspan="6">수강신청자 강의 정보</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="6"></td>
						</tr>
						<tr>
							<th>강의 코드</th>
							<td><%=bean.getClass_code() %></td>
							<th>강의 명</th>
							<td colspan="3"><%=bean.getClass_title() %></td>
						</tr>
						<tr>
							<th>담당 강사</th>
							<td><%=bean.getTeacher() %></td>
							<th>시작일</th>
							<td><%=bean.getStart_date() %></td>
							<th>종료일</th>
							<td><%=bean.getEnd_date() %></td>
						</tr>
						<tr>
							<th>현재 인원</th>
							<td><%=bean.getCur_stunum() %></td>
							<th>수강 정원</th>
							<td><%=bean.getLimit_num() %></td>
							<th>비 고</th>
							<td></td>
						</tr>
					</tbody>
				</table>
				<table class="t1 t2">
					<thead>
						<tr>
							<th colspan="6">수강신청자 개인 정보</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="6"></td>
						</tr>
						<tr>
							<th>아이디</th>
							<td colspan="2"><%=bean.getId() %></td>
							<th>이 름</th>
							<td colspan="2"><%=bean.getName() %></td>
						</tr>
						<tr>
							<th>성 별</th>
							<td colspan="2"><%=bean.getGender() %></td>
							<th>생 일</th>
							<td colspan="2"><%=bean.getBirthday() %></td>
						</tr>
						<tr>
							<th>전화 번호</th>
							<td colspan="3"><%=bean.getPhone() %></td>
						</tr>
						<tr>
							<th>주 소</th>
							<td colspan="5"><%=bean.getAddress() %></td>
						</tr>
						<tr>
							<th>메 일</th>
							<td colspan="5"><%=bean.getMail() %></td>
						</tr>
					</tbody>
				</table>
				<div id="con-btn">
					<p>
						<button type="button" id="golist">목 록</button>
						<button type="submit">승 인</button>
						<button type="button" id="studel">삭 제</button>
					</p>
				</div>
			</form>
		</div><!-- end content -->
		<%@ include file="template/LMS_footer.jspf" %>
	</body>
</html>