<%@page import="com.team1.student.dto.ExamListDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" type="text/css" href="../css/bbs_table.css"/>
		<title>한빛 교육센터 LMS - 온라인 시험</title>
		<style type="text/css">
			.t1 button {
				margin-top: 5px;
				height: 30px;
				width: 60px;
			}
			.exam-succ {
				color: red;
				font-weight: bold;
			}
		</style>
		<script type="text/javascript" src="../js/jquery-1.12.4.js"></script>
		<script type="text/javascript">
			
		</script>
	</head>
	<%
		ArrayList<ExamListDTO> list = (ArrayList<ExamListDTO>) request.getAttribute("test_list");
	%>
	<body>
		<%@ include file="template/LMS_header.jspf" %>
		<div id="content">
			<div id="con-title">
				<h3>내 강의 > 온라인 시험</h3>
			</div>
			<table class="t1">
				<thead>
					<tr>
						<th width="10%">연번</th>
						<th width="50%">과목 명</th>
						<th width="20%">시험 보기</th>
						<th width="20%">결과 보기</th>
					</tr>
				</thead>
				<tbody>
					<% for(int i=0; i<list.size(); i++) { %>
					<tr>
						<td><%=(i+1) %></td>
						<td><%=list.get(i).getTitle() %></td>
						<td>
							<form action="start_exam.hb" method="post">
								<input type="text" name="sub_code" value="<%=list.get(i).getSub_code() %>" hidden="hidden"/>
								<input type="text" name="title" value="<%=list.get(i).getTitle() %>" hidden="hidden"/>
								<% if(list.get(i).getInfo()==0) { %><button type="submit">시 작</button>
								<%  } else { %><p class="exam-succ">시험 종료</p><% } %>
							</form>
						</td>
						<td>
							<a href="check_score.hb">결 과</a>
						</td>
					</tr>
					<% } %>
				</tbody>
			</table>
			<div id="notice">
				<p>※ 주의 사항</p>
				<p>1. 본 시험은 한빛교육센터에서 시행되는 온라인 시험으로 외부 유출 시 저작권에 의하여 법적 책임을 지게 될 수 있습니다.</p>
				<p>2. 답안을 체크하지 않고 제출할 경우 해당 문제는 틀린 것으로 간주됩니다.</p>
				<p>3. 부정행위를 하다 적발 시 해당 시험은 0점으로 처리됩니다.</p>
				<p>4. 시험 종료 후 답안 제출하기를 꼭 눌러주시기 바랍니다.</p>
				<p>5. 답안을 제출한 후에는 답안 수정 및 재응시가 불가능합니다.</p>
			</div>
		</div>
		<%@ include file="template/LMS_footer.jspf" %>
	</body>
</html>