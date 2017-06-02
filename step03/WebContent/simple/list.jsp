<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>Bootstrap 101 Template</title>

    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  <body>
  
  <div class="jumbotron">
  	 <h1>리스트페이지</h1>
 		<p>...</p>
    <p><a class="btn btn-primary btn-lg" href="add.action" role="button">입력</a></p>
  	</div>
    
    <table class="table">
    	<tr>
    		<th>사번</th>
    		<th>이름</th>
    		<th>날짜</th>
    		<th>금액</th>
    	</tr>
    	<c:forEach items="${list }" var="bean">
    	<tr>
    		<td>${bean.sabun }</td>
    		<td><a href="detail.action?sabun=${bean.sabun }">${bean.name }</a></td>
    		<td>${bean.nalja }</td>
    		<td>${bean.pay }</td>
    	</tr>
    	</c:forEach>
    </table>
    

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>