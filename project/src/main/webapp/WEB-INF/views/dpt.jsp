<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>부서 검색</title>
		
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">	
	<link href="https://fonts.googleapis.com/css?family=Titillium+Web" rel="stylesheet">
	<link href="/resource/custom.css" rel="stylesheet" type="text/css">	
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
	<script type="text/javascript">
		$(document).ready(function(){
			getdpt();
			
			$('#ok').click(function(){

				var array = new Array();
				var array2 = new Array();
				var array3 = new Array();
				$('.check').each(function(i,t){
					if( $(t).is(":checked") == true ){
						array.push($(t).attr('name'));
						array2.push($(t).attr('id'));
						array3.push($(t).attr('value'));
					}
				});				
 				 $("#dpt_name", parent.opener.document).val(array);
 				 $("#dpt_code", parent.opener.document).val(array2);
 				 $("#dpt_strt_date", parent.opener.document).val(array3);
 			     window.close();
			});

			
			$('#searchDrop li > a').on('click', function() {			    
			    $('#selectStatus').html(""+$(this).text()+"&nbsp;<span class='caret'></span>");			        
			   
			    var dropname = '';
			    
			    if($(this).text() == '전체') {
			    	dropname='ALL';
			    	$('#searchText').val("");
			    	getdpt();
			    }else if($(this).text() == '부서코드') dropname='DPT_CODE';
			    else if($(this).text() == '부서명') dropname='DPT_NAME';
			    		    
			    $('#searchDrop').val(dropname);	
			});   
		});	//document.ready
			
		function getdpt(){
			
			 $.ajax({
					method : "POST",
					data : {
						"searchDrop" : $('#searchDrop').val(),
						"searchText" : $('#searchText').val()
					},
					url : "/dpt/search",
					dataType : "json",
					success : function(data){		
						
						$("#dpt-info").empty();
						
						for(var i=0; i<data.dptlist.length; i++){
							
							var str = "";
							
							str += "<ul id='"+data.dptlist[i].DPT_CODE+"' class='ul"+data.dptlist[i].DPT_CODE+"'>"
							     + " <li name='"+data.dptlist[i].DPT_CODE+"' class='li"+data.dptlist[i].DPT_CODE+"'>"
							     + "		<input type='checkbox' class='check' id='"+data.dptlist[i].DPT_CODE+"' value='"+data.dptlist[i].APLY_STRT_DATE+"' name='"+data.dptlist[i].DPT_NAME+"'>&nbsp;&nbsp;&nbsp;"
							     +			data.dptlist[i].DPT_NAME_EXT
							     + "<hr style='margin:7px;'/>"
							     + " </li>"
								 + "</ul>";				
								 
							if(i == 0){
								$(str).appendTo('.dpt-info');
							}else{
								$(str).appendTo('[name="'+data.dptlist[i].HRNK_DPT_CODE+'"]');
							}							
						} //for		
						
						if("${dpt_name}" != null && "${dpt_name}" != ""){
							var dptSplit = "${dpt_name}".split(",");
							
							for(var i in dptSplit){				
								//alert(dptSplit[i]);	
								var str = dptSplit[i];
								$("input[name='"+dptSplit[i]+"']").attr("checked", "checked");
							}	
						}
										
					},
					error : function(request,status,error){
						alert('다시 한 번 입력해주세요 에러에러');									
					}			
				 }); 
		 } //getdpt()
		 
	</script>		
	</head>
	
	<body>

		<div class="col-xs-12 addr-top">
			부서 검색
		</div>		
		
		<div class="container dpt-container">
			<div class="dropdown col-xs-offset-2">
				  <button class="btn btn-primary dropdown-toggle"  id="selectStatus" type="button" 
				  		 data-toggle="dropdown">${searchDrop}
				  <span class="caret"></span></button>
				  <ul class="dropdown-menu" id="searchDrop">
				  	<li><a>전체</a></li>
				    <li><a>부서코드</a></li>
				    <li><a>부서명</a></li>
				  </ul>
			 </div>			  	
			 <input type="text" class="form-control" id="searchText"
			 			value="${searchText}"	placeholder="검색할 내용을 입력해주세요">
			 <button type="button" class="btn btn-default" onclick="getdpt()"> 
			 	<i class="glyphicon glyphicon-search"></i>
			 </button>
		 <br><br><br><br>
		 	<div class="col-xs-1">
		 		&nbsp;
		 	</div>
			<div class="col-xs-10 dpt-info" id="dpt-info">
				
			</div>
			<!-- .dpt-info -->
			
			<br><br><br><br><br><br><br><br>
			<div class="col-xs-12">
				<div class="col-xs-offset-6">
					<button type="button" id="ok" class="btn btn-default center" > 
			 		확인
					</button>
				</div>				
			</div>
			
		</div>	
		<!-- .container -->
		<br><br><br><br>
	</body>
</html>