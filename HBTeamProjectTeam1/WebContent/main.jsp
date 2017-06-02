<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>한빛 교육센터 홍대점</title>
		<style type="text/css">
            * {
                margin: 0px;
                padding: 0px;
                box-sizing: border-box;
            }
            #backimg {
                position: absolute;
                top: 0px;
                left: 0px;
                width: 100%;
                height: 650px;
            }
            #content {
                width: 100%;
                height: 650px;
            }
            #box {
                position: absolute;
                top: 200px;
                left: 20%;
                width: 60%;
                height: 200px;
                line-height: 200px;
                margin: 0px auto;
                border: 20px solid orange;
                border-radius: 400px;
            }
            .anifont {
                color: orangered;
                font-size: 70px;
                font-weight: bold;
                text-shadow: 8px 2px 5px orange;
            }
            #h {
                position: absolute;
                left: 37%;
                top: -100px;
                width: 10px;
                height: 30px;
            }
            #a {
                position: absolute;
                left: 42%;
                top: -100px;
                width: 10px;
                height: 30px;
            }
            #n {
                position: absolute;
                left: 47%;
                top: -100px;
                width: 10px;
                height: 30px;
            }
            #b {
                position: absolute;
                left: 52%;
                top: -100px;
                width: 10px;
                height: 30px;
            }
            #i {
                position: absolute;
                left: 57%;
                top: -100px;
                width: 10px;
                height: 30px;
            }
            #t {
                position: absolute;
                left: 61%;
                top: -100px;
                width: 10px;
                height: 30px;
            }
            #go-btn {
            	width: 100%;
            	position: absolute;
                top: 480px;
                margin: 0px auto;
            	text-align: center;
            }
            #go_ad {
                display: none;
            }
            #go_lms {
                display: none;
            }
            #footer {
            	text-align: center;
                font-weight: bold;
                
            }
            #go_ad {
            	margin-right: 50px;
            }
            #go_lms {
            	margin-left: 50px;
            }
		</style>
		<link rel="stylesheet" href="../css/Main.css" type="text/css" />
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
		<script type="text/javascript" src="../js/jquery-1.12.4.js"></script>
		<script type="text/javascript" src="../js/jquery-ui.min.js"></script>
        <script type="text/javascript">
            
            var func01 = function() {
                $('#go_ad').removeAttr("display").fadeIn(1000);
                $('#go_lms').removeAttr("display").fadeIn(1000);
            };
            
            $(document).ready(function(){
                $('#h').animate({'top':'250px'},5500,"easeOutBounce");
                $('#a').animate({'top':'250px'},5000,"easeOutBounce");
                $('#n').animate({'top':'250px'},4000,"easeOutBounce");
                $('#b').animate({'top':'250px'},5000,"easeOutBounce");
                $('#i').animate({'top':'250px'},4000,"easeOutBounce");
                $('#t').animate({'top':'250px'},6000,"easeOutBounce", func01);
            });
        </script>
	</head>
	<body>
        <div id="header">
            
        </div>
		<div id="content">
            <img id="backimg" alt="bkimg" src="../imgAll/imgs/bk3.jpg"/>
            <div id="box"></div>
            <div class="anifont" id="h">H</div>
            <div class="anifont" id="a">A</div>
            <div class="anifont" id="n">N</div>
            <div class="anifont" id="b">B</div>
            <div class="anifont" id="i">I</div>
            <div class="anifont" id="t">T</div>
            
            
            <div id="go-btn">
	            <a id="go_ad" href="hanbit.hb"><img src="../imgAll/imgs/gohanbit.png"/></a>
	            <a id="go_lms" href="login.hb"><img src="../imgAll/imgs/golms.png"/></a>
			</div>
		</div>
        <div id="footer">
            <p><img src="../imgAll/imgs/s_logo.png"/></p>
            <p>Copyright Hanbit. All Right Reserved.</p>
        </div>
    </body>
</html>