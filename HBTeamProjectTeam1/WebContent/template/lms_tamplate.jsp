<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="utf-8">
        <title>LMS SYSTEM</title>
        <link rel="stylesheet" type="text/css" href="../css/LMSTemplate.css"/>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script type="text/javascript" src="js/jquery-1.12.4.js"></script>
        <style type="text/css">
            
        </style>
        <script type="text/javascript" src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                
                // Create two variable with the names of the months and days in an array
                var monthNames = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"];
                var dayNames = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"]

                // Create a newDate() object
                var newDate = new Date();
                // Extract the current date from Date object
                newDate.setDate(newDate.getDate());
                // Output the day, date, month and year    
                $('#Date').html(newDate.getFullYear() + "년 " + monthNames[newDate.getMonth()] + ' ' + newDate.getDate() + '일 ' + dayNames[newDate.getDay()]);

                setInterval(function() {
                    // Create a newDate() object and extract the seconds of the current time on the visitor's
                    var seconds = new Date().getSeconds();
                    // Add a leading zero to seconds value
                    $("#sec").html((seconds < 10 ? "0" : "") + seconds);
                }, 1000);

                setInterval(function() {
                    // Create a newDate() object and extract the minutes of the current time on the visitor's
                    var minutes = new Date().getMinutes();
                    // Add a leading zero to the minutes value
                    $("#min").html((minutes < 10 ? "0" : "") + minutes);
                }, 1000);

                setInterval(function() {
                    // Create a newDate() object and extract the hours of the current time on the visitor's
                    var hours = new Date().getHours();
                    // Add a leading zero to the hours value
                    $("#hours").html((hours < 10 ? "0" : "") + hours);
                }, 1000);

            });
        </script>
        <link rel="canonical" href="http://www.alessioatzeni.com/wp-content/tutorials/jquery/CSS3-digital-clock/index.html" />
    </head>
	<%
		String id = (String) session.getAttribute("id");
		String name = (String) session.getAttribute("name");	
		int hb_code = ((Integer)session.getAttribute("hb_code")).intValue();
	%>
    <body>
        <div id="header">
            <a href="#"><img alt="logo" src="../imgAll/imgs/logo4.jpg"/></a>
            <div class="container">
                <div class="clock">
                    <div id="Date"></div>
                    <ul>
                        <li id="hours"></li>
                        <li id="point">:</li>
                        <li id="min"></li>
                        <li id="point">:</li>
                        <li id="sec"></li>
                    </ul>
                </div>
            </div>
        </div>
        <label for="toggle">MENU</label>
        <input type="checkbox" id="toggle"/>
        <div class="dropmenu">
            <ul id="dropdown">
                <div id="profile"></div>
                <div id="profileInfo">
                    <p><span><%=name %> 님</span><br/></p>
                    <p>
                        <a href="#">MyPage</a>
                        <a href="#">LogOut</a>
                    </p>
                </div>
                
                <li class="main-menu">공 지 &nbsp;사 항
                    <ul>
                        <li class="sub-menu"><a href="#">- 게시판</a></li>
                        <li class="sub-menu">- 공지 등록</li>

                    </ul>
                </li>
                
                <!-- 학생 메뉴 -->
                <% if(hb_code==1) { %>
                <li class="main-menu">내 강의
                    <ul>
                        <li class="sub-menu">- 강의 공지</li>
                        <li class="sub-menu">- 강의 게시판</li>
                        <li class="sub-menu">- 온라인 시험</li>
                        <li class="sub-menu">- 성적 확인</li>
                    </ul>
                </li>
                <li class="main-menu">출석 정보
                	
                </li>
                <li class="main-menu">취업 정보
                    <ul>
                        <li class="sub-menu">- 구인정보 게시판</li>
                        <li class="sub-menu">- 컨설팅 게시판</li>
                    </ul>
                </li>
                
                <!-- 행정 메뉴 -->
                <% } else if(hb_code==2) { %>
                <li class="main-menu">수강생 관리
                    <ul>
                        <li class="sub-menu">- 수강생 정보변경</li>
                        <li class="sub-menu">- 출석관리</li>
                    </ul>
                </li>
                <li class="main-menu">직 원&nbsp; 관 리
                    <ul>
                        <li class="sub-menu">- 직원 정보변경</li>
                    </ul>
                </li>
                <li class="main-menu">강 의 &nbsp;관 리
                    <ul>
                        <li class="sub-menu">- 신규강의개설</li>
                        <li class="sub-menu">- 기존강의변경</li>
                    </ul>
                </li>	
                
                <!-- 강사 메뉴 -->
                <% } else if(hb_code==2) { %>
                <li class="main-menu">내 강의
                    <ul>
                        <li class="sub-menu">- 강의 공지</li>
                        <li class="sub-menu">- 강의 게시판</li>
                        <li class="sub-menu">- 온라인 시험</li>
                        <li class="sub-menu">- 성적 확인</li>
                    </ul>
                </li>
                <li class="main-menu">출결 관리
                	
                </li>
                
                <!-- 영업 메뉴 -->
                <% } else if(hb_code==3) { %>
                
                
                <!-- 취업지원 메뉴 -->
                <%  } else if(hb_code==4) { %>
                
                
                <% } %>
                
            </ul>
        </div>
        <div id="frame_content">
            <div id="dummy_top"></div>
            <div>
                <div id="dummy_left">&nbsp;</div>
                <div id="main_content">

                    <h1>콘텐츠 자리입니다.</h1>

                </div>
            </div>
        </div>
    </body>

</html>