<%@page import="com.team1.student.dto.StudentDetailAttendanceDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.team1.student.dto.StudentAttendanceDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" type="text/css" href="../css/att_table.css"/>
		<title>한빛 교육센터 LMS - 출석 관리</title>
		<script type="text/javascript" src="../js/jquery-1.12.4.js"></script>
		<script type="text/javascript" src="../js/jquery-ui.min.js"></script>
		<style type="text/css">
			
		</style>
		<script type="text/javascript">
			$(document).ready(function() {
				$('#detail-a').click(function(event) {
					event.preventDefault();
					$('#detail-info').show();
				});
				
				$('#detail-close').click(function() {
					$('#detail-info').hide();
				});
			});
		</script>
	</head>
	<%
		ArrayList<StudentDetailAttendanceDTO> list = (ArrayList<StudentDetailAttendanceDTO>) request.getAttribute("detail_attinfo");
		StudentAttendanceDTO bean = (StudentAttendanceDTO) request.getAttribute("attend_info");
		String curdate = (String) request.getAttribute("curdate");
		String curtime = (String) request.getAttribute("curtime");
		String[] cur_state = {"결석","출석","지각","조퇴"};
		int state = ((Integer) request.getAttribute("state")).intValue();
	%>
	<body>
		<%@ include file="template/LMS_header.jspf" %>
		<div id="content">
			<div id="con1">
				<div class="con-title" id="con-title">
					<h3>출석 정보 > 출결 현황</h3>
				</div>
				
				<table class="t1">
					<thead>
						<tr>
							<th colspan="4">출결 현황</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="4"></td>
						</tr>
						<tr>
							<th>과정명</th>
							<td colspan="3">
								<%=bean.getClass_title() %> 
								<a id="detail-a" href="#">상세정보</a>
							</td>
						</tr>
						<tr>
							<th width="25%">교육과정 시작일</th>
							<td width="25%"><%=bean.getStart_date() %></td>
							<th width="25%">교육과정 종료일</th>
							<td width="25%"><%=bean.getEnd_date() %></td>
						</tr>
						<tr>
							<th>소정 출석일</th>
							<td><%=bean.getFull_attend() %> 일</td>
							<th>실제 출석일</th>
							<td><%=bean.getReal_attend() %> 일</td>
						</tr>
						<tr>
							<th>지각&조퇴</th>
							<td><%=bean.getLate() %> 회</td>
							<th>결석</th>
							<td><%=bean.getAbsence() %> 회</td>
						</tr>
						<tr>
							<th>출석률(단위기간<span class="span">*</span>)</th>
							<td><%=bean.getMonth_attendance_rate() %> %</td>
							<th>출석률(전체기간<span class="span">**</span>)</th>
							<td><%=bean.getFull_attendance_rate() %> %</td>
						</tr>
					</tbody>
				</table>
				<div id="rate-div">
					<div id="rate-div-div">
						<div id="rate1" class="rate"><span class="span">&nbsp;*  단위기간</span>: 단위기간내출석일/단위기간*100(%)</div>
						<div id="rate2" class="rate"><span class="span">** 전체기간</span>: 실제출석일/총기간*100(%)</div>
					</div>
				</div>
			</div>
			<form id="con2" action="stu_attend_rq.hb" method="post">
				<table class="t1 t2" id="today-t">
					<thead>
						<tr>
							<th colspan="4">금일 출결 정보</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="4"></td>
						</tr>
						<tr>
							<th width="25%">출결 정보</th>
							<td width="25%"><%=curdate %> / <%=curtime %></td>
							<th width="25%"><%=cur_state[state] %></th>
							<td width="25%">
								<% if(state != 0) { %><button disabled="disabled">출석 완료</button>
								<% } else { %><button>출석 요청</button><% } %>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
			<script type="text/javascript">
				var js_state = <%=state %>;
				$(document).ready(function() {
					if(js_state != 0) $('.att_button').css('color', 'white');
					else $('.att_button').css('color', 'blue'); 
				});
			</script>
		</div>
		
		<div id="detail-info">
			<div>
				<button id="detail-close">X</button>
				<h2>훈련과정 상세 출결 현황</h2>
				<table class="t5">
					<thead>
						<tr>
							<th>날 짜</th>
							<th>출석 시간</th>
							<th>출석 정보</th>
						</tr>
					</thead>
					<tbody>
						<% for(StudentDetailAttendanceDTO dbean : list) { %>
						<tr>
							<td><%=dbean.getCurdate() %></td>
							<td><%=dbean.getCurtime() %></td>
							<td><%=cur_state[dbean.getState()] %></td>
						</tr>
						<% } %>
					</tbody>
				</table>
			</div>
		</div>
		<%@ include file="template/LMS_footer.jspf" %>
	</body>
</html>