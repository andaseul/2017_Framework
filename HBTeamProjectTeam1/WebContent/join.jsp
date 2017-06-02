<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>

<html>
	<head>
		<title>Page Title</title>
		<meta charset="UTF-8">
		<meta name="viewport" content="initial-scale=1.0">
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" type="text/css" />  
		<script src="https://code.jquery.com/jquery-1.12.4.js"></script>  
		<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		<link rel="stylesheet" type="text/css" href="../css/join.css" />
	</head>
	<%
		String class_code = (String)request.getParameter("class_code");
	%>
	<script type="text/javascript">
		$(function() {
			$( "#birth" ).datepicker({
				dateFormat: 'yy-mm-dd',
				changeMonth: true,
				changeYear: true,
				dayNamesMin: ['일','월','화','수','목','금','토'],
				showMonthAfterYear: true
			});
		});
		$(document).ready(function() {
			var class_c = <%=class_code %>;
			if(class_c==1) $('#chk1').prop('checked', true);
			if(class_c==2) $('#chk2').prop('checked', true);
			if(class_c==3) $('#chk3').prop('checked', true);
			

			$('#id').focusout(function() {
				var id=$("#id").val();
				var exp = /^[a-z0-9A-Z_-]{6,12}$/; //영문과 숫자
	            // 정규표현식.test(입력값) 규칙에 맞으면 true
	            if(!exp.test(id)){
	                $('#span_id').html("6~12자의 영문, 숫자와 특수기호(_),(-)만 사용가능합니다.").css('color','red');
	                return false;
	            } else {
	                $('#span_id').html("사용가능한 ID입니다.").css('color','green');
	            }
			});
			$('#pw').focusout(function() {
				var pw=$("#pw").val();
		        var exp = /^.*(?=.{8,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;
		        // 정규표현식.test(입력값) 규칙에 맞으면 true 
		        if(!exp.test(pw)){
		            $('#span_pw').html("8~20자 영문 대 소문자, 숫자를 사용하세요.").css('color','red');
		            return false;
		        } else {
	                $('#span_pw').html("사용가능한 비밀번호입니다.").css('color','green');
	            } 
			});
			
			$('#repw').focusout(function() {
				var repw=$("#repw").val();
				var pw=$("#pw").val();
				if(repw!=pw){
		            $('#span_repw').html("비밀번호가 동일하지 않습니다").css('color','red');
		            return false;
		        } else {
	                $('#span_repw').html("비밀번호 확인이 완료되었습니다.").css('color','green');
	            }
			});
			
			// ID중복확인
			$('#idCheck').click(function(){
				$.ajax({
					type: "POST",
					url:"../idcheck.jsp",
					data:{
						"id":$('#id').val()
					},
					success:function(data){
						if($.trim(data) == "YES"){
							$('#span_id').html('<b style="font-size:18px;color:green">사용가능한 ID입니다.</b>');
						}else{
							$('#span_id').html('<b style="font-size:18px;color:red">중복된 ID입니다.</b>');
						}
					}
				});
			});
			
			//수강신청버튼 클릭
			$("#joinSub").click(function () {
				var id=$("#id").val();
				var pw=$("#pw").val();
				var name=$("#name").val();
				var birth=$("#birth").val();
				var email=$("#email").val();
				var address=$("#address").val();
				if(id==""){
					alert("아이디를 입력하세요");
					$("#id").focus();
					return;
				}
				if(pw==""){
					alert("비밀번호를 입력하세요");
					$("#pw").focus();
					return;
				}
				if(name==""){
					alert("이름을 입력하세요");
					$("#name").focus();
					return;
				}
				if(birth==""){
					alert("생년월일을 입력하세요");
					$("#birth").focus();
					return;
				}
				if(email==""){
					alert("email을 입력하세요");
					$("#email").focus();
					return;
				}
				if(address==""){
					alert("주소를 입력하세요");
					$("#address").focus();
					return;
				}
			});
		});
	</script>
	<body>
		<div id="content">
			<div id="join">
				<h1 id="title">수강등록 신청서</h1>
				<div>
				<form action="StuJoin.hb" method="post">
					<table id="joinTable">
						<tr>
							<th colspan="1" width="20%"><label class="sub01" for="id">아 이 디</label></th>
							<td colspan="3" class="joinSub">
	                            <input class="sub02" type="text" name="id" id="id" /> 
	                            <input class="sub02" type="button" name="idCheck" value="ID 중복확인" id="idCheck" />
	                        </td>
						</tr>
	                    <tr class="blank"></tr>
						<tr>
							<td colspan="1"></td>
							<td colspan="3"><span id="span_id"></span></td>
						</tr>
	                    <tr class="blank"></tr>
						<tr>
							<th colspan="1"><label class="sub01" for="pw">비밀번호</label></th>
							<td colspan="3" class="joinSub"><input class="sub02" type="text" name="pw" id="pw" /></td>
						</tr>
	                    <tr class="blank"></tr>
						<tr>
							<td colspan="1"></td>
							<td colspan="3"><span id="span_pw"></span></td>
						</tr>
	                    <tr class="blank"></tr>
						<tr>
							<th colspan="1"><label class="sub01" for="repw">비밀번호 재입력</label></th>
							<td colspan="3" class="joinSub"><input class="sub02" type="text" name="repw" id="repw" /></td>
						</tr>
	                    <tr class="blank"></tr>
						<tr>
							<td colspan="1"></td>
							<td colspan="3"><span id="span_repw"></span></td>
						</tr>
	                    <tr class="blank"></tr>
						<tr>
							<th colspan="1"><label class="sub01" for="subTitle">수강신청과정</label></th>
							<td colspan="3" class="joinSub">
	                            <input id="chk1" type="radio" class="subTitle" name="subTitle" value="class07" /><span id="text1">JAVA개발자 전문가 과정</span><br/>
	                            <input id="chk2" type="radio" class="subTitle" name="subTitle" value="class02" /><span id="text2">빅데이터 분석가 전문과정</span><br/>
	                            <input id="chk3" type="radio" class="subTitle" name="subTitle" value="class03" /><span id="text3">웹퍼블리셔 전문가 과정</span><br/>
	                        </td>
						</tr>
	                    <tr class="blank"></tr>
						<tr>
							<th colspan="1"><label class="sub01" for="name">이&nbsp; &nbsp;&nbsp;름</label></th>
							<td colspan="3" class="joinSub"><input class="sub02" type="text" name="name" id="name" /></td>
	   					</tr>
	                    <tr class="blank"></tr>
	                    <tr>
							<th colspan="1"><label class="sub01" for="phone">휴대폰번호</label></th>
							<td colspan="3" class="joinSub">
	                            <input class="sub02" type="text" name="phone" id="phone"/>
	                        </td>
						</tr>
	                    <tr class="blank"></tr>
						<tr>
							<th colspan="1">
	                            <label class="sub01" for="birth">생년월일</label>
	                        </th>
							<td colspan="1" class="joinSub">
								<input class="sub02" type="text" name="birth" id="birth"/>
							</td>
							<th colspan="1"><label class="sub01" for="gender">성&nbsp; &nbsp;&nbsp;별</label></th>
							<td colspan="1" class="joinSub">
	                            <input class="sub02" type="radio" class="gender" name="gender" value="남" checked="checked" /><span id="text7">남</span> 
	                            <input class="sub02" type="radio" class="gender" name="gender" value="여" /><span id="text8">여</span> 
	                        </td>
						</tr>
	                    <tr class="blank"></tr>
						<tr class="blank"></tr>
						<tr>
							<th colspan="1"><label class="sub01" for="email">E-mail</label></th>
							<td colspan="3" class="joinSub"><input class="sub02" type="text" name="email" id="email" /></td>
						</tr>
	                    <tr class="blank"></tr>
						<tr>
							<th colspan="1"><label class="sub01" for="address">주&nbsp; &nbsp;&nbsp;소</label></th>
							<td colspan="3" class="joinSub"><input class="sub02" type="text" name="address" id="address" /></td>
						</tr>
					</table>
					<div>
						<button type="submit" id="joinSub">수강신청하기</button>
					</div>
				</form>
			</div>
			</div>
		</div>
	</body>
</html>