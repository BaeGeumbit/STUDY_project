<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link href="https://fonts.googleapis.com/css?family=Timmana" rel="stylesheet">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="/resource/login.css">
	
    <script type="text/javascript">	 
		  function login(){
			 var id = $('#id').val();
			 var passwd = $('#passwd').val();
			 
			 if(id == ""){
				 alert("아이디를 입력해주세요");
			 }else if(passwd == ""){			
				 alert("비밀번호를 입력해주세요");
				 $('#id').val(id);
			 }else{
				 $.ajax({
					method : "POST",
					data : {
						"id" : id,
						"passwd" : passwd
					},
					url : "/login/check",
					dataType : "text",
					success : function(data){		
						//alert()
						if(data == 1){
							loginfrm.action="/index";
							loginfrm.method="post";
							loginfrm.submit();
						}else if(data == 2){
							alert('비밀번호를 확인해주세요');
						}else if(data == 3){
							alert('입력하신 아이디가 없습니다');
						}
					},
					error : function(request,status,error){
						alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);	
					}			
				 });
			 }
		  }	  
    </script>

  </head>
  
  <body>
	  <div>
	  	<div class="col-xs-4 col-xs-offset-4 loginbox">
	  		<form id="loginfrm" name="loginfrm">
	        <h2>ITeyes</h2>
	        <div class="input-group">
			    <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
			    <input id="id" type="text" class="form-control" name="id" placeholder="아이디를 입력해주세요">
			</div>
			<div class="input-group">
			    <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
			    <input type="password" id="passwd" name="passwd" class="form-control" placeholder="패스워드를 입력해주세요"> 
			</div>      
			<br>
			<button id="loginbt" class="btn btn-primary" onclick="login()">Login</button>	        
	      </form>
	  	</div>
	  	<!-- .col-xs-4 col-xs-offset-4 loginbox -->
	  </div>
  </body>
  
</html>



