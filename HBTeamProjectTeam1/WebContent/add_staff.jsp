<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" type="text/css" />  
		<meta name="viewport" content="width=device-width, initial-scale=1.0">	
		<link rel="stylesheet" type="text/css" href="../css/mypage_table.css"/>
		<title>한빛 교육센터 LMS - 직원 관리</title>
		<style type="text/css">
			
		</style>
		<script src="https://code.jquery.com/jquery-1.12.4.js"></script>  
		<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		<script type="text/javascript">
	        $(function() {
				$( "#birthday, #joindate" ).datepicker({
					dateFormat: 'yy-mm-dd',
					changeMonth: true,
					changeYear: true,
					dayNamesMin: ['일','월','화','수','목','금','토'],
					showMonthAfterYear: true
				});
			});
	        $(document).ready(function() {
				$('#golist').click(function() {
					window.location.replace("staff_management.hb");	
				});
			});
		</script>
	</head>
	<body>
		<%@ include file="template/LMS_header.jspf" %>
		<div id="content">
			<div id="con-title">
				<h3>직원 관리 > 직원 등록</h3>
			</div>
			<form action="insert_staff.hb" method="post">
				<table class="t1">
					<thead>
						<tr>
							<th colspan="4">직원 등록 - 정보 입력</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="4"></td>
						</tr>
						<tr>
							<th>아이디</th>
							<td colspan="3"><input class="inp inp2" type="text" id="id" name="id"/></td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td colspan="3"><input class="inp inp2" type="text" id="pw" name="pw"/></td>
						</tr>
						<tr>
							<th>비밀번호 확인</th>
							<td colspan="3"><input class="inp inp2" type="text" id="chkpw" name="chkpw"/></td>
						</tr>
						<tr>
							<th>소 속</th>
							<td colspan="3">
								<input class="ra" type="radio" id="staff_code" name="chk_team" value="2" checked="checked"/>행정
								<input class="ra" type="radio" id="staff_code" name="chk_team" value="3"/>강사
								<input class="ra" type="radio" id="staff_code" name="chk_team" value="4"/>영업
								<input class="ra" type="radio" id="staff_code" name="chk_team" value="5"/>취업지원
							</td>
						</tr>
						<tr>
							<th>이 름</th>
							<td><input class="inp inp2" type="text" id="name" name="name"/></td>
							<th>입사 일</th>
							<td><input class="inp-date" type="text" id="joindate" name="joindate"/></td>
						</tr>
						<tr>
							<th>성 별</th>
							<td>
								<input class="ra" type="radio" id="gender1" name="chk_gender" value="남" checked="checked"/>남
								<input class="ra" type="radio" id="gender2" name="chk_gender" value="여"/>여
							</td>
							<th>생년 월일</th>
							<td><input class="inp-date" type="text" id="birthday" name="birthday"/></td>
						</tr>
						<tr>
							<th>은 행</th>
							<td><input class="inp" type="text" id="account_name" name="account_name"/></td>
							<th>계좌 번호</th>
							<td><input class="inp" type="text" id="account" name="account"/></td>
						</tr>
						<tr>
							<th>전화 번호</th>
							<td colspan="3"><input class="inp" type="text" id="phone" name="phone"/></td>
						</tr>
						<tr>
							<th>주 소</th>
							<td colspan="3"><input class="inp" type="text" id="address" name="address"/></td>
						</tr>
						<tr>
							<th>E-mail</th>
							<td colspan="3"><input class="inp" type="email" id="mail" name="mail"/></td>
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