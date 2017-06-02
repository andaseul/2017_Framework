<%@page import="com.team1.util.HanbitUserInfoDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">	
		<link rel="stylesheet" type="text/css" href="../css/mypage_table.css"/>
		<title>한빛 교육센터 LMS - MyPage</title>
		<style type="text/css">
			
		</style>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" type="text/css" />  
		<script type="text/javascript" src="../js/jquery-1.12.4.js"></script>
		<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> 
		<script type="text/javascript">
			$(function() {
				$( "#birthday" ).datepicker({
					dateFormat: 'yy-mm-dd',
					changeMonth: true,
					changeYear: true,
					dayNamesMin: ['일','월','화','수','목','금','토'],
					showMonthAfterYear: true
				});
			});
			
			$(document).ready(function() {
				$('#chk-pw').click(function() {
					var pw = $('#pw').val();
					var pw2 = $('#pw2').val();
					if(pw == pw2) {
						$('#pw-span').html('비밀번호가 일치합니다.').css('color','green');
						$('#con-btn button').attr('disabled', false);
					} else {
						$('#pw-span').html('비밀번호가 불일치합니다.').css('color','red');
						$('#con-btn button').attr('disabled', true);
					}
				});
			});
		</script>
	</head>
	<%
		request.setCharacterEncoding("UTF-8");
		HanbitUserInfoDTO bean = (HanbitUserInfoDTO) request.getAttribute("bean");
	%>
	<body>
		<%@ include file="template/LMS_header.jspf" %>
		<div id="content">
			<div id="con-title">
				<h3>한빛 교육센터 > MyPage > 회원정보 수정</h3>
			</div>
			<form action="mypage_update.hb" method="post">
				<input name="id" value="<%=bean.getId() %>" hidden="hidden"/>
				<table class="t1">
					<thead>
						<tr>
							<th colspan="2">LMS 회원정보</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th width="25%">아이디</th>
							<td><strong><%=bean.getId() %></strong></td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td>
								<input type="password" id="pw" name="pw"/>
								<span id="pw-span"></span>
							</td>
						</tr>
						<tr>
							<th>비밀번호 확인</th>
							<td>
								<input type="password" id="pw2" name="chk_pw"/>
								<button type="button" id="chk-pw">확인</button>
							</td>
						</tr>
					</tbody>
				</table>
				<table class="t1">
					<thead>
						<tr>
							<th colspan="2">회원 개인정보</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th width="25%">이 름</th>
							<td><input type="text" name="name" value="<%=bean.getName() %>"/></td>
						</tr>
						<tr>
							<th>생 일</th>
							<td><input type="text" id="birthday" name="birthday" value="<%=bean.getBirthday() %>"/></td>
						</tr>
						<tr>
							<th>전화 번호</th>
							<td><input type="text" name="phone" value="<%=bean.getPhone() %>"/></td>
						</tr>
						<tr>
							<th>주 소</th>
							<td><input type="text" name="address" value="<%=bean.getAddress() %>"/></td>
						</tr>
						<tr>
							<th>E-Mail</th>
							<td><input type="email" name="mail" value="<%=bean.getMail() %>"/></td>
						</tr>
					</tbody>
				</table>
				<div id="con-btn">
					<p>
						<button type="submit" disabled="disabled">개인정보 수정</button>
					</p>
				</div>
			</form>
		</div>
		<%@ include file="template/LMS_footer.jspf" %>
	</body>
</html>
