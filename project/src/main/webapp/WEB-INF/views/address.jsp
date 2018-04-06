<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>주소 검색</title>
		
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">	
	<link href="https://fonts.googleapis.com/css?family=Titillium+Web" rel="stylesheet">
	<link href="/resource/custom.css" rel="stylesheet" type="text/css">	
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	

	<style>	
	</style>
	
	<script type="text/javascript">
	
		$(document).ready(function(){
			
			
			
			
			
		});
		
		
		function search(){
			
			var text = $('#searchAddr').val();
			
			if(text == "" || text == null){
				 alert("검색어를 입력해주세요");				 
			}else{
				 $.ajax({
					method : "POST",
					data : {
						"searchAddr" : text
					},
					url : "/address",
					dataType : "text",
					
					success : function(data){		
						
						var result = eval(data);						
						var str = "";
						
						$(result).each(function(index, item){							
							str += "<tr id='c'>"
								 + "	<td id='b'>"+item.ZIP_CODE+"</td>"
								 + "	<td id='a'>"+item.ADDR+"</td>"
								 + "	<td><button class='btn btn-default addr-bt' onClick='goout(this)' name='"+item.ADDR+"' id='"+item.ZIP_CODE+"'>선택</button></td>"
							     + "</tr>";							
						});
						
						$(str).appendTo($('#addrtbody'));			
					},
					error : function(request,status,error){
						alert('다시 한 번 입력해주세요 에러에러');			
					}			
				 });
			 }			
		}//search
		
// 		$('#hello').click(function(){
// 			alert('hello@');
// 		});
		
		function goout(obj){
			//alert(obj);
			var zip = $(obj).attr('id');
			var addr = $(obj).attr('name');
			
			//alert(zip+"/"+addr);
			
			$("#ZIP_CODE", parent.opener.document).val(zip);
			$("#HOME_ADDR", parent.opener.document).val(addr);
		    window.close();
		}
	</script>	
	</head>
	<body>

		<div class="col-xs-12 addr-top">
			주소 검색
		</div>
		
		<div class="container">
			<form name="addrfrm" method="post">
				  
				<div class="col-xs-12 addr">
					<div class="form-group search">
						<input type="text" class="form-control searchAddr" id="searchAddr" name="searchAddr" 
							value="" placeholder="검색할 내용을 입력해주세요">
						 <button type="button" class="btn btn-default" onclick="search()"> 
						 	<i class="glyphicon glyphicon-search"></i>
						 </button>
					<hr>
					</div>
					
					<div class="col-xs-12">
						<table class="table addr-result">
							<thead>
								<tr>
									<th colspan='3'>
										검색 결과
									</th>
								</tr>
							</thead>
							
							<tbody id="addrtbody">
								<tr>
									<th style="width:20%;"> 우편번호 </th>
									<th style="width:50%;"> 주소 </th>
									<th style="width:20%;"> 선택 </th>
								</tr>	
								
								
							</tbody>
						</table>
					</div>
					
				</div>
			</form>	
		</div>	
		<!-- .container -->
		
	</body>
</html>










