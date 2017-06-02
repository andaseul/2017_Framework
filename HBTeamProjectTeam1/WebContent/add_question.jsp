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
		<link rel="stylesheet" href="../css/question_table.css"/>
		<title>한빛 교육센터 LMS - 시험 등록</title>
		<style type="text/css">
			
		</style>
		<script type="text/javascript" src="../js/jquery-1.12.4.js"></script>
		<script type="text/javascript" src="../resources/js/service/HuskyEZCreator.js" charset="utf-8"></script>
	</head>
	<%
		String qcode = (String) request.getAttribute("qcode");
		String sub_code = (String) request.getAttribute("sub_code");
		String title = (String) request.getAttribute("title");
	%>
	<body>
		<%@ include file="template/LMS_header.jspf" %>
		<div id="content">
			<div id="con-title">
				<h3>시험 등록 > 과목 리스트 > 문제 등록</h3>
			</div>
			<form name="writeform" action="insert_question.hb" method="post">
				<input type="text" name="sub_code" value="<%=sub_code %>" hidden="hidden"/>
				<input type="text" name="qcode" value="<%=qcode %>" hidden="hidden"/>
				<table class="t3">
					<thead>
						<tr>
							<th>과목 명</th>
							<th><%=title %></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th>문제 번호</th>
							<th><%=qcode %></th>
						</tr>
						<tr>
							<th>문 제</th>
							<td>
								<textarea id="board_content" name="question" style="width: 100%" rows="10"></textarea>
							</td>
						</tr>
						<tr>
							<th rowspan="5">보 기</th>
							<td>① <input type="text" id="ex1" name="ex1"/></td>
						</tr>
						<tr>
							<td>② <input type="text" id="ex2" name="ex2"/></td>
						</tr>
						<tr>
							<td>③ <input type="text" id="ex3" name="ex3"/></td>
						</tr>
						<tr>
							<td>④ <input type="text" id="ex4" name="ex4"/></td>
						</tr>
						<tr>
							<td>⑤ <input type="text" id="ex5" name="ex5"/></td>
						</tr>
						<tr>
							<th>정 답</th>
							<td>
								<input class="answer" type="radio" name="answer" value="ex1"/>①
								<input class="answer" type="radio" name="answer" value="ex2"/>②
								<input class="answer" type="radio" name="answer" value="ex3"/>③
								<input class="answer" type="radio" name="answer" value="ex4"/>④
								<input class="answer" type="radio" name="answer" value="ex5"/>⑤							
							</td>
						</tr>
					</tbody>
				</table>
				<div id="con-btn">
					<p>
						<button type="button" OnClick="javascript:writeCheck();">문제 등록</button>
						<button type="reset">취소</button>
						<button type="button" OnClick="javascript:history.back(-1)">돌아가기</button>
					</p>
				</div>
			</form>		
			<script type="text/javascript">
				var oEditors = [];
				nhn.husky.EZCreator.createInIFrame({
				    oAppRef: oEditors,
				    elPlaceHolder: "board_content",
				    sSkinURI: "../resources/SmartEditor2Skin.html",
				    fCreator: "createSEditor2"
				});
				function writeCheck() {
					var form = document.writeform;
					var inputContent = oEditors.getById["board_content"].exec("UPDATE_CONTENTS_FIELD", []);    
					
					if( !form.question.value ) {
				    	alert( "문제를 입력해 주세요" );
				    	form.question.focus();
				    	return;
				    }
					if( !form.ex1.value ) {
				    	alert( "보기를 2개 이상 입력해 주세요" );
				    	form.ex1.focus();
				    	return;
				    }
					if( !form.answer.value ) {
				    	alert( "정답을 입력해 주세요" );
				    	form.answer.focus();
				    	return;
				    }
					
					form.submit();
				}
			</script>	
		</div>
		<%@ include file="template/LMS_footer.jspf" %>
	</body>
</html>