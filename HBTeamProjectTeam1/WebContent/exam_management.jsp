<%@page import="com.team1.admin.dto.SubjectDTO"%>
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
		<title>한빛 교육센터 LMS - 시험 등록</title>
		<style type="text/css">
			#add-btn {
				width: 60px;
				height: 30px;
			}
			strong {
				color: blue;
			}
		</style>
		<script type="text/javascript" src="../js/jquery-1.12.4.js"></script>
	</head>
	<%
		ArrayList<SubjectDTO> list = (ArrayList<SubjectDTO>) request.getAttribute("sub_list");
	%>
	<body>
		<%@ include file="template/LMS_header.jspf" %>
		<div id="content">
			<div id="con-title">
				<h3>시험 등록 > 과목 리스트</h3>
			</div>
			<table class="t1">
				<thead>
					<tr>
						<th width="10%">연 번</th>
						<th width="38%">과목 명</th>
						<th width="13%">등록된 문제 수</th>
						<th width="13%">문제 등록</th>
						<th width="13%">미리 보기</th>
						<th width="13%">시험 등록</th>
					</tr>
				</thead>
				<tbody>
					<% for(int i=0; i<list.size(); i++) { %>
					<input type="text" id="exam<%=i %>" name="exam<%=i %>" value="<%=list.get(i).getExam() %>" hidden="hidden"/>
					<tr>
						<td><%=(i+1) %></td>
						<td><%=list.get(i).getTitle() %></td>
						<td><%=list.get(i).getQcnt() %></td>
						<td><button id="add-btn<%=i %>" type="button" OnClick="window.location='add_question.hb?sub_code=<%=list.get(i).getCode() %>&title=<%=list.get(i).getTitle() %>&qcnt=<%=list.get(i).getQcnt() %>'">추가</button></td>
						<td><a href="detail_question.hb?sub_code=<%=list.get(i).getCode() %>">미리보기</a></td>
						<td class="add-exam">
						<% if(list.get(i).getExam()==0) { %>
							<a href="add_exam.hb?sub_code=<%=list.get(i).getCode() %>">시험 등록</a>
						<% } else { %><strong>등록 완료</strong><% } %>
						</td>
					</tr>
					<% } %>
				</tbody>
			</table>
			<script type="text/javascript">
				var index = <%=list.size() %>;
				for(var i=0; i<index; i++) {
					var exam = $("#exam"+i).val();
					var btn = "#add-btn"+i;
					if(exam == 1) {
						$(btn).attr('disabled', 'true');
					}
					if(exam == 0) {
						$(btn).removeAttr('disabled');
					}	
				}
			</script>
		</div>
		<%@ include file="template/LMS_footer.jspf" %>
	</body>
</html>