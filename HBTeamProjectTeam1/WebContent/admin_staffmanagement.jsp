<%@page import="com.team1.admin.dto.EmployeeDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" type="text/css" href="../css/bbs_table.css"/>
		<title>한빛 교육센터 LMS - 직원 관리</title>
		<style type="text/css">
			
		</style>
		<script type="text/javascript" src="../js/jquery-1.12.4.js"></script>
		<script type="text/javascript">
			$(document).ready(function() {
				$("#keyword").keyup(function() {
	                var sel = $("#sel option:selected").val();
					var k = $(this).val();
					var temp;
					if(sel=="id") {
						$(".t1 > tbody > tr").hide();
						temp = $(".t1 > tbody > tr > td:nth-child(6n+3):contains('" + k + "')");
	                } else if(sel=="name") {
	                	$(".t1 > tbody > tr").hide();
	                	temp = $(".t1 > tbody > tr > td:nth-child(6n+4):contains('" + k + "')");
	                } else if(sel=="team") {
	                	$(".t1 > tbody > tr").hide();
	                	temp = $(".t1 > tbody > tr > td:nth-child(6n+2):contains('" + k + "')");
	                }
	                $(temp).parent().show();
	            });
				
				$('#staffadd').click(function() {
					window.location.replace("add_staff.hb");	
				});
			});
		</script>
	</head>
	<%
		ArrayList<EmployeeDTO> list = (ArrayList<EmployeeDTO>) request.getAttribute("list");
	%>
	<body>
		<%@ include file="template/LMS_header.jspf" %>
		<div id="content">
			<div id="con-title">
				<h3>직원 관리 > 직원 목록</h3>
			</div>
			<div id="search-keyword">
				<div id="search-keyword-div">
					<img id="search-keyword-icon" alt="search" src="../imgAll/icon/search.png"/>
					<select name="sel" id="sel">
						<option value="search">검색</option>
						<option value="team">소속</option>
						<option value="id">아이디</option>
						<option value="name">이 름</option>
					</select>
					<input type="text" id="keyword" />
				</div>
			</div>
			<table class="t1">
				<thead>
					<tr>
						<th width="8%">연번</th>
						<th width="10%">소 속</th>
						<th width="12%">아이디</th>
						<th width="12%">이 름</th>
						<th width="8%">성 별</th>
						<th width="10%">생 일</th>
						<th width="25%">주 소</th>
						<th width="15%">메 일</th>
					</tr>
				</thead>
				<tbody>
					<% for(int i=0; i<list.size(); i++) { %>
					<tr>
						<td><%=(i+1) %></td>
						<td><%=list.get(i).getTeam() %></td>
						<td><%=list.get(i).getId() %></td>
						<td><a href="admin_staff_detailinfo.hb?id=<%=list.get(i).getId() %>"><%=list.get(i).getName() %></a></td>
						<td><%=list.get(i).getGender() %></td>
						<td><%=list.get(i).getBirthday() %></td>
						<td><%=list.get(i).getAddress() %></td>
						<td><%=list.get(i).getMail() %></td>
					</tr>
					<% } %>
				</tbody>
			</table>
			<div id="con-btn">
				<p>
					<button id="staffadd">직원 등록</button>
				</p>
			</div>
		</div><!-- end content -->
		<%@ include file="template/LMS_footer.jspf" %>
	</body>
</html>