<%@page import="com.team1.util.HanbitClassNoticeDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.team1.util.HanbitNoticeDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>한빛 교육센터 LMS</title>
		<script type="text/javascript" src="../js/jquery-1.12.4.js"></script>
		<script type="text/javascript" src="../js/jquery-ui.min.js"></script>
		
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" type="text/css"/>  
		
		<link href="../css/fullcalendar.css" rel="stylesheet"/>
		<link href="../css/fullcalendar.print.css" rel="stylesheet" media="print"/>
		<link href="../css/LMSMain.css" rel="stylesheet"/>
		
		<script type="text/javascript" src="../js/moment.min.js"></script>
		<script type="text/javascript" src="../js/fullcalendar.min.js" charset="euc-kr"></script>
		<script type="text/javascript" src="../js/ko.js"></script>
		
		<style type="text/css">
			.ui-datepicker-calendar>tbody td.ui-datepicker-week-end:first-child a {
				color: red;
			}
			
			.ui-datepicker-calendar>tbody td.ui-datepicker-week-end:last-child a {
				color: blue;
			}
		</style>
		<script type="text/javascript">
			$(document).ready(function() {
				$(function() {
					$( "#calendar" ).datepicker({
						dateFormat: 'yy-mm-dd',
						changeMonth: true,
						changeYear: true,
						dayNamesMin: ['일','월','화','수','목','금','토'],
						showMonthAfterYear: true
					});
				});
			});
		</script>
	</head>
	<%
		request.setCharacterEncoding("UTF-8");
		ArrayList<HanbitNoticeDTO> list = (ArrayList<HanbitNoticeDTO>) request.getAttribute("notice_info");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String curdate = sdf.format(new Date());
	%>
	<body>
		<%@ include file="template/LMS_header.jspf" %>
		<div id="content">
			<div id="con1" class="mcon">
				<div>
					<h3>공지사항</h3>
					<a href="notice_bbs.hb?page=1">더보기</a>
				</div>
				<div>
					<table class="maint">
						<tbody>
							<% for(HanbitNoticeDTO bean : list) { %>
							<tr>
								<td width="25%"><%=bean.getName() %></td>
								<td width="50%">
									<a href = "notice_detail.hb?idx=<%=bean.getIdx() %>&hit=<%=bean.getHit() %>"><%=bean.getTitle() %></a>
									<% if(curdate.equals(bean.getCurdate())) { %>
									<img src="../imgAll/icon/ico-new.png">
									<% } %>
								</td>
								<td width="25%">
									<% if(curdate.equals(bean.getCurdate())) { %>
									<%=bean.getCurtime() %>
									<% } else { %><%=bean.getCurdate() %><% } %>
								</td>
							</tr>
							<% } %>
						</tbody>
					</table>
				</div>
			</div>
			
			<div id="con-cal" class="mcon">
				<div>
					<h3>한빛 Calendar (<%=curdate %>)</h3>
				</div>
				<div id="aaaaa"><div id='calendar'></div></div>
			</div>
			
			<% if(hb_code == 1 || hb_code == 3) { %>
			<% ArrayList<HanbitClassNoticeDTO> list2 = (ArrayList<HanbitClassNoticeDTO>) request.getAttribute("class_notice_info"); %>
			<div id="con2" class="mcon">
				<div>
					<h3>강의 공지</h3>
					<a href="classnotice_bbs.hb?page=1">더보기</a>
				</div>
				<div>
					<table class="maint">
						<tbody>
							<% for(HanbitClassNoticeDTO bean : list2) { %>
							<tr>
								<td width="25%"><%=bean.getName() %></td>
								<td width="50%">
									<a href = "classnotice_detail.hb?idx=<%=bean.getIdx() %>&hit=<%=bean.getHit() %>"><%=bean.getTitle() %></a>
									<% if(curdate.equals(bean.getCurdate())) { %>
									<img src="../imgAll/icon/ico-new.png">
									<% } %>
								</td>
								<td width="25%">
									<% if(curdate.equals(bean.getCurdate())) { %>
									<%=bean.getCurtime() %>
									<% } else { %><%=bean.getCurdate() %><% } %>
								</td>
							</tr>
							<% } %>
						</tbody>
					</table>
				</div>
			</div>
			<% } %>
		
			
		</div>
		<%@ include file="template/LMS_footer.jspf" %>
		
	</body>
</html>