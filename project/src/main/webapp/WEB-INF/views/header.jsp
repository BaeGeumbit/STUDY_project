<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">	
		<link href="https://fonts.googleapis.com/css?family=Titillium+Web" rel="stylesheet">
		<link href="/resource/custom.css" rel="stylesheet" type="text/css">		
	
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<script type="text/javascript">
			$(document).ready(function(){
				
				$(".left li").on("click", function() {
		            location.href = $(this).attr('id');
		        });
				
				$('#logout').click(function(){
					
					$.ajax({
						url : "/logout",
						dataType : "text",
						success : function(data){
							
							if(data == "success"){
								alert("안녕히 가시라네");	
								location.href="/login";
							}else if(data == "fail"){
								alert("session 아직 남았네..")
							}else{
								alert(data+"뭔가 안됐네");
							}
						},
						error : function (request,status,error){
							alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);	
						}
					});				
				});
			});	//document
		</script>
	</head>
	
	<body>
	
		<div class="index">
		
		<div class="col-xs-12 top">
			<div class="col-xs-1 top-brand">
				<a href="/index" class="iteyes">ITeyes</a>
			</div>
			<div class="col-xs-1 top-info">
				${sessionScope.emp_no} / ${sessionScope.emp_name}
			</div>
			<div class="col-xs-1"></div>
			<div class="col-xs-1"></div>
			<div class="col-xs-8 text-right logout">
				<a href="#" id="logout">logout</a>
			</div>
			
		</div>
		<div class="col-xs-2 left">
			<ul>
				<li id="/emplist?page=1"><a href="#">사원 관리</a></li>
				<li id="/skill"><a href="#">Skill Inventory</a></li>
				<li id="/updatePasswd"><a href="#">비밀번호 변경</a></li>
			</ul>
		</div>
		
	</body>
</html>