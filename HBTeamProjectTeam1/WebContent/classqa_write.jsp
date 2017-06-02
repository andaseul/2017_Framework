<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" type="text/css" href="../css/bbs_write_table.css"/>
		<title>한빛 교육센터 LMS - 강의 게시판</title>
		<style type="text/css">
			
		</style>
		<script type="text/javascript" src="../js/jquery-1.12.4.js"></script>
		<script type="text/javascript" src="../resources/js/service/HuskyEZCreator.js" charset="utf-8"></script>
	</head>
	<body>
		<%@ include file="template/LMS_header.jspf" %>
		<div id="content">
			<div id="con-title">
				<h3>내 강의 > 강의 게시판 > 게시물 등록 </h3>
			</div>
			<form name="writeform" method="post" action="classqa_data.hb" enctype="multipart/form-data">
				<input name="username" value="<%=id %>" hidden="hidden"/>
				<table class="t2">
					<thead>
						<tr>
							<th width="15%">제 목</th>
							<td colspan="2"><input type="text" name="title"/></td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th>작성자</th>
							<th align="left"><%=id %></th>
							<th></th>
						</tr>
						<tr>
							<td colspan="3">
								<textarea id="board_content" name="memo" style="width: 100%" rows="30"></textarea>
							</td>
						</tr>
						<tr>
							<th>첨부 파일</th>
							<td colspan="2" align="left">
								<input type="file" name="file">
							</td>
						</tr>
					</tbody>			
				</table>
				<div id="con-btn">
					<p>
						<button type="button" OnClick="javascript:writeCheck();">등록</button>
						<button type="reset">취소</button>
						<button type="button" OnClick="javascript:history.back(-1)">돌아가기</button>
					</p>
				</div>
			</form>
			<script type="text/javascript">
				var oEditors = [];
				nhn.husky.EZCreator.createInIFrame({
				    oAppRef: oEditors,
				    elPlaceHolder: "board_content",
				    sSkinURI: "../resources/SmartEditor2Skin.html",
				    fCreator: "createSEditor2"
				});
				function writeCheck() {
					var inputContent = oEditors.getById["board_content"].exec("UPDATE_CONTENTS_FIELD", []);    
					var form = document.writeform;
					
					form.submit();
				}
			</script>
		</div>
		<%@ include file="template/LMS_footer.jspf" %>
	</body>
</html>