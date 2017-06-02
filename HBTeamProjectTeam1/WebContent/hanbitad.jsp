<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="../css/ADTemplate.css" />
        <link rel="stylesheet" type="text/css" href="../js/magnific-popup.css" />
        <title>한빛 교육센터 - 홍대점</title>

        <script type="text/javascript" src="../js/jquery-1.12.4.js"></script>
        <script type="text/javascript" src="../js/jquery.smooth-scroll.js"></script>
        <script type="text/javascript" src="../js/jquery-ui.min.js"></script>
        <script type="text/javascript" src="../js/jquery.magnific-popup.min.js"></script>
        <script type="text/javascript" src="../js/jquery.bxslider.js"></script>
        <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=AIzaSyAwCj-ZtaJ_iuh7NnVhLugxZxRij2cy0-Q"></script>
        <script type="text/javascript">
            ////////////////// mainBanner 슬라이더 //////////////////////
            $(function() {
            	var mySlider = $('#wide-banner').bxSlider({
                    auto: true
                });
            	
                $('#con1-img1').on('click', function(event) {
                    event.preventDefault();
                    mySlider.goToSlide(0);
                    return false;
                });
                $('#con1-img2').on('click', function(event) {
                    event.preventDefault();
                    mySlider.goToSlide(1);
                    return false;
                });
                $('#con1-img3').on('click', function(event) {
                    event.preventDefault();
                    mySlider.goToSlide(2);
                    return false;
                });
                $('#con1-img4').on('click', function(event) {
                    event.preventDefault();
                    mySlider.goToSlide(3);
                    return false;
                }); 
            });
            
            $(document).ready(function() {
                ////////////////// 스크롤 plugin ///////////////////////////
                $('#menu a').click(function(event) {
                    event.preventDefault();
                    var link = this;
                    $.smoothScroll({
                        scrollTarget: link.hash
                    });
                });
                $('#top a').click(function(event) {
                    event.preventDefault();
                    var link = this;
                    $.smoothScroll({
                        scrollTarget: link.hash
                    });
                });

                ////////////////// 구글맵 연동 /////////////////////////////
                var mapLocation = new google.maps.LatLng('37.552980', '126.924793'); // 지도에서 가운데로 위치할 위도와 경도
                var markLocation = new google.maps.LatLng('37.553320', '126.924793'); // 마커가 위치할 위도와 경도

                var mapOptions = {
                    center: mapLocation, // 지도에서 가운데로 위치할 위도와 경도(변수)
                    zoom: 17, // 지도 zoom단계
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                };
                var map = new google.maps.Map(document.getElementById("map_canvas"), // id: map-canvas, body에 있는 div태그의 id와 같아야 함
                    mapOptions);

                var size_x = 60; // 마커로 사용할 이미지의 가로 크기
                var size_y = 60; // 마커로 사용할 이미지의 세로 크기

                // 마커로 사용할 이미지 주소
                var image = new google.maps.MarkerImage('imgs/Map-Marker.png',
                    new google.maps.Size(size_x, size_y),
                    '',
                    '',
                    new google.maps.Size(size_x, size_y));
                var marker;
                marker = new google.maps.Marker({
                    position: markLocation, // 마커가 위치할 위도와 경도(변수)
                    map: map,
                    icon: image, // 마커로 사용할 이미지(변수)
                    title: '한빛 교육센터 홍대점' // 마커에 마우스 포인트를 갖다댔을 때 뜨는 타이틀
                });
                ////////////////////////////////////////////////////////////
            });
        </script>
    </head>

    <body>

        <div id="header">
            <div>
                <a href="main.hb"><img id="header-logo" alt="logo" src="../imgAll/imgs/logo.png" /></a>
                <a class="top-menu" href="login.hb">Go to LMS</a>
                <a class="top-menu" id="chat-icon" href="#">1:1 상담</a>
                <a class="top-menu-mobile" href="login.hb"><img src="../imgAll/icon/lms_icon.png"/></a>
                <a class="top-menu-mobile" id="chat-icon" href="#"><img src="../imgAll/icon/online_icon.png"/></a>
            </div>
        </div>

		<div id="chat">
			<div>
				<div id="chat-title">한빛교육 온라인 상담<a id="close-chat" href="#">X</a></div>
		        <textarea id="messageWindow" rows="18" style="width:100%" readonly="readonly"></textarea>
		        <input id="inputMessage" type="text"/>
		        <input id="send-btn" type="submit" value="전송" onclick="javascript:send();" />
	    	</div>
	    </div>

		<script type="text/javascript">
			var textarea = document.getElementById("messageWindow");
	        var webSocket;
	        var inputMessage = document.getElementById('inputMessage');
	        
			$(document).ready(function() {
				$(function() {
					$("#chat").draggable();
				});
				
				$('#close-chat').click(function(event) {
					event.preventDefault();
					$("#chat").hide();
				});
				
				$('#chat-icon').click(function(event) {
					event.preventDefault();
					
					webSocket = new WebSocket('ws://localhost:8080/HBTeamProjectTeam1/hb/realtimeChat');
					webSocket.onerror = function(event) {
					     onError(event)
					};
					webSocket.onopen = function(event) {
						onOpen(event)
					};
					webSocket.onmessage = function(event) {
						onMessage(event)
					};
					$('#chat').show();
			
				});
			});
			
			function onMessage(event) {
		        textarea.value += "상담원 : " + event.data + "\n";
		    }
		    function onOpen(event) {
		        textarea.value += "한빛교육센터 홍대점 온라인 상담센터에 오신 것을 환영합니다.\n\n";
		    }
		    function onError(event) {
		      alert(event.data);
		    }
		    function send() {
		    	webSocket.send("tag1");
		        textarea.value += "나 : " + inputMessage.value + "\n";
		        webSocket.send(inputMessage.value);
		        inputMessage.value = "";
		    }
		</script>

		<label id="menu-label" for="toggle">MENU</label>
        <input type="checkbox" id="toggle"/>
        <div id="menu" class="dropmenu">
            <ul id="dropdown">
                <li><a class="menu-text" href="#dummy-06">오시는길</a></li>
                <li><a class="menu-text" href="#dummy-05">상담센터</a></li>
                <li><a class="menu-text" href="#dummy-04">커뮤니티</a></li>
                <li><a class="menu-text" href="#dummy-03">센터소개</a></li>
                <li><a class="menu-text" href="#dummy-02">교육과정</a></li>
            </ul>
        </div>

        <div id="content">

            <!-- 메인광고 -->
            <div id="content-01" class="main-content">
                <div class="dummy">
                
                
                </div>
                <div id="content1" class="sub-content">
                    <ul class="mainBanner" id="wide-banner">
                        <li><img class="mainBanner-img" id="mainBanner1" src="../imgAll/banner/newBanner1.png" /></li>
                        <li><img class="mainBanner-img" id="mainBanner2" src="../imgAll/banner/newBanner2.png" /></li>
                        <li><img class="mainBanner-img" id="mainBanner3" src="../imgAll/banner/newBanner3.png" /></li>
                        <li><img class="mainBanner-img" id="mainBanner4" src="../imgAll/banner/newBanner4.png" /></li>
                    </ul>
                    <div id="content1-btn">
                        <div>
                            <div><a id="con1-img1" href="#">Your Value Up Partner!</a></div>
                            <div><a id="con1-img2" href="#">실업자대상 우수훈련기관</a></div>
                            <div><a id="con1-img3" href="#">국비지원 전문교육기관</a></div>
                            <div><a id="con1-img4" href="#">체계적 · 지속적인 취업지원</a></div>
                        </div>
                    </div>
                </div>
            </div> <!-- end content01 -->
            
            <script type="text/javascript">
                $(document).ready(function() {
                	$(window).resize(function() {
                    	var width = window.innerWidth;
                    	if(width > 1024) {
                    		$('#mainBanner1').attr('src','../imgAll/banner/newBanner1.png');
                    		$('#mainBanner2').attr('src','../imgAll/banner/newBanner1.png');
                    		$('#mainBanner3').attr('src','../imgAll/banner/newBanner1.png');
                    		$('#mainBanner4').attr('src','../imgAll/banner/newBanner1.png');
                    	}
                    	else if(width <= 1024 && width > 600) {
                    		$('#mainBanner1').attr('src','../imgAll/banner/t_banner01.png');
                    		$('#mainBanner2').attr('src','../imgAll/banner/t_banner02.png');
                    		$('#mainBanner3').attr('src','../imgAll/banner/t_banner03.png');
                    		$('#mainBanner4').attr('src','../imgAll/banner/t_banner04.png');
                    	}
                    	else if(width <= 600) {
                    		$('#mainBanner1').attr('src','../imgAll/banner/mobile_banner01.jpg');
                    		$('#mainBanner2').attr('src','../imgAll/banner/mobile_banner02.jpg');
                    		$('#mainBanner3').attr('src','../imgAll/banner/mobile_banner03.jpg');
                    		$('#mainBanner4').attr('src','../imgAll/banner/mobile_banner04.png');
                    	}
                    }).resize();
                });
            </script>
            
            
            <div class="dummy1" id="dummy-02">
            	<div class="dummy-div">
			    	<marquee direction="right" scrollamount="10">
	                	"Java"<img class="marqueeI" src="../imgAll/fish/rFish1.png" />
				    </marquee>
				    <marquee scrollamount="3">
				    	<img class="marqueeI" src="../imgAll/fish/lFish1.png" />"Html"
				    </marquee>
				    <marquee scrolldelay="100">
				    	<img class="marqueeI" src="../imgAll/fish/lFish4.png" />"BigData"
				    </marquee>
				    <marquee direction="right" scrolldelay="50">
				    	"jquery"<img class="marqueeI" src="../imgAll/fish/rFish2.png" />
				    </marquee>
				    <marquee direction="left" scrollamount="25">
					    <marquee direction="up" height="50" behavior="alternate" scrolldelay="5">
					    	<img class="marqueeI" src="../imgAll/fish/lFish3.png" />"Oracle"
					    </marquee>
				    </marquee>
				</div>
            </div>
            
            
            <div id="outer1" class="outer1">
		    	<div class="inner1">
		        	    
		            <div id="content-02" class="main-content">
		            	<div id="content2" class="sub-content">
		                    <div class="CurriculumPrograms" id="img1">
		                        <img id="con2-img1" class="con2-img" src="../imgAll/curriculum/new_java.jpg"/>
		                        <p class="marginTop">
		                            <a class="simplePopup" href="../curriculum/curriculum1.html">
		                                    JAVA개발자 전문가 과정</a>
		                        </p>
		                    </div>
		                    <div class="CurriculumPrograms" id="img2">
		                        <img id="con2-img2" class="con2-img" src="../imgAll/curriculum/new_bigData1.png"/>
		                        <p class="marginTop">
		                            <a class="simplePopup" href="../curriculum/curriculum2.html">
		                                    빅데이터 분석가 전문과정</a>
		                        </p>
		                    </div>
		                    <div class="CurriculumPrograms" id="img3">
		                        <img id="con2-img3" class="con2-img" src="../imgAll/curriculum/new_webdesign.png"/>
		                        <p class="marginTop">
		                            <a class="simplePopup" href="../curriculum/curriculum3.html">
		                                웹퍼블리셔 전문가 과정</a>
		                        </p>
		                    </div>
		                </div>
		            </div><!-- end content02 -->
		            
		        </div>
		    </div>

            <script type="text/javascript">
                $(document).ready(function() {
                    $('.simplePopup').magnificPopup({
                        type: 'ajax',
                        closeOnContentClick: true
                    });
                    $('#con2-img1').mouseover(function() {
                        $(this).attr('src', '../imgAll/curriculum/c01.png'); 
                    });
                    $('#con2-img2').mouseover(function() {
                        $(this).attr('src', '../imgAll/curriculum/c02.png'); 
                    });
                    $('#con2-img3').mouseover(function() {
                        $(this).attr('src', '../imgAll/curriculum/c03.png'); 
                    });
                    $('#con2-img1').mouseleave(function() {
                        $(this).attr('src', '../imgAll/curriculum/new_java.jpg'); 
                    });
                    $('#con2-img2').mouseleave(function() {
                        $(this).attr('src', '../imgAll/curriculum/new_bigData1.png'); 
                    });
                    $('#con2-img3').mouseleave(function() {
                        $(this).attr('src', '../imgAll/curriculum/new_webdesign.png'); 
                    });
                });
                $(function() {
                    $('.popup-modal').magnificPopup({
                        type: 'inline',
                        preloader: false,
                        focus: '#username',
                        modal: true
                    });
                    $(document).on('click', '.popup-modal-dismiss', function(e) {
                        e.preventDefault();
                        $.magnificPopup.close();
                    });
                });
            </script>
            
            <div class="dummy1" id="dummy-03">
            	<div class="dummy-div">
			    	<marquee direction="right" scrollamount="10">
	                	"Java"<img class="marqueeI" src="../imgAll/fish/rFish1.png" />
				    </marquee>
				    <marquee scrollamount="3">
				    	<img class="marqueeI" src="../imgAll/fish/lFish1.png" />"Html"
				    </marquee>
				    <marquee scrolldelay="100">
				    	<img class="marqueeI" src="../imgAll/fish/lFish4.png" />"BigData"
				    </marquee>
				    <marquee direction="right" scrolldelay="50">
				    	"jquery"<img class="marqueeI" src="../imgAll/fish/rFish2.png" />
				    </marquee>
				    <marquee direction="left" scrollamount="25">
					    <marquee direction="up" height="50" behavior="alternate" scrolldelay="5">
					    	<img class="marqueeI" src="../imgAll/fish/lFish3.png" />"Oracle"
					    </marquee>
				    </marquee>
				</div>
            </div>
            
            <div id="content-03" class="main-content">
            	<div id="content3" class="sub-content">
                    <div class="intro" id="img4">
                        <div>
                            <img src="../imgAll/intro/intro01.png"/>
                            <a class="popup-modal" id="intro-tag1" href="#test-modal">대표인사</a>
                        </div>
                    </div>
                    <div class="intro" id="img5">
                        <div>
                            <img src="../imgAll/intro/intro02.png"/>
                            <a class="popup-modal" id="intro-tag2" href="#test-modal">센터연혁</a>
                        </div>
                    </div>
                    <div class="intro" id="img6">
                        <div>
                            <img src="../imgAll/intro/intro03.png"/>
                            <a class="popup-modal" id="intro-tag3" href="#test-modal">시설소개</a>
                        </div>
                    </div>
                    <div class="intro" id="img7">
                        <div>
                            <img src="../imgAll/intro/intro04.png"/>
                            <a class="popup-modal" id="intro-tag4" href="#test-modal">강사소개</a>
                        </div>
                    </div>

                    <script type="text/javascript">
                        $(document).ready(function() {
                            $('#intro-tag1').click(function(event) {
                                event.preventDefault;
                                $('.content').css('display', 'none');
                                $('#ceo_intro').css('display', 'block');
                            });
                            $('#intro-tag2').click(function(event) {
                                event.preventDefault;
                                $('.content').css('display', 'none');
                                $('#history_intro').css('display', 'block');
                            });
                            $('#intro-tag3').click(function(event) {
                                event.preventDefault;
                                $('.content').css('display', 'none');
                                $('#environment_intro').css('display', 'block');
                            });
                            $('#intro-tag4').click(function(event) {
                                event.preventDefault;
                                $('.content').css('display', 'none');
                                $('#teacher_intro').css('display', 'block');
                            });
                            $('#btn1').click(function() {
                                $('.content').css('display', 'none');
                                $('#ceo_intro').css('display', 'block');
                            });
                            $('#btn2').click(function() {
                                $('.content').css('display', 'none');
                                $('#history_intro').css('display', 'block');
                            });
                            $('#btn3').click(function() {
                                $('.content').css('display', 'none');
                                $('#environment_intro').css('display', 'block');
                            });

                            $('#btn4').click(function() {
                                $('.content').css('display', 'none');
                                $('#teacher_intro').css('display', 'block');
                            });
                        });
                    </script>

                    <div id="test-modal" class="white-popup-block mfp-hide">
                        <div id="IntroContent">
                            <div>
                                <button id="btn1" class="pop-button">대표인사</button>
                                <button id="btn2" class="pop-button">센터연혁</button>
                                <button id="btn3" class="pop-button">시설소개</button>
                                <button id="btn4" class="pop-button">강사소개</button>
                                <a id="out" class="popup-modal-dismiss" href="#">X</a>
                            </div>

                            <div class="content" id="ceo_intro">
                                <img src="../imgAll/intro/ceo.jpg" class="pop-img"/>
                            </div>

                            <div class="content" id="history_intro">
                                <img src="../imgAll/intro/history.jpg" class="pop-img"/>
                            </div>

                            <div class="content" id="environment_intro">
                                <img src="../imgAll/intro/environment.jpg" class="pop-img"/>
                            </div>

                            <div class="content" id="teacher_intro">

                                <table id="introTable">
                                    <tr>
                                        <td>
                                            <img src="../imgAll/intro/t_Kim_Yeongjo.jpg" class="pop-img"/>
                                        </td>
                                        <td>
                                            <strong>김영조</strong> <br><br> - 전남대학교산학협력단 <br> - 지플러스<br> - ㈜서주아이스<br> - ㈜마이볼월드<br> - 캐드뱅크 강사<br>
                                        </td>
                                        <td>
                                            - ㈜더조은아카데미 강사 (C언어, JAVA, Javascript) <br> - 현) 한빛교육센터 취업대비반 강의 <br> - 정보처리기능사, 사무자동화산업기사 <br>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <img src="../imgAll/intro/t_Park_Jeonggwan.jpg" class="pop-img"/>
                                        </td>
                                        <td>
                                            <strong>박정관</strong> <br><br> - ㈜엠지엠엘 <br> - ㈜화이트윙시스템 <br> - ㈜하이미디어 강사 (Java, C언어) <br>
                                        </td>
                                        <td>


                                            - ㈜아이티뱅크 강사 (Java, JSP, 클라우드 기반 자바 웹개발) <br> - 현) 한빛교육센터 취업대비반 강의 <br> - 정보처리기사 <br>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <img src="../imgAll/intro/t_Kim_Eunyeong.jpg" class="pop-img"/>
                                        </td>
                                        <td>
                                            <strong>김은영</strong> <br>
                                            <br> - 동국대학교교육대학원 컴퓨터교육 석사 <br> - 포항구룡포초등학교 컴퓨터강사 <br> - 삼보컴퓨터교육장(역삼) 실업자재취업과정 교육 <br> - 내외컴퓨터학원(c, c++, java언어 강의) <br> - 한양대학교 C언어 특강 <br>

                                        </td>
                                        <td>
                                            - 소소리 it직업전문학교 강사 (jsp 개발자 과정) <br> - 한국직업전문학교 강사 (jsp 개발자 과정) <br> - 선린인터넷고등학교 기간제교사 <br> - 경영기술개발원 교육센터 전임 <br> - 현) 한빛교육센터 취업대비반 강의 <br>

                                        </td>
                                    </tr>
                                </table>

                            </div>
                        </div>
                    </div>
                </div>
            </div><!-- end content03 -->
            
            
            <div class="dummy1" id="dummy-04">
            	<div class="dummy-div">
			    	<marquee direction="right" scrollamount="10">
	                	"Java"<img class="marqueeI" src="../imgAll/fish/rFish1.png" />
				    </marquee>
				    <marquee scrollamount="3">
				    	<img class="marqueeI" src="../imgAll/fish/lFish1.png" />"Html"
				    </marquee>
				    <marquee scrolldelay="100">
				    	<img class="marqueeI" src="../imgAll/fish/lFish4.png" />"BigData"
				    </marquee>
				    <marquee direction="right" scrolldelay="50">
				    	"jquery"<img class="marqueeI" src="../imgAll/fish/rFish2.png" />
				    </marquee>
				    <marquee direction="left" scrollamount="25">
					    <marquee direction="up" height="50" behavior="alternate" scrolldelay="5">
					    	<img class="marqueeI" src="../imgAll/fish/lFish3.png" />"Oracle"
					    </marquee>
				    </marquee>
				</div>
            </div>
            
            <div id="content-04" class="main-content">
                <div id="content4" class="sub-content" >
                    <div class="communitySub">
                        <div id="sub1_4">
                            <a id="tab02-icon" href="#">수강생 생생후기</a>
                        </div>
                        <div id="sub2_4">
                            <a id="tab03-icon" href="#">수료생 취업후기</a>
                        </div>
                    </div>
                    
                    
                    <div id="communityMain01">
                        <div class="tab-con" id="tab01">
                            <img id="communityMainImg" src="../imgAll/community/new_community.png" />
                        </div>

                        <div class="tab-con" id="tab02">
                        	<div class="tab2">
                            	<button id="tablinks1" class="tablinks" onclick="openCity(event, 'Park')">박재홍님</button>
                            	<button class="tablinks" onclick="openCity(event, 'Kim')">김한수님</button>
                            	<button class="tablinks" onclick="openCity(event, 'Joe')">조영욱님</button>
                        	</div>

                            <div id="Park" class="tabcontent">
                            	<div>
                            		<img class="profile-img" id="eduProfile1" src="../imgAll/community/edu_epilogue1_1.png" /> 
                                </div>
                                <div class="Profile"> 
                                	<h2 class="h1">스마트 웹과 앱 콘텐츠 개발자 과정</h2>
                                    <h3 class="h3">이 과정을 수강하게 된 계기는 무엇인가요?</h3>
                                    <p class="h3-sub">이전부터 IT계열 업종에 관심이 많았고 하던 일을 정리한 이후 지인으로부터 국비지원을 받으면서 공부 할 수 있다는 이야기를 듣고 고용지원센터의 도움을 받아 주변교육센터 중 가까운 곳으로 선택하게 되었습니다.</p>
                                    <div><a class="detail simplePopup" href="../community/edu_epilogue1.html">자세히 보기</a></div>
                            	</div>      
                            </div>
                            
                            <div id="Kim" class="tabcontent">
                                <div> 
		                        	<img class="profile-img" id="eduProfile2" src="../imgAll/community/edu_epilogue2_1.png" /> 
		                        </div>
		                        <div class="Profile">  
		                        	<h2 class="h1">응용SW엔지니어링 양성과정</h2> 
		                            <h3 class="h3">수업 진행에 있어서 가장 만족스러운 부분이 있다면?</h3>
		                            <p class="h3-sub">강의내용이나 강사님에게 만족하고 있고요. 강의실 개방에서 만족하고 있습니다.<br/> 집에서는 유동아이피라 가끔 할 수 없는 것들이 있는데 고정아이피라서 여러가지를 이용해 볼 수 있어 좋습니다.</p>
		                            <div><a class="detail simplePopup" href="../community/edu_epilogue2.html">자세히 보기</a></div>
                                </div>
                            </div>

                            <div id="Joe" class="tabcontent">
                                <div>
                                	<img class="profile-img" id="eduProfile3" src="../imgAll/community/edu_epilogue3_1.png" /> 
		                        </div>
		                        <div class="Profile">  
		                        	<h1 class="h1">JAVA개발자 전문가 과정</h1>    
		                            <h3 class="h3">현재 생활과 실력, 취업에 대한 생각과 느낌, 계획은 어떻게 되시나요?</h3>
		                            <p class="h3-sub">현재 실력은 학원을 다니면서 많이 배우고 있습니다. 현재는 프로젝트를 진행 중인데 이 프로젝트만 성공적으로 마무리 된다면 자신감도 붙을 것 같습니다. 취업은 일단 여러 군데 지원 중 인데요. Web/Mobile 분야 SI 업체가 되지 않을까 생각해봅니다. </p>
		                            <div><a class="detail simplePopup" href="../community/edu_epilogue3.html">자세히 보기</a></div>
		                        </div>
			                </div>
                        </div>
                     
						<div id="tab03" class="tab-con">
							<div class="tab2">
                        		<button id="tablinks2" class="tablinks" onclick="openCity(event, 'Kimbj')">김봉진님</button>
                            	<button class="tablinks" onclick="openCity(event, 'Choi')">최성원님</button>
                            	<button class="tablinks" onclick="openCity(event, 'Kimty')">김태연님</button>
                    		</div>
							<div id="Kimbj" class="tabcontent">
                        		<div><img class="profile-img" id="eduProfile1" src="../imgAll/community/emp_epilogue1_1.png" /></div> 
	                            <div class="Profile">
	                            	<h1 class="h1">스마트웹과 콘텐츠 개발자 양성 과정 이수</h1>
									<h3 class="h3">지금 근무 중인 업체와 하고 있는 일에 대해 간단히 소개 부탁합니다. </h3>
	                                <p class="h3-sub">(주)PM그룹 코리아라는 폭스바겐 협력회사에서 웹프로그래머로 일하고 있습니다.<br/> 현재는 PHP로 개발된 웹을 스프링으로 바꿔주는 직무를 담당하고 있습니다.</p>
	                                <div><a class="detail simplePopup" href="../community/emp_epilogue1.html">자세히 보기</a></div>
								</div>
							</div>    
							<div id="Choi" class="tabcontent">
                        		<div><img class="profile-img" id="eduProfile2" src="../imgAll/community/emp_epilogue2_1.png" /> </div>
		                        <div class="Profile">
		                        	<h1 class="h1">스마트웹과 콘텐츠 개발자 양성 과정 이수</h1> 
									<h3 class="h3">면접 합격 비법 좀 전해 주시죠?</h3>
		                            <p class="h3-sub">합격하고 나서 들은 얘기인데요. 사실 입사 지원 당시 제 필기 시험 성적은 좋지 않았대요. 그런데 면접 때 프로젝트 했던 부분에 대해 프리젠테이션 하면서 적극적인 의지를 보였고, 그 부분에서 큰 점수를 얻어 합격한 거라고 하시더라고요. </p> 
		                            <div><a class="detail simplePopup" href="../community/emp_epilogue2.html">자세히 보기</a></div>
		                        </div>
                            </div>
                        	<div id="Kimty" class="tabcontent">
                        		<div><img class="profile-img" id="eduProfile3" src="../imgAll/community/emp_epilogue3_1.png" /> </div>
		                        <div class="Profile">
		                        	<h1 class="h1">Web publisher 양성 과정을 이수</h1>    
									<h3 class="h3">이쪽 분야로 진출하려고 하는 후배들에게 해주고 싶은 말이 있다면? </h3>
		                            <p class="h3-sub">내가 하는 일에 대해 책임감을 가지고 끈기있게 일하고, 그런 과정 자체에서 보람을 느끼며, 열심히 일한만큼 내 실력이 올라간다는 마인드를 가지고 즐기면서 일하면 좋겠다는 말을 해주고싶어요.  </p>
		                            <div><a class="detail simplePopup" href="../community/emp_epilogue3.html">자세히 보기</a></div>
	                            </div> 
	                        </div>         
                        </div>
                    </div>
                
                <script type="text/javascript">
                    $(document).ready(function() {
                        $('.simplePopup').magnificPopup({
                            type: 'ajax',
                            closeOnContentClick: true
                        });
                        
                        
                        $(window).resize(function() {
                        	var width=window.innerWidth;
                        	if(width >= 600) {
                        		$('#communityMainImg').attr('src','../imgAll/community/new_community.png')
                        	}
                        	else if(width < 600) {
                        		$('#communityMainImg').attr('src','../imgAll/community/mobile_community.png')
                        	}
                        }).resize();
                        
                    });
                    $(function() {
                        $('.popup-modal').magnificPopup({
                            type: 'inline',
                            preloader: false,
                            focus: '#username',
                            modal: true
                        });
                        $(document).on('click', '.popup-modal-dismiss', function(e) {
                            e.preventDefault();
                            $.magnificPopup.close();
                        });
                    });
                </script>

                <script type="text/javascript">    
                    //////////////////// 커뮤니티 ///////////////////////////////
                    function openCity(evt, cityName) {
                    // Declare all variables
                    var i, tabcontent, tablinks;

                    // Get all elements with class="tabcontent" and hide them
                    tabcontent = document.getElementsByClassName("tabcontent");
                    for (i = 0; i < tabcontent.length; i++) {
                        tabcontent[i].style.display = "none";
                    }

                    // Get all elements with class="tablinks" and remove the class "active"
                    tablinks = document.getElementsByClassName("tablinks");
                    for (i = 0; i < tablinks.length; i++) {
                        tablinks[i].className = tablinks[i].className.replace(" active", "");
                    }

                    // Show the current tab2, and add an "active" class to the button that opened the tab2
                    document.getElementById(cityName).style.display = "block";
                    evt.currentTarget.className += " active";
                    } 

                    $(document).ready(function() {
                    	$('#tab02-icon').click(function(event) {
                        	event.preventDefault();
                            $('.tab-con').hide();
                            $('#tab02').show();
                            $('#tablinks1').trigger('click');
                        });
                    	
                        $('#tab03-icon').click(function(event) {
                        	event.preventDefault();
                        	$('.tab-con').hide();
                        	$('#tab03').show();
                            $('#tablinks2').trigger('click');
                        });
                    });
                    /////////////////////////////////////////////////////////////
                    </script>   
                </div>
            </div><!-- -->
            
            
            <div class="dummy1" id="dummy-05">
            	<div class="dummy-div">
			    	<marquee direction="right" scrollamount="10">
	                	"Java"<img class="marqueeI" src="../imgAll/fish/rFish1.png" />
				    </marquee>
				    <marquee scrollamount="3">
				    	<img class="marqueeI" src="../imgAll/fish/lFish1.png" />"Html"
				    </marquee>
				    <marquee scrolldelay="100">
				    	<img class="marqueeI" src="../imgAll/fish/lFish4.png" />"BigData"
				    </marquee>
				    <marquee direction="right" scrolldelay="50">
				    	"jquery"<img class="marqueeI" src="../imgAll/fish/rFish2.png" />
				    </marquee>
				    <marquee direction="left" scrollamount="25">
					    <marquee direction="up" height="50" behavior="alternate" scrolldelay="5">
					    	<img class="marqueeI" src="../imgAll/fish/lFish3.png" />"Oracle"
					    </marquee>
				    </marquee>
				</div>
            </div>
            
            <div id="content-05" class="main-content">
            	<div id="content5" class="sub-content">
                    <p>한빛교육센터 홍대점에 대해 궁금한 점을 글로 남겨주세요.</p>
                    <p>담당자의 확인 후 바로 연락드리겠습니다.</p>
                    <form action="inquiry.hb" method="post">
                        <table id="QNA">
                            <tr>
                                <th class="QNA1"><label for="sub">문 의 제 목</label></th>
                                <td class="QNA2"><input type="text" id="title" name="title" /></td>
                            </tr>
                            <tr>
                                <th class="QNA1"><label for="name">이 &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;름</label></th>
                                <td class="QNA2"><input type="text" id="name" name="name" /></td>
                            </tr>
                            <tr>
                                <th class="QNA1"><label for="phone">휴대폰번호</label></th>
                                <td class="QNA2"><input type="text" id="phone" name="phone" /></td>
                            </tr>
                            <tr>
                                <th class="QNA1"><label for="con">문 의 내 용</label></th>
                                <td id="text-area" valign="top"><textarea id="con" name="memo" style="width:100%"  rows="20"></textarea></td>
                            </tr>
                        </table>

                        <button type="submit">온라인 문의하기</button>

                    </form>
                </div>
            </div>
            
            <div class="dummy1" id="dummy-06">
            	<div class="dummy-div">
			    	<marquee direction="right" scrollamount="10">
	                	"Java"<img class="marqueeI" src="../imgAll/fish/rFish1.png" />
				    </marquee>
				    <marquee scrollamount="3">
				    	<img class="marqueeI" src="../imgAll/fish/lFish1.png" />"Html"
				    </marquee>
				    <marquee scrolldelay="100">
				    	<img class="marqueeI" src="../imgAll/fish/lFish4.png" />"BigData"
				    </marquee>
				    <marquee direction="right" scrolldelay="50">
				    	"jquery"<img class="marqueeI" src="../imgAll/fish/rFish2.png" />
				    </marquee>
				    <marquee direction="left" scrollamount="25">
					    <marquee direction="up" height="50" behavior="alternate" scrolldelay="5">
					    	<img class="marqueeI" src="../imgAll/fish/lFish3.png" />"Oracle"
					    </marquee>
				    </marquee>
				</div>
            </div>
            
            <div id="content-06" class="main-content">
             	<div class="sub-content" id="content6">
                    <div>
                        <div id="map_canvas"></div>
                        <p id="mapText"><strong>한빛교육센터 홍대점 : 서울특별시 마포구 와우산로 101. (홍대역 9번출구에서 100M) &nbsp;&nbsp; ☎ 대표전화 : 02-3453-5404</strong></p>
                    </div>
                </div>
            </div>
        </div><!-- end content -->
        
        <div id="footer">
            <div id="footer-con">
                <div>
                    <img alt="logo" src="../imgAll/imgs/logo.png" />
                </div>
                <div>
                    <p id="footerText1">(주)한빛이엔아이 ｜ 사업자등록번호 : 220-85-43667 ｜ 통신판매신고 :
                        마포 제 0358호</p>
                    <br />
                    <p id="footerText2">한빛ENI : 02-707-1480 / (121-854) 서울시 마포구 신수동
                        63-14 구프라자 3층 / 대표이사 : 염기호</p>
                    <br />
                    <p id="footerText3">개인정보보호관리책임자 : 허윤</p>
                    <br />
                    <p id="footerText4">Copyright (c) 2015 한빛교육센터 All rights
                        reserved.</p>
                </div>
            </div>
	    </div>
          
        <div id="top">
            <a href="#content-01">Top</a>
        </div>
    </body>
</html>