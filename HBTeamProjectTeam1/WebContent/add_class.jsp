<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>한빛 교육센터 LMS - 강의 관리</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" type="text/css"/>  
		<link rel="stylesheet" href="../css/mypage_table.css" type="text/css"/>  
		<script type="text/javascript" src="../js/jquery-1.12.4.js"></script>
        <script type="text/javascript" src="../js/jquery-ui.min.js"></script>
		<style type="text/css">
			
		</style>
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
			$(function() {
				$('#title').change(function() {
					var subject1, subject2, subject3;
					if(this.value=="class1") {
						subject1 = "Java & Oracle";
						subject2 = "JavaScript & JQuery";
						subject3 = "Spring Framwork";
					}
					else if(this.value=="class2") {
						subject1 = "R프로그래밍";
						subject2 = "데이터마이닝 이론과 실습";
						subject3 = "HTML & JavasScript 웹데이터 크롤링";					
					}
					else if(this.value=="class3") {
						subject1 = "Java";
						subject2 = "HTML5 & CSS";
						subject3 = "JavaScript & JQuery";
					}
					$('#subject-1').html(subject1);
					$('#subject-2').html(subject2);
					$('#subject-3').html(subject3);
				});
			});
	        $(document).ready(function() {
	        	$('#golist').click(function() {
					window.location.replace("class_management.hb");	
				});
			});
		</script>
	</head>
	<%
		ArrayList<String> list = (ArrayList<String>) request.getAttribute("teacher_list");
	%>
	<body>
		<%@ include file="template/LMS_header.jspf" %>
		<div id="content">
			<div id="con-title">
				<h3>강의 관리 > 강의 등록</h3>
			</div>
			<form action="insert_class.hb" method="post">
				<table class="t1">
					<thead>
						<tr>
							<th colspan="6">강의 등록 - 정보 입력</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td width="20%"></td>
							<td width="13.33%"></td>
							<td width="13.33%"></td>
							<td width="20%"></td>
							<td width="20%"></td>
							<td width="13.34%"></td>
						</tr>
						<tr>
							<th colspan="1" width="20%">강의 코드</th>
							<td colspan="5"><input type="text" id="class_code" name="class_code"/></td>
						</tr>
						<tr>
							<th colspan="1" width="20%">강의 명</th>
							<td colspan="5">
								<select class="t1-select" name="title" id="title" >
									<option value="class1">UI/UX를 기반으로 한 스마트 웹 앱콘텐츠 개발자 과정</option>
									<option value="class2">빅데이터 분석 및 응용SW엔지니어링 양성 과정</option>
									<option value="class3">Interactive Web Design을 위한 Web Publisher 양성 과정</option>
								</select>
							</td>
						</tr>
						<tr>
							<th colspan="1" width="20%">강사 명</th>
							<td colspan="5">
								<select class="t1-select" name="name" id="name">
								<% for(String teacher:list) { %>
									<option><%=teacher %></option>
								<% } %>
								</select>
							</td>
						</tr>
						<tr>
							<th width="20%">강의 시작일</th>
							<td colspan="2"><input type="text" id="start_date" name="start_date"/></td>
							<th width="20%">강의 종료일</th>
							<td colspan="2"><input type="text" id="end_date" name="end_date"/></td>
						</tr>
						<tr>
							<td colspan="6"></td>
						</tr>
						<tr class="t1-sub">
							<th colspan="2">과목 - 1</th>
							<th colspan="2">과목 - 2</th>
							<th colspan="2">과목 - 3</th>
						</tr>
						<tr class="t1-sub">
							<td colspan="2" id="subject-1">Java & Oracle</td>
							<td colspan="2" id="subject-2">JavaScript & JQuery</td>
							<td colspan="2" id="subject-3">Spring Framwork</td>
						</tr>
					</tbody>
				</table>
				<div id="con-btn">
					<p>
						<button type="button" id="golist">목 록</button>
						<button type="submit">등 록</button>
						<button type="reset">취 소</button>
					</p>
				</div>
			</form>
		</div>
		<%@ include file="template/LMS_footer.jspf" %>
	</body>
</html>