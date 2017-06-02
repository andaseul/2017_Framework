<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
		<link rel = "stylesheet" href = "css/bootstrap.min.css">
		<script
		  src="https://code.jquery.com/jquery-1.12.4.min.js"
		  integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ="
		  crossorigin="anonymous"></script>
		  <script type="text/javascript" src = "js/bootstrap.min.js"></script>
  
</head>
<body>
	<div class = "container">
		<div class="row header">
			<div class="col-md-12">
			<h1>한빛교육센터</h1>
			</div>
		</div>
		<div class="row content">
		
		<div class="jumbotron">
			  <h1 >환영합니다.</h1>
			  <p >한빛 교육센터 홈페이지 입니다. </p>
			  <p><a class="btn btn-primary btn-lg" href="add.do" role="button">글쓰기</a>
			  </p>
		</div>
		<!-- content start -->
		<div class="page-header">
		<h1>게시판<small>글을 작성합니다.</small></h1>
		</div>
		
		<table class="table table-striped">
			<tr>
				<th>사번</th>
				<th>아름</th>
				<th>날짜</th>
				<th>금액</th>
			</tr>
		<c:forEach items="${alist }" var="bean">
			<tr>
				<td>${bean.sabun }</td>
    			<td>${bean.name }</td>
    			<td>${bean.nalja }</td>
    			<td>${bean.pay }</td>
			</tr>
			</c:forEach>
		</table>
		
		</div>
		
		
		
		<!-- content end -->
		
		<div class="row footer">
			<div class="col-md-12">
				(주)한빛이엔아이 ｜ 사업자등록번호 : 220-85-43667 ｜ 통신판매신고 : 마포 제 0358호
한빛ENI : 02-707-1480 / (121-854) 서울시 마포구 신수동 63-14 구프라자 3층 / 대표이사 : 염기호
개인정보보호관리책임자 : 허윤
Copyright (c) 2015 한빛교육센터 All rights reserved.
			</div>
		</div>
	
	</div>


</body>
</html>