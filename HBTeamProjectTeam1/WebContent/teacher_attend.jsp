<%@page import="com.team1.admin.dto.Admin_StudentAttendanceDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" type="text/css" href="../css/bbs_table.css"/>
		<title>한빛 교육센터 LMS - 출석 관리</title>
		<style type="text/css">
			#search-keyword>div {
				width: 320px;
			}
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
						temp = $(".t1 > tbody > tr > td:nth-child(6n+2):contains('" + k + "')");
	                } else if(sel=="name") {
	                	$(".t1 > tbody > tr").hide();
	                	temp = $(".t1 > tbody > tr > td:nth-child(6n+3):contains('" + k + "')");
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
	ArrayList<Admin_StudentAttendanceDTO> list = (ArrayList<Admin_StudentAttendanceDTO>) request.getAttribute("list");
	%>
	<body>
		<%@ include file="template/LMS_header.jspf" %>
		<div id="content">
			<div id="con-title">
				<h3><a>출결 관리</a> > <a>금일 출결 현황 (<%=request.getAttribute("curdate") %>)</a></h3>
			</div>
			<div id="search-keyword">
				<div id="search-keyword-div">
					<img id="search-keyword-icon" alt="search" src="../imgAll/icon/search.png"/>
					<select name="sel" id="sel">
						<option value="search">검색</option>
						<option value="id">아이디</option>
						<option value="name">이 름</option>
					</select>
					<input type="text" id="keyword" name="keyword"/>
				</div>
			</div>
			<form action="update_att.hb" method="post">
				<input type="text" name="stu_num" hidden="hidden" value="<%=list.size() %>"/>
				<table class="t1">
					<thead>
						<tr>
							<th width="10%">번호</th>
							<th width="15%">아이디</th>
							<th width="15%">이  름</th>
							<th width="15%">출석 시간</th>
							<th width="30%">요청 상태</th>
							<th width="15%">비  고</th>
						</tr>
					</thead>
					<% for(int i=0; i<list.size(); i++) { %>
					<tr>
						<td><%=(i+1) %></td>
						<td><%=list.get(i).getId() %></td>
						<td><%=list.get(i).getName() %></td>
						<td><%=list.get(i).getTime() %></td>
						<td>
							<input type="text" name="id<%=i %>" hidden="hidden" value="<%=list.get(i).getId() %>"/>
							<input type="text" name="name<%=i %>" hidden="hidden" value="<%=list.get(i).getName() %>"/>
							<input type="text" name="time<%=i %>" hidden="hidden" value="<%=list.get(i).getTime() %>"/>
							<input id="ra1<%=i %>" type="radio" name="state<%=i %>" value="출석"/>출석
							<input id="ra2<%=i %>" type="radio" name="state<%=i %>" value="지각"/>지각
							<input id="ra3<%=i %>" type="radio" name="state<%=i %>" value="조퇴"/>조퇴
							<input id="ra4<%=i %>" type="radio" name="state<%=i %>" value="결석"/>결석
							
							<script type="text/javascript">
								var state = <%=list.get(i).getState() %>;
								
								if(state == 0) $('#ra4<%=i %>').prop('checked', true);
								else if(state == 1) $('#ra1<%=i %>').prop('checked', true);
								else if(state == 2) $('#ra2<%=i %>').prop('checked', true);
								else $('#ra3<%=i %>').prop('checked', true);
							</script>
						</td>
						<td>
							
						</td>
					</tr>
					<% } %>
				</table>
				<div id="con-btn">
					<p>
						<button type="submit">출석 승인</button>
					</p>
				</div>
			</form>
		</div>
		<%@ include file="template/LMS_footer.jspf" %>
	</body>
</html>