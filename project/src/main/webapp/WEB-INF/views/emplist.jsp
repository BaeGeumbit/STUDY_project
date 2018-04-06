<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="ko">

	<%@include file="header.jsp" %>
	
	<script type="text/javascript">
		$(document).ready(function(){
			
			$('#selectSearch li > a').on('click', function() {			    
			    $('#selectStatus').html(""+$(this).text()+"&nbsp;<span class='caret'></span>");			        
			   
			    var dropname = '';
			    
			    if($(this).text() == '이름'){
			    	dropname='EMP_NAME';
			    }else if($(this).text() == '부서'){
			    	dropname='DPT_NAME';
			    }else if($(this).text() == '상태'){
			    	dropname='EMP_STTS';
			    }
			    
			    $('#empSearchDrop').val(dropname);			    
			});	
			
			$('#empSearchBt').click(function(){				
				if($('#empSearchText').val() == "" || $('#empSearchText').val() == null){					
					alert('검색 내용을 입력해주세요');
					$('#selectStatus').html(""+$('#empSearchDrop').val()+"&nbsp;<span class='caret'></span>");			
				}else{					
					emplistfrm.action ="/emplist/search";
					emplistfrm.submit();				
				}
			});
			
			$("[id='check-2']").click(function(){
				//alert($('#empSearchDrop').val());
				//emplistfrm.action ="/emplist/search";
				//alert($(this).attr('name'));		
				  var drop= '';
				 //alert($('#selectStatus').text());   
			    if($('#selectStatus').text().trim() == '이름'){
			    	drop='EMP_NAME';
			    }else if($('#selectStatus').text().trim() == '부서'){
			    	drop='DPT_NAME';
			    }else if($('#selectStatus').text().trim() == '상태'){
			    	drop='EMP_STTS';
			    }
			    //alert(drop);
			    $('#empSearchDrop').val(drop);	
			    
				$('#page').val($(this).attr('name'));
				emplistfrm.action = "/emplist/search";
				emplistfrm.submit();
				
			});
			
		}); // document.ready	
		
	</script>
		
		<div class="col-xs-10 right">
			<div class="container">
				<br>
				  <h3>사원 목록</h3>
				  <p>사원 목록입니다. 궁시렁 궁시렁</p>
				  <button type="button" class="btn btn-default" id="newMembt" onclick="location='/newMember'"> 
				 	신규
				 </button> 
				  <br> 
				  <form name="emplistfrm" method="post">
				    <input type="hidden" id="check" name="check" value="">
				    <input type="hidden" id="page" name="page" value="1">
					<input type="hidden" id="empSearchDrop" name="empSearchDrop" value="">
					  <div class="col-xs-10 form-group list-text">
					  	 <div class="dropdown">
							  <button class="btn btn-primary dropdown-toggle"  id="selectStatus" type="button" 
							  				data-toggle="dropdown">${searchDrop}
							  <span class="caret"></span></button>
							  <ul class="dropdown-menu" id="selectSearch">
							  	<li><a>전체</a></li>
							    <li><a>이름</a></li>
							    <li><a>부서</a></li>
							    <li><a>상태</a></li>
							  </ul>
						 </div>			  	
						 <input type="text" class="form-control" id="empSearchText" name="empSearchText" 
						 			value="${searchText}"	placeholder="검색할 내용을 입력해주세요">
						 <button type="submit" class="btn btn-default" id="empSearchBt"> 
						 	<i class="glyphicon glyphicon-search"></i>
						 </button>
					  </div> <!-- .col-xs-10 form-group list-text -->
				  </form>
				  
				  <div class="col-xs-2"></div>
				 
				  <br><br><br><br>
				  <table class="table table-striped list-table">
				     <c:if test="${check == 1 || check == 2}">
					    <thead>
					      <tr>
					        <th>사원번호</th>
					        <th>성명</th>
					        <th>상태</th>
					        <th>부서</th>
					        <th>직급</th>
					        <th>연락처</th>
					        <th>Email</th>
					      </tr>
					    </thead>
				    
					    <tbody>				   
					    	<c:forEach var="emp" items="${emplist}">
					      	<tr ondblclick="location.href='/empinfo?emp_no=${emp.EMP_NO}'">
					      		<td>${emp.EMP_NO}</td>
					      		<td>${emp.EMP_NAME}</td>
					      		<td>${emp.EMP_STTS_NAME}</td>
					      		<td>${emp.DPT_NAME}</td>
					      		<td>${emp.RNK_NAME}</td>
					      		<td>${emp.CNTCT_NO}</td>
					      		<td>${emp.COMP_EMAIL}</td>
					      	</tr>				    	
					      </c:forEach>					      
					    </c:if>	
					    			   
					    <c:if test="${check == 3}">
					    	<tr>
					      		<td colspan="6" style="text-align:center;">검색결과가 없습니다</td>
					      	</tr>
					    </c:if> 			
					    <c:if test="${check == 4}">
					    	<tr>
					      		<td colspan="6" style="text-align:center;">사원이 존재하지 않습니다</td>
					      	</tr>
					    </c:if>     					  	       				      
					   </tbody> 
				  </table>
				
				<c:if test="${check == 1}">
					<div class="col-xs-12">
						<ul class="pager pagenum">
							<c:if test="${pre == true}"> 
								 <li><a href="/emplist?page=${startPage-pageSize}">◀</a></li>
							</c:if>						
							<c:set var="p" value="${startPage}"/>
							<c:forEach begin="${startPage}" end="${endPage}">
								<li><a href="/emplist?page=${p}">${p}</a></li>
								<c:set var="p" value="${p+1}"/>
							</c:forEach>						
							<c:if test="${next == true}"> 
								 <li><a href="/emplist?page=${endPage+1}">▶</a></li>
							</c:if>		  
					  	</ul>
					</div> <!-- .col-xs-12 -->
				</c:if>
				
				<c:if test="${check == 2}">
					<div class="col-xs-12">
						<ul class="pager pagenum">
							<c:if test="${pre == true}"> 
								 <li><a id="check-2" name="${startPage-pageSize}" href="#">◀</a></li>
							</c:if>						
							<c:set var="p" value="${startPage}"/>
							<c:forEach begin="${startPage}" end="${endPage}">
								<li><a id="check-2" name="${p}" href="#">${p}</a></li>
								<c:set var="p" value="${p+1}"/>
							</c:forEach>						
							<c:if test="${next == true}"> 
								 <li><a id="check-2" name="${endPage+1}" href="#">▶</a></li>
							</c:if>		  
					  	</ul>
					</div> <!-- .col-xs-12 -->
				</c:if>
				
			</div>  <!-- .container -->
		</div><!-- .col-xs-10 right-->	
	</div><!-- .index -->

</html>