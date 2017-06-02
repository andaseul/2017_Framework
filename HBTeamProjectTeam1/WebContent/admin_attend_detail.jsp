<%@page import="com.team1.student.dto.StudentDetailAttendanceDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" type="text/css" href="../css/bbs_table.css"/>
		<title>한빛 교육센터 LMS - 수강생 관리</title>
		<style type="text/css">
			
		</style>
		<script type="text/javascript" src="../js/jquery-1.12.4.js"></script>
		<script type="text/javascript">
			$(document).ready(function() {
				$("#keyword").keyup(function() {
		            var sel = $("#sel option:selected").val();
					var k = $(this).val();
					var temp;
					if(sel=="attdate") {
						$(".t1 > tbody > tr").hide();
						temp = $(".t1 > tbody > tr > td:nth-child(5n+2):contains('" + k + "')");
		            } 
		            $(temp).parent().show();
		        });
			});
		</script>
	</head>
	<%
		request.setCharacterEncoding("UTF-8");
		String stu_id = (String) request.getAttribute("stu_id");
		String stu_name = (String) request.getAttribute("stu_name");
		ArrayList<StudentDetailAttendanceDTO> list = (ArrayList<StudentDetailAttendanceDTO>) request.getAttribute("detail_info"); 
	%>
	<body>
		<%@ include file="template/LMS_header.jspf" %>
		<div id="content">
			<div id="con-title">
				<h3>수강생 관리 > <%=list.get(0).getName() %> 수강생 상세 출결 현황</h3>
			</div>
			<div id="search-keyword">
				<div id="search-keyword-div">
					<img id="search-keyword-icon" alt="search" src="../imgAll/icon/search.png"/>
					<select name="sel" id="sel">
						<option value="search">검색</option>
						<option value="attdate">출석 일</option>
					</select>
					<input type="text" id="keyword" name="keyword"/>
				</div>
			</div>
			<table class="t1">
				<thead>
					<tr>
						<th>번호</th>
						<th>출석 일</th>
						<th>출석 시간</th>
						<th>출석 정보</th>
						<th>수 정</th>
					</tr>
				</thead>
				<tbody>
					<% for(int i=0; i<list.size(); i++) { %>
					<form action="admin_attedit.hb" method="post">
						<input type="text" name="stu_id" value="<%=stu_id %>" hidden="hidden"/>
						<input type="text" name="date" value="<%=list.get(i).getCurdate() %>" hidden="hidden"/>
						<tr>
							<td><%=(i+1) %></td>
							<td><%=list.get(i).getCurdate() %></td>
							<td><%=list.get(i).getCurtime() %></td>
							<td>
								<input class="ra" id="ra1_<%=i %>" type="radio" name="chk_info" value="1"/>출석
								<input class="ra" id="ra2_<%=i %>" type="radio" name="chk_info" value="2"/>지각
								<input class="ra" id="ra3_<%=i %>" type="radio" name="chk_info" value="3"/>조퇴
								<input class="ra" id="ra4_<%=i %>" type="radio" name="chk_info" value="0"/>결석
							</td>
							<td>
								<button id="btn" type="submit">수정</button>
							</td>
						</tr>
					</form>
					<script type="text/javascript">
						var state = "<%=list.get(i).getState() %>";
						if(state == 0) $('#ra4_<%=i %>').prop('checked', true);
						else if(state == 1) $('#ra1_<%=i %>').prop('checked', true);
						else if(state == 2) $('#ra2_<%=i %>').prop('checked', true);
						else $('#ra3_<%=i %>').prop('checked', true);
					</script>
					<% } %>
				</tbody>
			</table>
		</div>
		<%@ include file="template/LMS_footer.jspf" %>
	</body>
</html>