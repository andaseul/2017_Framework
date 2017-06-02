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
			
		</style>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" type="text/css"/>  
		<script type="text/javascript" src="../js/jquery-1.12.4.js"></script>
        <script type="text/javascript" src="../js/jquery-ui.min.js"></script>
	</head>
	<%
		ArrayList<String> list = (ArrayList<String>) request.getAttribute("teacher_list");
		ClassDTO bean = (ClassDTO) request.getAttribute("class_info");
	%>
	<script type="text/javascript">
		$(function() {
			$( "#start_date, #end_date" ).datepicker({
				dateFormat: 'yy-mm-dd',
				changeMonth: true,
				changeYear: true,
				dayNamesMin: ['일','월','화','수','목','금','토'],
				showMonthAfterYear: true
			});
		});
		$(document).ready(function() {
			$("#teacher").val("<%=bean.getTeacher_name() %>").attr("selected", "selected");
			$('#goback').click(function() {
				window.history.back(-1);
			});
		});
	</script>
	<body>
		<%@ include file="template/LMS_header.jspf" %>
		<div id="content">
			<div id="con-title">
				<h3>강의 관리 > 강의 정보 수정</h3>
			</div>
			<form action="class_update.hb" method="post">
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
							<td colspan="3">
								<input type="text" name="title" value="<%=bean.getTitle() %>"/>
							</td>
								
						</tr>
						<tr>
							<th>담당 강사</th>
							<td>
								<select name="teacher" id="teacher">
									<% for(String teacher:list) { %>
									<option><%=teacher %></option>
									<% } %>
								</select>
							</td>
							<th>현재 인원</th>
							<td><%=bean.getCur_stunum() %></td>
							<th>정원</th>
							<td>
								<input type="number" name="limit" value="<%=bean.getLimit() %>"/>
							</td>
						</tr>
						<tr>
							<th>시작일</th>
							<td>
								<input type="text" id="start_date" name="start_date" value="<%=bean.getStart_date() %>"/>
							</td>
							<th>종료일</th>
							<td>
								<input type="text" id="end_date" name="end_date" value="<%=bean.getEnd_date() %>"/>
							</td>
							<th>강의 일수</th>
							<td><%=bean.getAttendance_day() %></td>
						</tr>
					</tbody>
				</table>
				<div id="con-btn">
					<p>
						<button type="button" id="goback">이 전</button>
						<button type="submit">수 정</button>
					</p>
				</div>
			</form>
		</div><!-- end content -->
		<%@ include file="template/LMS_footer.jspf" %>
	</body>
</html>