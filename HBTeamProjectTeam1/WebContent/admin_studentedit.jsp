<%@page import="com.team1.admin.dto.StudentInfoDTO"%>
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
		StudentInfoDTO bean = (StudentInfoDTO) request.getAttribute("info");
	%>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#goback').click(function() {
				window.history.back(-1);
			});
		});
	</script>
	<body>
		<%@ include file="template/LMS_header.jspf" %>
		<div id="content">
			<div id="con-title">
				<h3>수강생 관리 > 수강생 정보 수정</h3>
			</div>
			<form action="student_update.hb" method="post">
				<input type="text" name="id" value="<%=bean.getId() %>" hidden="hidden"/>
				<table class="t1">
					<thead>
						<tr>
							<th colspan="6">학생 강의 정보</th>
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
					</tbody>
				</table>
				<table class="t1 t2">
					<thead>
						<tr>
							<th colspan="4">학생 개인 정보</th>
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
							<td>
								<input type="text" name="name" value="<%=bean.getName() %>"/>
							</td>
						</tr>
						<tr>
							<th>성 별</th>
							<td><%=bean.getGender() %></td>
							<th>생 일</th>
							<td><%=bean.getBirthday() %></td>
						</tr>
						<tr>
							<th>전화 번호</th>
							<td colspan="3">
								<input type="text" name="phone" value="<%=bean.getPhone() %>"/>
							</td>
						</tr>
						<tr>
							<th>주 소</th>
							<td colspan="3">
								<input type="text" name="address" value="<%=bean.getAddress() %>"/>
							</td>
						</tr>
						<tr>
							<th>메 일</th>
							<td colspan="3">
								<input type="text" name="mail" value="<%=bean.getMail() %>"/>
							</td>
						</tr>
					</tbody>
				</table>
				<div id="con-btn">
					<p>
						<button type="button" id="goback">이 전</button>
						<button type="submit">수 정</button>
						<button type="reset">취 소</button>
					</p>
				</div>
			</form>
		</div><!-- end content -->
		<%@ include file="template/LMS_footer.jspf" %>
	</body>
</html>