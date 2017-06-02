<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	    <h1>입력페이지</h1>
		<p>...</p>    
  	</div>
   <form action="insert.action">
      <div class="form-group">
         <label for="sabun">사번</label>
          <input   type="text" name="sabun" class="form-control" id="sabun" placeholder="Example input">
      </div>
      <div class="form-group">
         <label for="name">이름</label>
          <input   type="text" name="name" class="form-control" id="name" placeholder="Another input">
      </div>
      <div class="form-group">
         <label for="pay">금액</label>
          <input   type="text" name="pay" class="form-control" id="pay" placeholder="Example input">
      </div>
      <button type="submit" class="btn btn-default">submit</button>
   </form>

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>