<%@page import="com.team1.admin.dto.ClassStudentDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.team1.admin.dto.ClassDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" type="text/css" href="../css/mypage_table.css"/>
		<title>한빛 교육센터 LMS - 강의 관리</title>
		<style type="text/css">
			table.t2>tbody>tr:first-child>th {
				height: 30px;
			}
			table.t2>tbody>tr>td {
				text-align: center;
			}
		</style>
		<script type="text/javascript" src="../js/jquery-1.12.4.js"></script>
	</head>
	<%
		ClassDTO bean = (ClassDTO) request.getAttribute("class_info");
		ArrayList<ClassStudentDTO> list = (ArrayList<ClassStudentDTO>) request.getAttribute("class_stu");
	%>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#golist').click(function() {
				window.location.replace("class_management.hb");	
			});
		});
	</script>
	<body>
		<%@ include file="template/LMS_header.jspf" %>
		<div id="content">
			<div id="con-title">
				<h3>강의 관리 > 강의 상세 정보</h3>
			</div>
			<form action="class_edit.hb" method="post">
				<input type="text" name="code" value="<%=bean.getCode() %>" hidden="hidden"/>
				<table class="t1">
					<thead>
						<tr>
							<th colspan="6">강의 정보</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="6"></td>
						</tr>
						<tr>
							<th>강의 코드</th>
							<td><%=bean.getCode() %></td>
							<th>강의 명</th>
							<td colspan="3"><%=bean.getTitle() %></td>
								
						</tr>
						<tr>
							<th>담당 강사</th>
							<td><%=bean.getTeacher_name() %></td>
							<th>현재 인원</th>
							<td><%=bean.getCur_stunum() %></td>
							<th>정원</th>
							<td><%=bean.getLimit() %></td>
						</tr>
						<tr>
							<th>시작일</th>
							<td><%=bean.getStart_date() %></td>
							<th>종료일</th>
							<td><%=bean.getEnd_date() %></td>
							<th>강의 일수</th>
							<td><%=bean.getAttendance_day() %></td>
						</tr>
					</tbody>
				</table>
					
				<table class="t1 t2">
					<thead>
						<tr>
							<th colspan="6">수강자 정보</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th>연번</th>
							<th>아이디</th>
							<th>이 름</th>
							<th>생 일</th>
							<th>연락처</th>
							<th>취업정보</th>
						</tr>
					
						<% for(int i=0; i<list.size(); i++) { %>
						<tr>
							<td><%=(i+1) %></td>
							<td><%=list.get(i).getId() %></td>
							<td><a href="admin_student_detailinfo.hb?id=<%=list.get(i).getId() %>"><%=list.get(i).getName() %></a></td>
							<td><%=list.get(i).getBirthday() %></td>
							<td><%=list.get(i).getPhone() %></td>
							<td><%=list.get(i).getJob() %></td>
						</tr>
						<% } %>
					</tbody>
				</table>
				<div id="con-btn">
					<p>
						<button type="button" id="golist">목 록</button>
						<button type="submit">수 정</button>
					</p>
				</div>
			</form>
		</div><!-- end content -->
		<%@ include file="template/LMS_footer.jspf" %>
	</body>
</html>