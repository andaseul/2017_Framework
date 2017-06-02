<%@page import="com.team1.admin.dto.QuestionDTO"%>
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
			table.t3 {
				display: none;
			}
			#tr-btn td {
				text-align: right;
				border-right: 1px solid white;
				border-left: 1px solid white;
				border-bottom: 1px solid white;
			}
			
			#tr-btn button {
				width: 90px;
				height: 30px;
				border-radius: 10px;
			}
		</style>
		<script type="text/javascript" src="../js/jquery-1.12.4.js"></script>
		<script type="text/javascript" src="../resources/js/service/HuskyEZCreator.js" charset="utf-8"></script>
		<script type="text/javascript">
			
		</script>
	</head>
	<% 
		ArrayList<QuestionDTO> list = (ArrayList<QuestionDTO>) request.getAttribute("qlist");
		String class_title = (String) request.getAttribute("class_title");
		String subject_title = (String) request.getAttribute("subject_title");
	%>
	<body>
		<%@ include file="template/LMS_header.jspf" %>
		<div id="content">
			<div id="con-title">
				<h3>시험 등록 > 과목 리스트 > 문제 미리보기</h3>
			</div>
			
			<% for(int i=0; i<list.size(); i++) { %>
			<form id="writeform<%=i %>" name="writeform<%=i %>" action="edit_question.hb" method="post">
				<input type="text" name="subcode_<%=i %>" value="<%=list.get(i).getSub_code() %>" hidden="hidden"/>
				<input type="text" name="qcode_<%=i %>" value="<%=list.get(i).getQcode() %>" hidden="hidden"/>
				<table class="t3" id="qtable<%=i%>">
					<thead>
						<tr>
							<th>강의 명</th>
							<th><%=class_title %> - <%=subject_title %></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th>문제 번호</th>
							<th><%=list.get(i).getQcode() %></th>
						</tr>
						<tr>
							<th>문 제</th>
							<td>
								<textarea id="board_content_<%=i %>" name="question_<%=i %>" style="width: 100%" rows="6"><%=list.get(i).getQuestion() %></textarea>
							</td>
						</tr>
						<tr>
							<th rowspan="5">보 기</th>
							<td>① <input type="text" id="ex1" name="ex1_<%=i %>" value="<%=list.get(i).getEx1() %>"/></td>
						</tr>
						<tr>
							<td>② <input type="text" id="ex2" name="ex2_<%=i %>" value="<%=list.get(i).getEx2() %>"/></td>
						</tr>
						<tr>
							<td>③ <input type="text" id="ex3" name="ex3_<%=i %>" value="<%=list.get(i).getEx3() %>"/></td>
						</tr>
						<tr>
							<td>④ <input type="text" id="ex4" name="ex4_<%=i %>" value="<%=list.get(i).getEx4() %>"/></td>
						</tr>
						<tr>
							<td>⑤ <input type="text" id="ex5" name="ex5_<%=i %>" value="<%=list.get(i).getEx5() %>"/></td>
						</tr>
						<tr>
							<th>정 답</th>
							<td>
								<input id="ra1_<%=i %>" type="radio" name="answer<%=i %>" value="1"/>①
								<input id="ra2_<%=i %>" type="radio" name="answer<%=i %>" value="2"/>②
								<input id="ra3_<%=i %>" type="radio" name="answer<%=i %>" value="3"/>③
								<input id="ra4_<%=i %>" type="radio" name="answer<%=i %>" value="4"/>④
								<input id="ra5_<%=i %>" type="radio" name="answer<%=i %>" value="5"/>⑤							
								
								<script type="text/javascript">
									var ans = <%=list.get(i).getAnswer() %>;
										
									if(ans == 1) $('#ra1_<%=i %>').prop('checked', true);
									else if(ans == 2) $('#ra2_<%=i %>').prop('checked', true);
									else if(ans == 3) $('#ra3_<%=i %>').prop('checked', true);
									else if(ans == 4) $('#ra4_<%=i %>').prop('checked', true);
									else if(ans == 5) $('#ra5_<%=i %>').prop('checked', true);
								</script>
							</td>
						</tr>
						<tr id="tr-btn">
							<td></td>
							<td>
								<input type="text" name="index" value="<%=i %>" hidden="hidden"/>
								<button type="button" id="prev-btn" OnClick="javascript:prevQuestion();">이전</button>
								<button type="button" id="next-btn" OnClick="javascript:nextQuestion();">다음</button>
								<button type="button" onclick="javascript:writeCheck('<%=i %>')">수정</button>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
			<% } %>
			
			<script type="text/javascript">
				$(document).ready(function() {
					$('#qtable0').show();
				});
				
				var oEditors = [];
				var listSize = <%=list.size() %>;
				for(var i=0; i<listSize; i++) {
					var txta = "board_content_"+i;
					nhn.husky.EZCreator.createInIFrame({
					    oAppRef: oEditors,
					    elPlaceHolder: txta,
					    sSkinURI: "../resources/SmartEditor2Skin.html",
					    fCreator: "createSEditor2"
					});
				}
				
				function writeCheck(index) {
					var form = $('#writeform'+index);
					var id = "board_content_"+index;
					var inputContent = oEditors.getById[id].exec("UPDATE_CONTENTS_FIELD", []);
					form.submit();
				}
				
				var index = 0;
				var tableName = '#qtable0'; 
				var isize = <%=list.size() %>;
				function prevQuestion() {
					$(tableName).hide();
					if(index == 0) {
						index = isize - 1;
					} else {
						index = index - 1;
					}
					tableName = '#qtable' + index;
					$(tableName).show();
				}
				function nextQuestion() {
					$(tableName).hide();
					if(index == isize-1) {
						index = 0;
					} else {
						index = index + 1;
					}
					tableName = '#qtable' + index;
					$(tableName).show();
				}
			</script>
		</div>
		<%@ include file="template/LMS_footer.jspf" %>
	</body>
</html>