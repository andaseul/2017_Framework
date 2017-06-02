<%@page import="com.team1.admin.dto.ApplicantDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" type="text/css" href="../css/bbs_table.css"/>
		<title>한빛 교육센터 LMS - 수강신청 관리</title>
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
						temp = $(".t1 > tbody > tr > td:nth-child(7n+5):contains('" + k + "')");
	                } else if(sel=="name") {
	                	$(".t1 > tbody > tr").hide();
	                	temp = $(".t1 > tbody > tr > td:nth-child(7n+6):contains('" + k + "')");
	                } else if(sel=="class_code") {
	                	$(".t1 > tbody > tr").hide();
	                	temp = $(".t1 > tbody > tr > td:nth-child(7n+3):contains('" + k + "')");
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
		ArrayList<ApplicantDTO> list = (ArrayList<ApplicantDTO>) request.getAttribute("list");
		System.out.println(list.size());
	%>
	<body>
		<%@ include file="template/LMS_header.jspf" %>
		<div id="content">
			<div id="con-title">
				<h3>수강신청 관리 > 신청자 목록</h3>
			</div>
			<div id="search-keyword">
				<div id="search-keyword-div">
					<img id="search-keyword-icon" alt="search" src="../imgAll/icon/search.png"/>
					<select name="sel" id="sel">
						<option value="search">검색</option>
						<option value="class_code">강의 코드</option>
						<option value="id">아이디</option>
						<option value="name">이 름</option>
					</select>
					<input type="text" id="keyword" />
				</div>
			</div>
			<table class="t1">
				<thead>
					<tr>
						<th>연번</th>
						<th>신청 강의명</th>
						<th>강의 코드</th>
						<th>강의 인원</th>
						<th>아이디</th>
						<th>이 름</th>
						<th>연락처</th>
					</tr>
				</thead>
				<tbody>
					<% for(int i=0; i<list.size(); i++) { %>
					<tr>
						<td><%=(i+1) %></td>
						<td><%=list.get(i).getClass_title() %></td>
						<td><%=list.get(i).getClass_code() %></td>
						<td><%=list.get(i).getCur_stunum() %> / <%=list.get(i).getLimit_num() %></td>
						<td><%=list.get(i).getId() %></td>
						<td><a href="sales_applicant_detailinfo.hb?id=<%=list.get(i).getId() %>"><%=list.get(i).getName() %></a></td>
						<td><%=list.get(i).getPhone() %></td>
					</tr>
					<% } %>
				</tbody>
			</table>
		</div><!-- end content -->
		<%@ include file="template/LMS_footer.jspf" %>
	</body>
</html>