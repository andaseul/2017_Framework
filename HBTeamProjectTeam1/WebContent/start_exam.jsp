<%@page import="com.team1.student.dto.OnlineTestDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" type="text/css" href="../css/jquery.booklet.latest.css"/>
		<link rel="stylesheet" type="text/css" href="../css/online_test.css"/>
		<title>한빛 교육센터 LMS - 온라인 시험</title>
		
		
		<script type="text/javascript" src="../js/jquery-1.12.4.js"></script>
		<script type="text/javascript" src="../js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="../js/jquery.booklet.latest.js"></script>
		<script type="text/javascript" src="../js/jquery.easing.1.3.js"></script>
		<script type="text/javascript">
			$(document).ready(function() {
				$('#mybook').booklet({
					width:  '100%',
			        height: '550px',
			        pageNumbers: false,
			        overlays: false,
			        next: '#custom-next',
			        prev: '#custom-prev'
				});
			});
		</script>
	</head>
	<%
		String sub_code = (String) request.getAttribute("sub_code");
		String title = (String) request.getAttribute("title");
		int qcnt = ((Integer) request.getAttribute("qcnt")).intValue();
		ArrayList<OnlineTestDTO> list = (ArrayList<OnlineTestDTO>) request.getAttribute("qlist");
	%>
	<body>
		<%@ include file="template/LMS_header.jspf" %>
		<div id="content">
			<div id="con-title">
				<h3>내 강의 > 온라인 시험 > 시험 진행</h3>
			</div>
			<div id="sub-title">
				<h2>온라인 시험 과목 : <%=title %></h2>
			</div>
			<form action="submit_exam.hb" method="post">
				<input type="text" name="sub_code" value="<%=sub_code %>" hidden="hidden"/>
				<input type="text" name="qcnt" value="<%=qcnt %>" hidden="hidden"/>
				<div id="mybook">
					<div class="book-page">
						<p>※ <%=title %> Online-Test 유의사항</p>
						<div id="notice1">
							<p>1. 본 시험은 한빛교육센터에서 시행되는 온라인 시험으로 외부 유출 시 저작권에 의하여 법적 책임을 지게 될 수 있습니다.</p>
							<p>2. 답안을 체크하지 않고 제출할 경우 해당 문제는 틀린 것으로 간주됩니다.</p>
							<p>3. 부정행위를 하다 적발 시 해당 시험은 0점으로 처리됩니다.</p>
							<p>4. 시험 종료 후 답안 제출하기를 꼭 눌러주시기 바랍니다.</p>
						</div>
					</div>
					<% for(int i=0; i<list.size(); i++) { %>
					<div class="book-page">
						<div class="page-content">
							<p>Q<%=(i+1) %> / <%=qcnt %></p>
							<div class="question">
								<span><%=list.get(i).getQuestion() %></span>
							</div>
							<input type="text" name="qcode<%=i %>" value="<%=list.get(i).getQcode() %>" hidden="hidden"/>
							<div class="example">
								<p><input class="ra" type="radio" name="answer<%=i %>" value="ex1"/>&nbsp;① <%=list.get(i).getEx1() %></p>
								<p><input class="ra" type="radio" name="answer<%=i %>" value="ex2"/>&nbsp;② <%=list.get(i).getEx2() %></p>
								<p><input class="ra" type="radio" name="answer<%=i %>" value="ex3"/>&nbsp;③ <%=list.get(i).getEx3() %></p>
								<p><input class="ra" type="radio" name="answer<%=i %>" value="ex4"/>&nbsp;④ <%=list.get(i).getEx4() %></p>
								<p><input class="ra" type="radio" name="answer<%=i %>" value="ex5"/>&nbsp;⑤ <%=list.get(i).getEx5() %></p>
							</div>
						</div>
					</div><!-- end book-page -->
					<% } %>
					<div class="book-page" id="end-page">
						<h2>시험이 종료되었습니다</h2>
						<h2>수고하셨습니다</h2>
						<button type="submit">답안 제출하기</button>
					</div>
				</div><!-- end mybook -->
				
			</form>
		</div><!-- end content -->
		<%@ include file="template/LMS_footer.jspf" %>
	</body>
</html>