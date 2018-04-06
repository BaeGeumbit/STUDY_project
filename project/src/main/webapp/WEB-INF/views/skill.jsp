<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

	<%@include file="header.jsp" %>
	
	<script type="text/javascript">
		$(document).ready(function(){
			
			
			
		}); // document.ready	
	</script>
		
		<div class="col-xs-10 right">
			<div class="container">
				<br><br>
				  <form name="skillfrm" method="post">
					  <div class="col-xs-10 form-group list-text">
					  	 <div class="dropdown">
							  <button class="btn btn-primary dropdown-toggle"  id="selectStatus" type="button" 
							  				data-toggle="dropdown">${searchDrop}
							  <span class="caret"></span></button>
							  <ul class="dropdown-menu" id="selectSearch">
							  	<li><a>전체</a></li>
							    <li><a>사원번호</a></li>
							    <li><a>사원명</a></li>
							    <li><a>프로젝트명</a></li>
							  </ul>
						 </div>			  	
						 <input type="text" class="form-control" name="skillsearchText" 
						 			value="${searchText}"	placeholder="검색할 내용을 입력해주세요">
						 <button type="submit" class="btn btn-default" id="empSearchBt"> 
						 	<i class="glyphicon glyphicon-search"></i>
						 </button>
					  </div> <!-- .col-xs-10 form-group list-text -->
				  </form>
				  
				  <div class="col-xs-2"></div>
				 
				  <br><br><br><br>
				  <table class="table table-striped list-table">
				     
					    <thead>
					      <tr>
					        
					      </tr>
					    </thead>
				    
					    <tbody>				   
					    	   					  	       				      
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