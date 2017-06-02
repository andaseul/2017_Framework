<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" type="text/css" href="../css/LMSLogin.css"/>
		<style type="text/css">
			
		</style>
		<title>한빛 교육센터 LMS - 로그인</title>
        <script type="text/javascript" src="../js/jquery-1.12.4.js"></script>
        <script type="text/javascript" src="../js/jquery-ui.min.js"></script>
		<script type="text/javascript">
			$(function(){
				$("ul.panel li:not("+$("ul.tab li a.selected").attr("href")+")").hide()
				$("ul.tab li a").click(function(){
					$("ul.tab li a").removeClass("selected");
					$(this).addClass("selected");
					$("ul.panel li").hide();
					$($(this).attr("href")).show();
                    
					return false;
				});
			});
		</script>
	</head>
	<body>
        <div id="login-backimg"><img alt="backimg" src="../imgAll/background/lmsMain.png"/></div>
		<div id="login-form"> 
			<div id="layout">
                <div><img alt="logo" src="../imgAll/imgs/logo1.png"/></div>
				
                <div id="tab-container">
                    <ul class="tab">
                        <li><a href="#tab1" class="selected">학 생</a></li>
                        <li><a href="#tab2">직 원</a></li>
                    </ul>
                    <ul class="panel">
                        <li id="tab1">
                        	<form action="lms_main.hb" method="post">
	                            <p>
	                                <input type="text" class="chk_info" id="chk_info" name="chk_info" value="학생" hidden="hidden"/>
	                            </p>
	                            <p>
	                                <input type="text" id="id" name="id" placeholder="   ID"/>
	                            </p>
	                            <p>
	                                <input type="password" id="pw" name="pw" placeholder="   Password"/>
	                            </p>
	                            <p>
	                                <button type="submit">로그인</button>
	                            </p>
	                            <p>
	                                <a href="#" class="search-info" id="search1">아이디 찾기</a>
	                                <a href="#" class="search-info" id="search2">비밀번호 찾기</a>
	                            </p>
                            </form>
                        </li>
                        <li id="tab2">
                        	<form action="lms_main.hb" method="post">
	                            <p>
	                                <input type="text" class="chk_info" id="chk_info" name="chk_info" value="직원" hidden="hidden"/>
	                            </p>
	                            <p>
	                                <input type="text" id="id" name="id" placeholder="   ID"/>
	                            </p>
	                            <p>
	                                <input type="password" id="pw" name="pw" placeholder="   Password"/>
	                            </p>
	                            <p>
	                                <button type="submit">로그인</button>
	                            </p>
	                            <p>
	                                <a href="#" class="search-info" id="search3">아이디 찾기</a>
	                                <a href="#" class="search-info" id="search4">비밀번호 찾기</a>
	                            </p>
                            </form>
                        </li>
                    </ul>
                </div>
                
                <div id="search-id" class="search-div">
                	<div class="search-title">
                		<h2>아이디 찾기</h2>
                		<a id="close-id" href="#">X</a>
                	</div>
                	<div>
	                	<p><input type="text" id="name1" name="name" placeholder=" 이름을 입력하세요"></p>
	                	<p><input type="text" id="phone1" name="phone" placeholder=" 전화번호를 입력하세요"></p>
	                	<p><button type="button" id="search-id-btn">찾기</button></p>
	                </div>
                </div>
                	
                <div id="search-pw" class="search-div">
               		<div class="search-title">
                		<h2>비밀번호 찾기</h2>
                		<a id="close-pw" href="#">X</a>
                	</div>
                	<div>
                		<p><input type="text" id="id2" name="id" placeholder=" ID를 입력하세요"></p>
	                	<p><input type="text" id="name2" name="name" placeholder=" 이름을 입력하세요"></p>
	                	<p><input type="text" id="phone2" name="phone" placeholder=" 전화번호를 입력하세요"></p>
                		<p><button type="button" id="search-pw-btn">찾기</button></p>
                	</div>
                </div>
                
                <script type="text/javascript">
                   $(document).ready(function() {
                		var hb_code = 0;
                		
                		$(function() {
        					$(".search-div").draggable();
        				});
                		
                		$('#close-id').click(function(event) {
                			event.preventDefault();
                			$('#search-id').hide();
                		});
                		$('#close-pw').click(function(event) {
                			event.preventDefault();
                			$('#search-pw').hide();
                		});
                		
                		$('#search1').click(function(event) {
                			event.preventDefault();
                			hb_code = 1;
                			$('#search-pw').hide();
                			$('#search-id').show();
                		});
                		$('#search2').click(function(event) {
                			event.preventDefault();
                			hb_code = 1;
                			$('#search-id').hide();
                			$('#search-pw').show();
                		});
                		$('#search3').click(function(event) {
                			event.preventDefault();
                			hb_code = 2;
                			$('#search-pw').hide();
                			$('#search-id').show();
                		});
                		$('#search4').click(function(event) {
                			event.preventDefault();
                			hb_code = 2;
                			$('#search-id').hide();
                			$('#search-pw').show();
                		});
                		
                		$('#search-id-btn').click(function(){
            				$.ajax({
            					type: "POST",
            					url:"../search_id.jsp",
            					data:{
            						"hb_code":hb_code,
            						"name":$('#name1').val(),
            						"phone":$('#phone1').val()
            					},
            					success:function(data){
            						if($.trim(data) == ""){
            							alert("입력한 정보를 다시 한번 확인하세요");
            						}else{
            							alert("귀하의 ID는 " + $.trim(data) + "입니다.");
            							$('#search-id').hide();
            						}
            					}
            				});
            			});
                		$('#search-pw-btn').click(function(){
            				$.ajax({
            					type: "POST",
            					url:"../search_pw.jsp",
            					data:{
            						"hb_code":hb_code,
            						"id":$('#id2').val(),
            						"name":$('#name2').val(),
            						"phone":$('#phone2').val()
            					},
            					success:function(data){
            						if($.trim(data) == ""){
            							alert("입력한 정보를 다시 한번 확인하세요");
            						}else{
            							alert("귀하의 비밀번호는 " + $.trim(data) + "입니다.");
            							$('#search-pw').hide();
            						}
            					}
            				});
            			});
                	});
                </script>
                
			</div><!-- layout -->
            <p id="footinfo">Copyright Hanbit. All Right Reserved.</p>
		</div>
	</body>
</html>