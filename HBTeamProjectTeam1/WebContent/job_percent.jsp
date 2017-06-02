<%@page import="com.team1.admin.dto.ClassJobDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" type="text/css" href="../css/bbs_table.css"/>
		<title>한빛 교육센터 LMS - 취업 지원</title>
		<style type="text/css">
		
		</style>
		<script type="text/javascript" src="../js/jquery-1.12.4.js"></script>
		<script src="https://code.highcharts.com/highcharts.js"></script>
		<script src="https://code.highcharts.com/modules/exporting.js"></script>
		<script src="https://code.highcharts.com/modules/data.js"></script>
	</head>
	<%
		ArrayList<ClassJobDTO> list = (ArrayList<ClassJobDTO>) request.getAttribute("list");
		System.out.println("jsp-page : 성공 : " + list.get(0).getJob_suc());
	%>
	
	<body>
		<%@ include file="template/LMS_header.jspf" %>
		<div id="content">
			<div id="con-title">
				<h3>취업 지원 > 취업률 통계</h3>
			</div>
			
			<div id="con-grap">
				<div id="con-grap-1">
					<div id="container"></div>
				</div>
				<div id="con-grap-2">
					<table class="t1 t3">
					    <thead>
					        <tr>
					            <th colspan="4">한빛 교육센터 취업률 현황</th>
					        </tr>
					    </thead>
					    <tbody>
					    	<tr>
					    		<th>취업성공</th>
					    		<td><%=list.get(0).getJob_suc() %>%</td>
					    		<th>구직자</th>
					    		<td><%=list.get(0).getJob_fail() %>%</td>
					    	</tr>
					    </tbody>
					</table>
					
					<table class="t1 t3">
					    <thead>
					        <tr>
					            <th>강의코드</th>
					            <th>취업성공</th>
					            <th>구직자</th>
					        </tr>
					    </thead>
					    <tbody>
					    	<% for(int i=1; i<list.size(); i++) { %>
					        <tr>
					            <th><%=list.get(i).getClass_code() %></th>
					            <td><%=list.get(i).getJob_suc() %>%</td>
					            <td><%=list.get(i).getJob_fail() %>%</td>
					        </tr>
					        <% } %>
					    </tbody>
					</table>
				</div>
				<div id="con-grap-3">
					<div id="container2" ></div>
				</div>
			</div>
		</div>
		
		<table id="datatable">
			<thead>
				<tr>
					<th>강의코드</th>
					<th>취업성공</th>
					<th>구직자</th>
				</tr>
			</thead>
			<tbody>
				<% for(int i=1; i<list.size(); i++) { %>
				<tr>
					<th><%=list.get(i).getClass_code() %></th>
					<td><%=list.get(i).getJob_suc() %></td>
					<td><%=list.get(i).getJob_fail() %></td>
				</tr>
				<% } %>
			</tbody>
		</table>
		
		<script type="text/javascript">
			$(document).ready(function () {
			    // Build the chart
			    Highcharts.chart('container', {
			        chart: {
			            plotBackgroundColor: null,
			            plotBorderWidth: null,
			            plotShadow: false,
			            type: 'pie'
			        },
			        title: {
			            text: '전체 수강생 취업률'
			        },
			        tooltip: {
			            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
			        },
			        plotOptions: {
			            pie: {
			                allowPointSelect: true,
			                cursor: 'pointer',
			                dataLabels: {
			                    enabled: false
			                },
			                showInLegend: true
			            }
			        },
			        series: [{
			            name: '퍼센트',
			            colorByPoint: true,
			            data: [{
			            	name: '취업성공',
			                y: <%=list.get(0).getJob_suc()%>
			            }, {
			            	name: '구직자',
			                y: <%=list.get(0).getJob_fail()%>
			            }]
			        }]
			    });
			});
			
			Highcharts.chart('container2', {
			    data: {
			        table: 'datatable'
			    },
			    chart: {
			        type: 'column'
			    },
			    title: {
			        text: '한빛교육센터 수강생 취업 현황'
			    },
			    yAxis: {
			        allowDecimals: false,
			        title: {
			            text: '취업현황'
			        }
			    },
			    tooltip: {
			        formatter: function () {
			            return '<b>' + this.point.name.toLowerCase() + '</b><br/>' +
			                this.series.name +' ' + this.point.y + '% ';
			        }
			    }
			});
    	</script>
		<%@ include file="template/LMS_footer.jspf" %>
	</body>
</html>
