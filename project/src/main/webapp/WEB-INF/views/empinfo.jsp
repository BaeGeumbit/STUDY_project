<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="ko">
	<%@include file="header.jsp" %>
	
	<script type="text/javascript">	
		
		$(document).ready(function(){
			
			var grdn_str = "${grdn_str}";
			var degr_str = "${degr_str}";
			var wrk_str = "${wrk_str}";		
			

			if("${first_check}" == "new"){
				 $("input").not("[name='emp_name']").each(function(i){ 
					 $(this).attr("readonly",true);
				 });			 
				 $('button').not("[id='new_bt']","[id='new_cancel_bt']").each(function(){
					 $(this).attr('disabled',true);
				 });		 
				 $('select').each(function(){
					 $(this).attr('disabled',true);
				 });
				 $('input[type="radio"]').each(function(){
					 $(this).attr('disabled',true);
				 });
			}
		
		//////사용자에 따른 버튼 부여
			if("${empBasicinfo.AUTH_CLS_CODE}" == '01'){
				$("[name='emp_check_01']").show();
				$("[name='emp_check_02']").hide();
				$('#AUTH_CLS_CODE').val('01');
			}else{
				$("[name='emp_check_01']").hide();
				$("[name='emp_check_02']").show();
				$('#AUTH_CLS_CODE').val('02');
			}
			
			$("[id='emp_check']").on('click',function(){
				if($(this).attr('name') == 'emp_check_01'){
					$("[name='emp_check_01']").hide();
					$("[name='emp_check_02']").show();
					$('#AUTH_CLS_CODE').val('02');					
				}else{
					$("[name='emp_check_01']").show();
					$("[name='emp_check_02']").hide();
					$('#AUTH_CLS_CODE').val('01');
				}				
			});
			
		//////학력사항 row 삭제
			function edu_deltr(delid){					
				$('#edu-tr > tr[id='+delid+']').remove();
			}
			
			$("[id='edu-del-bt']").bind('click',function(){
				edu_deltr($(this).attr('name'));
			});
			
		//////학력사항 row 추가				
			$("[id='edu-insert-bt']").on('click',function(){		
				var delid = 0;
				var num = 0;
				$('#edu-tr tr').each(function(i,t){
					++num;				
					if( $(this).attr('id')*1 > delid ) delid = $(this).attr('id')*1
				});
				++delid;

				if(num == 1) delid=1;
			
				$("<tr id='"+delid+"'>"
			    + "<td>"+delid+"</td>"
			    + "	<td><input type='text' class='edutext' id='schl_name' value='' name='schl_name_"+delid+"'>" 		
			    +"<input type='hidden' id='accr_no' value='"+delid+"'></td>"
			    + "	<td><input type='date' class='edutext'  value='' name='entr_date_"+delid+"'>"
		    	+ " <input type='date' class='edutext'  value='' name='grdn_date_"+delid+"'>"
		    	+ "</td>"  
			    + "	<td><input type='text' class='edutext'  value='' name='majr_name_"+delid+"'></td>"  
			    + "	<td>"
			    + "	 <select name='grdn_cls_code_"+delid+"' class='form-control info-sel'>" 
			    + "			<option value=''> 선택 </option>"	
				+ grdn_str
				+ "  </select>"		
				+ "	</td>"
				+ "	<td>"
				+ "	 <select name='degr_cls_code_"+delid+"' class='form-control info-sel'>" 
				+ "			<option value=''> 선택 </option>"	
				+ degr_str			
				+ "  </select>"	
				+ "	</td>"
			    + "	<td><input type='text' class='edutext'  value='' name='grad_val01_"+delid+"'>	~ <br>" 
			    + "	<input type='text' class='edutext'  value='' name='grad_val02_"+delid+"'>	"
			    + "</td>"  
			    + "	<td>" 	
			    + "		<button type='button' name="+delid+"' class='btn btn-sm btn-default' id='edu-del-bt'>"		 
				+ "			삭제" 		
				+ "		</button>" 	
			    + "	</td>" 
			    + "</tr>").insertAfter($('#edu-tr > tr:last'));
				
				$("[id='edu-del-bt']").bind('click',function(){	
					edu_deltr( $(this).attr('name'));
				});				
			});
			
		//////경력사항 row 추가		
			$("[id='work-del-bt']").on('click',function(){
				work_deltr($(this).attr('name'));
			});
			
			$("[id='work-insert-bt']").on('click',function(){
				
				var delid = 0;			
				var num = 0;
				$('#work-tr tr').each(function(i,t){
					++num;
					if( $(this).attr('id')*1 > delid ) delid = $(this).attr('id')*1
				});
				
				++delid;
				
				if(num == 1) delid=1;				

				$("<tr id='"+delid+"'>"
				+ "<td>"+delid+"</td>"
			    + "	<td><input type='text' class='worktext' id='offc_name'  value='' name='offc_name_"+delid+"'>	" 	
			    +"<input type='hidden' id='carr_no' value='"+delid+"'></td>"
			    + "	<td><input type='date' class='worktext'  value='' name='wrk_strt_date_"+delid+"'>~ "
				+ " 	<input type='date' class='worktext'  value='' name='wrk_end_date_"+delid+"'> "
				+ "</td>" 
				+ " <td>"			
				+ "	 <select name='wrk_cls_code_"+delid+"' class='form-control info-sel'>" 
				+ "			<option value=''> 선택 </option>"	
				+ wrk_str	
				+ "  </select>"	 					    
				+ " </td>"
			    + "	<td><input type='text' class='worktext'  value='' name='wrk_dpt_name_"+delid+"'></td>"  
			    + "	<td><input type='text' class='worktext'  value='' name='chrg_tsk_cntt_"+delid+"'></td>"  
			    + "	<td><input type='text' class='worktext'  value='' name='rsgn_resn_cntt_"+delid+"'></td>"  
			    + "	<td>" 	
			    + "		<button type='button' name='"+delid+"' class='btn btn-sm btn-default' id='work-del-bt'>"		 
				+ "			삭제" 		
				+ "		</button>" 	
			    + "	</td>" 
			    + "</tr>").insertAfter($('#work-tr > tr:last'));
				
				$("[id='work-del-bt']").bind('click',function(){	
					work_deltr( $(this).attr('name'));
				});				
			});
				
			function work_deltr(delid){
				$('#work-tr > tr[id='+delid+']').remove();
			}
			
		//////// radio에 값 뿌려주기

			//성별
			if( "${empBasicinfo.GNDR_CODE}" != null) {
				$('input[type="radio"][value="${empBasicinfo.GNDR_CODE}"]').attr("checked", true);
			}			
			//결혼
			if( "${empBasicinfo.MRRG_YN}" != null) {			
				$('input[type="radio"][id="MRRG_YN"][value="${empBasicinfo.MRRG_YN}"]').attr("checked", true);
			}		
			//병역사항
			if( "${empBasicinfo.MSVC_CLS_CODE}" != null) {
				$('input[type="radio"][id="MSVC_CLS_CODE"][value="${empBasicinfo.MSVC_CLS_CODE}"]').attr("checked", true); 
			}
	
		}); //document
		
		$.fn.serializeObject = function() {
		    var obj = null;
		    try {
		        if (this[0].tagName && this[0].tagName.toUpperCase() == "FORM") {
		            var arr = this.serializeArray();
		            if (arr) {
		                obj = {};
		                jQuery.each(arr, function() {
		                    obj[this.name] = this.value;
		                });
		            }
		        }
		    } catch (e) {
		        alert(e.message);
		    } finally {
		    }
		 
		    return obj;
		};

			function update_data(){
				var formdata =$("#infofrm").serializeObject();
				var edu_insert = "";
				var work_insert = "";
				
				$('#work-tr tr').each(function(index,t){
					if($('input[id="offc_name"]').eq(index).val() != null && $('input[id="offc_name"]').eq(index).val() != ""){						
						var b = $('input[id="carr_no"]').eq(index).val();
						if(work_insert == "") work_insert += b;
						else work_insert += "/"+b;
					}
				}); 
				$('#edu-tr tr').each(function(index,t){
					if($('input[id="schl_name"]').eq(index).val() != null && $('input[id="schl_name"]').eq(index).val() != ""){						
						var a = $('input[id="accr_no"]').eq(index).val();
						if(edu_insert == "") edu_insert += a;
						else edu_insert += "/"+a;
					}
				}); 
				
				console.log("%%%%%%%%%");
				console.log(edu_insert);
				console.log("%%%%%%%%%");
				console.log(work_insert);
 				
				$.ajax({
 					method : "POST",
 					data : {
 						 "data" : formdata,
 						 "edu_insert" :  edu_insert,
 						 "work_insert" : work_insert
 					},
 					url : "/updateEmpinfo",
 					dataType : "text", 
 					success : function(data){
						
 					},
					error : function(request,status,error){
						 
 					}
				}); //ajax
				
			} // update_data
		
			//주소 검색
			function address(){			
		        var url='/empinfo/address';
		        window.open(url,"","width=600,height=700,left=100,top=50");	        	
			}
			
			//부서검색
			function searchdpt(){		
				var url='/empinfo/dpt?dpt_name='+$('#dpt_name').val();
		        window.open(url,"","width=700,height=700,left=10,top=50");		
			}
			
			function check_only(obj, id){
				$('input[type="radio"][id="'+id+'"]').each(function(i,t){
					if($(t).attr('class') != $(obj).attr('class')) $(t).prop("checked", false);
				});
			}
			
			function insert_data(){
				if($('input[name="EMP_NAME"]').val() == ""){
					alert("이름 적으세엽");
				}else{
					var emp_no = $('input[name="EMP_NO"]').val();
					var emp_name = $('input[name="EMP_NAME"]').val();
					
					$.ajax({
						method : "POST",
						 data : {
							 "emp_no" : emp_no,
							 "emp_name" : emp_name						 
						 },
						 url : "/join" ,
						 dataType : "text" ,
						 success : function(data){
							 if(data == 1){
								 location.href="/empinfo?emp_no="+emp_no;
							 }else{
								 alert('신규 사원 등록에 실패하였습니다. \n 다시 시도해주세요');
							 }
						 },
						 error : function(request,status,error){
							alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);	
						}			
					});
				}
			} //insert_Data
	</script>
	
		<div class="col-xs-10 right">
			<form name="infofrm" method="post" id="infofrm">
			
				<input type="hidden" name="auth-cls-code" id="AUTH_CLS_CODE" value="${empBasicinfo.AUTH_CLS_CODE}">
				
				<div class="col-xs-12">
					&nbsp;
				</div>
				<div class="col-xs-12">
					<div class="col-xs-10">
						&nbsp;
					</div>
					<div class="col-xs-2">
						&nbsp;&nbsp;&nbsp;&nbsp;
					<c:if test="${first_check == 'new'}">
						<button type="button" class="btn btn-md" id="new_bt" onclick="insert_data()">
							등록
						</button>
						<button type="button" class="btn btn-md" id="new_cancel_bt">
							취소
						</button>
					</c:if>
					<c:if test="${first_check != 'new'}">
						<button type="button" class="btn btn-md" onclick="update_data()">
							저장
						</button>
						<button type="reset" class="btn btn-md" id="new_cancel_bt">
							취소
						</button>
					</c:if>
											
					</div>
				</div>

				<div class="container empinfo">
				 
					<h1>사원 상세 정보</h1>
					
<!-- 					<div class="col-xs-10 col-xs-offset-1"> -->
					<div class="col-xs-12">
<%--
********************************
			사 원 정 보
********************************
--%>						
						<div class="col-xs-2 col-xs-offset-1">
							<img src="/resource/user.png" class="img-thumbnail emp-photo" alt="Cinque Terre">
						</div>
						<div class="col-xs-1">
							&nbsp;
						</div>
						<div class="col-xs-8 emp_no">
							<div class="input-group">
					    		<span class="input-group-addon">사원번호</span>
					    		<input id="name-ko" type="text" class="form-control" name="emp_no" value="${empBasicinfo['EMP_NO']}" readonly>		    		
					  		</div>
					  		
					  		
	  		<button type="button" class="btn btn-primary" id="emp_check" name="emp_check_01">
		    	<span class="glyphicon glyphicon-check"></span>&nbsp;관리자
		    </button>
		    <button type="button" class="btn btn-default" id="emp_check" name="emp_check_02">
		    	<span class="glyphicon glyphicon-unchecked"></span>&nbsp;사용자
		    </button>
						    
						    
						</div>
						<div class="col-xs-1">
							&nbsp;
						</div>
						<div class="col-xs-4 emp_name">
							<div class="input-group">
						    	<span class="input-group-addon">성명</span>
						    	<input id="name-ko" type="text" class="form-control" value="${empBasicinfo['EMP_NAME']}" name="emp_name" placeholder="-">
						  	</div>
					  	</div>
					  	<div class="col-xs-4 emp_stts_name">
							<div class="input-group">
						    	<span class="input-group-addon">상태</span>
						    		
						    	<select class="form-control" name="emp_stts_code" id="EMP_STTS_CODE"> 
						    			<option class="" value="">선택</option>
									<c:forEach var="emp_stts" items="${groupCode.EMP_STTS_CODE}">
										<option value="${emp_stts.CODE_ID}" value="${emp_stts.CODE_ID}" class="${emp_stts.CODE_ID}"
										<c:if test="${emp_stts.CODE_ID eq empBasicinfo.EMP_STTS_CODE}"> selected</c:if>>
											${emp_stts.CODE_NAME} / ${emp_stts.CODE_ID}
										</option>
									</c:forEach>
								</select>	
						    	
						  	</div>
					  	</div>
					  	<div class="col-xs-1">
							&nbsp;
						</div>
					  	<div class="col-xs-4 emp_start_date">
							<div class="input-group">
						    	<span class="input-group-addon">입사일자</span>
						    	<input id="name-ko" type="date" class="form-control" value="${empBasicinfo['JOIN_DATE']}" name="join_date"  placeholder="-">
						  	</div>
					  	</div>
					  	<div class="col-xs-4 emp_end_date">
							<div class="input-group">
						    	<span class="input-group-addon">퇴사일자</span>
						    	<input id="name-ko" type="date" class="form-control" value="${empBasicinfo['RSGN_DATE']}" name="rsgn_date"  placeholder="-">
						  	</div>
					  	</div>
					  	<div class="col-xs-12">
							&nbsp;
					  	</div>
					  	
					  	<div class="col-xs-4">
							<button type="button" class="btn btn-default" id="imgupload-bt">
						    	이미지업로드
						    </button>
					  	</div>
					  	
					  	<div class="col-xs-4 emp_dpt_">
							<div class="input-group">
						    	<span class="input-group-addon">직위</span>
						    	
						    	<select class="form-control" name="dpt_role_cls_code" id="DPT_ROLE_CLS_CODE"> 
						    		<option class=""  value="">선택</option>
									<c:forEach var="dpt_role" items="${groupCode.DPT_ROLE_CLS_CODE}">
										<option value="${dpt_role.CODE_ID}" class='${dpt_role.CODE_ID}'
										<c:if test="${dpt_role.CODE_ID eq empBasicinfo.DPT_ROLE_CLS_CODE}"> selected</c:if>>
										${dpt_role.CODE_NAME} / ${dpt_role.CODE_ID}
										</option>
									</c:forEach>
								</select>	
						  	</div>
					  	</div>
					  	
					  	<div class="col-xs-4">
							<div class="input-group emp_">
						    	<span class="input-group-addon">직급</span>
						    	<select class="form-control" name="rnk_code" id="RNK_CODE"> 
						    		<option id="default" class=""  value="">선택</option>
						    		<c:forEach var="rnk" items="${groupCode.RNK_CODE}">
						    			<option value="${rnk.CODE_ID}" class="${rnk.CODE_ID}"
						    			<c:if test="${rnk.CODE_ID eq empBasicinfo.RNK_CODE}"> selected</c:if>>
						    				${rnk.CODE_ID} / ${rnk.CODE_NAME}
						    			</option>	
						    		</c:forEach>
								</select>
						  	</div>
					  	</div>
					  	
					  	
					  	<div class="col-xs-4 emp_dpt_name">
							<div class="input-group">
						    	<span class="input-group-addon">부서</span>
						    	<input type="text" id="dpt_name" class="form-control" 
						    		value="${empBasicinfo['DPT_NAME']}" name="dpt_name" readonly  placeholder="-">
						    	<input type="hidden" id="dpt_code" name="dpt_code" value="">
						    	<input type="hidden" id="dpt_strt_date" name="dpt_strt_date" value="">
						    	<button type="button" class="btn btn-default" id="dtpsearchbt" onclick="searchdpt()">
							    	<span class="glyphicon glyphicon-search"></span>
							    </button>
						  	</div>
					  	</div>
					  	
					  	<div class="col-xs-4 emp_email">
							<div class="input-group">
						    	<span class="input-group-addon">Email</span>
						    	<input id="name-ko" type="text" class="form-control" value="${empBasicinfo['COMP_EMAIL']}" name="comp_email"  placeholder="-">
						  	</div>
					  	</div>
					  	
					  	<div class="col-xs-4 emp_tel">
							<div class="input-group">
						    	<span class="input-group-addon">연락처</span>
						    	<input id="name-ko" type="text" class="form-control" value="${empBasicinfo['CNTCT_NO']}" name="cntct_no"  placeholder="-">
						  	</div>
					  	</div>
					  	
<%--
***************************************************************
			인 적 사 항 table
***************************************************************
--%>				  	

						<br><br><br>
					  	<div class="col-xs-12 info-table">
						  	<div class="title">
						  		인적사항
						  	</div>
					  	
						  	<table class="table table-bordered" id="basic-info">
							    <tbody>			
							    	<tr>
								       <th rowspan="2">성명</th>
								       <td class="name">영문</td>
								       <td>
								       		<input type="text" class="basictext" value="${empBasicinfo['EMP_ENG_NAME']}" placeholder="-" name="emp_eng_name" >
								       </td>							       
								       <th>주민등록번호</th>
								       
								       <c:set var="ref_no" value="${empBasicinfo['RSDN_REG_CODE']}"/>
								       
								       <td colspan="3">
								       		<input type="text" class="basictext" value="${fn:substring(TextValue,0,5) }" name="rsdn_reg_no_1" placeholder="" >
								       		&nbsp;&nbsp; - &nbsp;&nbsp;
								       		<input type="passwd" class="basictext" value="${fn:substring(TextValue,6,12) }" name="rsdn_reg_no_2" placeholder="" >								       		 
								       </td>
								     </tr>
								     <tr>
								       <td class="name">한문</td>
								       <td>
								       		<input type="text" class="basictext" value="${empBasicinfo['EMP_CHN_NAME']}" name="emp_chn_name"  placeholder="-">
								       </td>
								       <th>생년월일</th>
								       <td>
								       		<input type="date" class="basictext" value="${empBasicinfo['BRTH_DATE']}" name="brth_date"  placeholder="-">
								       </td>
								       <th>성별</th>
								       <td>
								       		<c:forEach var="gndr" items="${groupCode.GNDR_CODE}">
								    			<div class="form-check info-radio">
													<label>
														<input type="radio" id="GNDR_CODE" class="${gndr.CODE_ID}" value="${gndr.CODE_ID}" name="gndr_code" onclick="check_only(this, 'GNDR_CODE')"> 
														<span class="label-text">${gndr.CODE_NAME}</span>
													</label>
												</div>	
								    		</c:forEach>
								       </td>							       
								     </tr>
								     <tr>
								       <th rowspan="2">주소</th>
								       <td class="name">우편번호</td>
								       <td>
								       		<input type="text" class="basictext" value="${empBasicinfo['ZIP_CODE']}" name="zip_code" id="ZIP_CODE" placeholer="-">
								       		<button type="button" class="btn btn-default" id="address-bt" onclick="address()">
										    	<span class="glyphicon glyphicon-search"></span>
										    </button>
								       </td>
								       <td>기본주소</td>
								       <td colspan="4">
								       		<input type="text" class="basictext" value="${empBasicinfo['HOME_ADDR']}" id="HOME_ADDR" name="home_addr" placeholer="-">
								       </td>
								     </tr>	
								     <tr>
								     	<td>상세주소</td>
								     	<td colspan="5">								       		
								       		<input type="text" class="basictext" value="${empBasicinfo['HOME_DTL_NO']}" name="home_dtl_no" placeholder="-"> 						        			  
								       </td>
								     </tr>
								     <tr>
								       <th>Email</th>
								       <td colspan="2">
								       		<input type="text" class="basictext" value="${empBasicinfo['PSNL_EMAIL']}" name="psnl_email"  placeholder="-">
								       </td>
								       <th>비상연락처</th>
								       <td colspan="3">
								       		<input type="text" class="basictext" value="${empBasicinfo['EMRG_CNTCT_NO']}" name="emrg_cntct_no"  placeholder="-">
								       </td>
								     </tr>	
								     <tr>								       
								       <th rowspan="2">결혼</th>
								       <td colspan="2">
								       		<div class="mrrg-radio-div">
									       		<div class="form-check info-radio">
													<label>
														<input id="MRRG_YN" type="radio" value="N" class="N" name="mrrg_yn" onclick="check_only(this, 'MRRG_YN')">  <span class="label-text">미혼</span>
													</label>
												</div>	
												<div class="form-check info-radio">
													<label>
														<input id="MRRG_YN" type="radio"  value="Y" class="Y" name="mrrg_yn" onclick="check_only(this, 'MRRG_YN')"> <span class="label-text">기혼</span>
													</label>
												</div>	
								       		</div>								       		
								       </td>
								       
								       <th rowspan="2">병역사항</th>
								       <td colspan="3">
									       <div class="radio-div">
										       	<c:forEach var="msvc" items="${groupCode.MSVC_CLS_CODE}">
									    			<div class="form-check info-radio">
														<label>
															<input type="radio" id="MSVC_CLS_CODE" name="msvc_cls_code" value="${msvc.CODE_ID}" class="${msvc.CODE_ID}"  onclick="check_only(this, 'MSVC_CLS_CODE')"> 
															
															<span class="label-text">${msvc.CODE_NAME}</span>
														</label>
													</div>	
									    		</c:forEach>	
											</div>							       		
								       </td>
								     </tr>
								     <tr>
								     	<td colspan="2">
								     		<input type="date" class="basictext" value="${empBasicinfo['MRRG_DATE']}" name="mrrg_date" >							     		
								     	</td>
								     	<td colspan="3">
								     		<input type="date" class="basictext" value="${empBasicinfo['MSVC_STRT_DATE']}" name="msvc_strt_date" >
								     		~
								     		<input type="date" class="basictext" value="${empBasicinfo['MSVC_END_DATE']}" name="msvc_end_date" >
								     	</td>
								     </tr>	      
							    </tbody>				    
						    </table>
					  	</div>
					  	
	<%--
	********************************
				학 력 정 보 table
	********************************
	--%>		
			   	
					  	<div class="col-xs-12 info-table">
						  	<div class="title">
						  		학력사항
						  	</div>
					  	
						  	<table class="table table-bordered">
							    <tbody id="edu-tr">			
							    	 <tr>
							    	   <th>아이디</th>
								       <th>학교명</th>
								       <th>재학기간</th>
								       <th>전공</th>
								       <th>졸업구분</th>
								       <th>학위구분</th>
								       <th>학점</th>
								       <th>
										<button type='button' class='btn btn-sm btn-default' id='edu-insert-bt'>
											추가
										</button>
								       </th>
								     </tr>
								     
								     <c:set var="num" value="1"/>
								     <c:set var="max" value="0"/>
								     <c:forEach var="edu" items="${empEducationinfo}">		
								     	<c:set var="num" value="${num+1}"/>		
								     	<c:if test="${max <= edu.EMP_ACCR_NO}">
								     		<c:set var="max" value="${edu.EMP_ACCR_NO+1}"/>
								     	</c:if>			     
										<tr id='${edu.EMP_ACCR_NO}'>
										<td>${edu.EMP_ACCR_NO}</td>
										    <td>
												<input type='text' class='edutext' id="schl_name" value='${edu.SCHL_NAME}' name='schl_name_${edu.EMP_ACCR_NO}'>
												<input type="hidden" name='emp_accr_no_${edu.EMP_ACCR_NO}' id="accr_no" value="${edu.EMP_ACCR_NO}">					    
										    </td>
										    <td>
										    	<input type='date' class='edutext'  value='${edu.ENTR_DATE}' name='entr_date_${edu.EMP_ACCR_NO}'>	~ <br>
										    	<input type='date' class='edutext'  value='${edu.GRDN_DATE}' name='grdn_date_${edu.EMP_ACCR_NO}'>
										    </td>	
										    <td>
												<input type='text' class='edutext'  value='${edu.MAJR_NAME}' name='majr_name_${edu.EMP_ACCR_NO}'>					    
										    </td>
										    <td>
										    	<select id="GRDN_CLS_CODE" name="grdn_cls_code_${edu.EMP_ACCR_NO}" class="form-control info-sel">										 
													<option class="" value="">선택</option> 
										    		<c:forEach var="grdn" items="${groupCode.GRDN_CLS_CODE}">
										    			<option value="${edu.GRDN_CLS_CODE}" <c:if test="${edu.GRDN_CLS_CODE eq grdn.CODE_ID}"> selected</c:if> class='${grdn.CODE_ID}'>									    			
										    				${grdn.CODE_NAME} 
										    			</option>	
										    		</c:forEach>
												</select>			    
										    </td>
										    <td>
											    <select id="DEGR_CLS_CODE" name="degr_cls_code_${edu.EMP_ACCR_NO}" class="form-control info-sel">
										    		<option class="" value="">선택</option> 
										    		<c:forEach var="degr" items="${groupCode.DEGR_CLS_CODE}">
										    			<option value="${edu.DEGR_CLS_CODE}" <c:if test="${edu.DEGR_CLS_CODE eq degr.CODE_ID}"> selected</c:if> class='${degr.CODE_ID}'>
										    				${degr.CODE_NAME}
										    			</option>	
										    		</c:forEach>
												</select>				    
										    </td>
										    <td>	
												<input type='text' class='edutext'  value='${edu.GRAD_VAL01}' name='grad_val01_${edu.EMP_ACCR_NO}'>	
													&nbsp;&nbsp; / &nbsp;&nbsp;
												<input type='text' class='edutext'  value='${edu.GRAD_VAL02}' name='grad_val02_${edu.EMP_ACCR_NO}'>				    
										    </td>		
										    <td>
										   		<button type='button' name='${edu.EMP_ACCR_NO}' class='btn btn-sm btn-default' id='edu-del-bt'> 
													삭제
												</button>
										    </td>
									    </tr>
								     </c:forEach>
								     
								     <c:if test="${num < 4}">
								     	<c:forEach begin="${num}" end="${4}">
									     	<tr id='${max}'>
									     	<td>${max}</td>
											   <td>
												<input type='text' class='edutext' id="schl_name"  value='' name='schl_name_${max}'>
												<input type="hidden" name='emp_accr_no_${max}' id="accr_no" value="${max}">					    
										    </td>
										    <td>
										    	<input type='date' class='edutext'  value='' name='entr_date_${max}'>	~ <br>
										    	<input type='date' class='edutext'  value='' name='grdn_date_${max}'>
										    </td>	
										    <td>
												<input type='text' class='edutext'  value='' name='majr_name_${max}'>					    
										    </td>
										    <td>
										    	<select id="GRDN_CLS_CODE" name="grdn_cls_code_${max}" class="form-control info-sel">										 
													<option class="" value="">선택</option> 
										    		<c:forEach var="grdn" items="${groupCode.GRDN_CLS_CODE}">
										    			<option value="${grdn.CODE_ID}" class='${grdn.CODE_ID}'>								    			
										    				${grdn.CODE_NAME} 
										    			</option>	
										    		</c:forEach>
												</select>			    
										    </td>
										    <td>
											    <select id="DEGR_CLS_CODE" name="degr_cls_code_${max}" class="form-control info-sel">
										    		<option class="" value="">선택</option> 
										    		<c:forEach var="degr" items="${groupCode.DEGR_CLS_CODE}">
										    			<option value="${degr.CODE_ID}" class='${degr.CODE_ID}'>
										    				${degr.CODE_NAME}
										    			</option>	
										    		</c:forEach>
												</select>				    
										    </td>
										    <td>	
												<input type='text' class='edutext'  value='' name='grad_val01_${max}'>	
													&nbsp;&nbsp; / &nbsp;&nbsp;
												<input type='text' class='edutext'  value='' name='grad_val02_${max}'>				    
										    </td>		
											    <td>
											   		<button type='button' name='${max}' class='btn btn-sm btn-default' id='edu-del-bt'> 
														삭제
													</button>
											    </td>
										    </tr>
										    <c:set var="max" value="${max+1}"/>	
								     	</c:forEach>
								     </c:if>
							    </tbody>				    
						    </table>
					  	</div>
		
	<%--
	********************************
				경 력 정 보 table
	********************************
	--%>		
					  	
					  	<div class="col-xs-12 info-table">
						  	<div class="title">
						  		경력사항
						  	</div>
					  	
						  	<table class="table table-bordered">
							    <tbody id="work-tr">			
							    	 <tr>
							    	   <th>아이디</th>
								       <th>직장명</th>
								       <th>근무기간</th>
								       <th>근무유형</th>
								       <th>근무부서</th>
								       <th>담당업무</th>
								       <th>퇴직사유</th>
								        <th>
										<button type='button' class='btn btn-sm btn-default' id='work-insert-bt'>
											추가
										</button>
								       </th>
								     </tr>
								     
								     <c:set var="work_num" value="1"/>
								     <c:set var="work_max" value="0"/>
								     <c:forEach var="work" items="${empCareerinfo}">
								     	<c:set var="work_num" value="${work_num +1}" />
								     	<tr id='${work.EMP_CARR_NO}'>	
								     	<c:if test="${work_max <= work.EMP_CARR_NO}">
								     		<c:set var="work_max" value="${work.EMP_CARR_NO+1}"/>
								     	</c:if>		
								     	<td>
								     		${work.EMP_CARR_NO}
								     	</td>
								     					     	
									     	<td>
												<input type='text' class='worktext' id="offc_name" value='${work.OFFC_NAME}' name='offc_name_${work.EMP_CARR_NO}'>	
												<input type="hidden" name="emp_carr_no_${work.EMP_CARR_NO}" id="carr_no" value="${work.EMP_CARR_NO}">		    
										    </td>
										    <td>
												<input type='date' class='worktext'  value='${work.WRK_STRT_DATE}' name='wrk_strt_date_${work.EMP_CARR_NO}'>
												~
												<input type='date' class='worktext'  value='${work.WRK_END_DATE}' name='wrk_end_date_${work.EMP_CARR_NO}'>				    
										    </td>
										    <td>
												<select name="wrk_cls_code_${work.EMP_CARR_NO}" class="form-control info-sel"> 
													<option class="" value="">선택</option>
										    		<c:forEach var="wrk" items="${groupCode.WRK_CLS_CODE}">
										    			<option value="${wrk.CODE_ID}"<c:if test="${work.WRK_CLS_CODE eq wrk.CODE_ID}"> selected</c:if> class='${wrk.CODE_ID}'>
										    				${wrk.CODE_NAME} / ${work.WRK_CLS_CODE} / ${wrk.CODE_ID}
										    			</option>	
										    		</c:forEach>
												</select>					    
										    </td>
										    <td>
												<input type='text' class='worktext'  value='${work.WRK_DPT_NAME}' name='wrk_dpt_name_${work.EMP_CARR_NO}'>					    
										    </td>
										    <td>
												<input type='text' class='worktext'  value='${work.CHRG_TSK_CNTT}' name='chrg_tsk_cntt_${work.EMP_CARR_NO}'>					    
										    </td>
										    <td>
												<input type='text' class='worktext'  value='${work.RSGN_RESN_CNTT}' name='rsgn_resn_cntt_${work.EMP_CARR_NO}'>					    
										    </td>
										    <td>
											    <button type='button' name='${work.EMP_CARR_NO}' class='btn btn-sm btn-default' id='work-del-bt'>
													삭제
												</button>
										    </td>
					   					</tr>
								     </c:forEach>
								     
								     <c:if test="${work_num < 4}">
								     	<c:forEach begin="${work_num}" end="4">
								     		<tr id='${work_max}'>
								     		<td>${work_max}</td>					     	
										    <td>
												<input type='text' class='worktext' id="offc_name"  value='${work.OFFC_NAME}' name='offc_name_${work_max}'>	
												<input type="hidden" name="emp_carr_no_${work_max}" id="carr_no"  value="${work_max}">		    
										    </td>
										    <td>
												<input type='date' class='worktext'  value='' name='wrk_strt_date_${work_max}'>
												~
												<input type='date' class='worktext'  value='' name='wrk_end_date_${work_max}'>				    
										    </td>
										    <td>
												<select name="wrk_cls_code_${work_max}" class="form-control info-sel"> 
													<option class="" value="">선택</option>
										    		<c:forEach var="wrk" items="${groupCode.WRK_CLS_CODE}">
										    			<option class='${wrk.CODE_ID}'>
										    				${wrk.CODE_NAME} / ${work.WRK_CLS_CODE} / ${wrk.CODE_ID}
										    			</option>	
										    		</c:forEach>
												</select>					    
										    </td>
										    <td>
												<input type='text' class='worktext'  value='' name='wrk_dpt_name_${work_max}'>					    
										    </td>
										    <td>
												<input type='text' class='worktext'  value='' name='chrg_tsk_cntt_${work_max}'>					    
										    </td>
										    <td>
												<input type='text' class='worktext'  value='' name='rsgn_resn_cntt_${work_max}'>					    
										    </td>
											    <td>
												    <button type='button' name='${work_max}' class='btn btn-sm btn-default' id='work-del-bt'>
														삭제
													</button>
											    </td>
						   					</tr>
						   					<c:set var="work_max" value="${work_max +1}" />
								     	</c:forEach>
								     </c:if>
							    </tbody>				    
						    </table>
					  	</div>
					  	
	<%--
	********************************
				기 타 table
	********************************
	--%>						  	
					  	<div class="col-xs-12 info-table">
						  	<div class="title">
						  		자격증
						  	</div>
					  	
						  	<table class="table table-bordered">
							    <tbody>			
							    	 <tr>
								       <th>자격명</th>
								       <th>취득일자</th>
								       <th>발급일자</th>
								       <th>자격정</th>
								       <th>취득일자</th>
								       <th>발급일자</th>
								     </tr>
								     <c:forEach begin="0" end="3">
								     	 <tr>
									       <td>&nbsp;</td>
									       <td></td>
									       <td></td>
									       <td></td>
									       <td></td>
									       <td></td>
									     </tr>	
								     </c:forEach>  
							    </tbody>				    
						    </table>
					  	</div>
					  	
					  	<div class="col-xs-12 info-table">
						  	<div class="title">
						  		가족사항
						  	</div>
					  	
						  	<table class="table table-bordered">
							    <tbody>			
							    	 <tr>
								       <th>성명</th>
								       <th>관계</th>
								       <th>연령</th>
								       <th>학력</th>
								       <th>직업(상세기재요망)</th>
								     </tr>
								     <c:forEach begin="0" end="3">
								     	 <tr>
									       <td>&nbsp;</td>
									       <td></td>
									       <td></td>
									       <td></td>
									       <td></td>
									     </tr>	
								     </c:forEach>    
							    </tbody>				    
						    </table>
					  	</div>
					  	
					  	<div class="col-xs-12 info-table">
						  	<div class="title">
						  		수상내역
						  	</div>
					  	
						  	<table class="table table-bordered">
							    <tbody>			
							    	 <tr>
								       <th>수상연도</th>
								       <th>수상명</th>
								       <th>수여기관</th>
								       <th>수여내용</th>
								     </tr>
								     <c:forEach begin="0" end="3">
								     	 <tr>
									       <td>&nbsp;</td>
									       <td></td>
									       <td></td>
									       <td></td>
									     </tr>	
								     </c:forEach>     
							    </tbody>				    
						    </table>
					  	</div>
					  	
					  	<div class="col-xs-12 info-table">
						  	<div class="title">
						  		특기사항
						  	</div>
					  	
						  	<table class="table table-bordered">
							    <tbody>			
							    	 <tr>
								       <th>구분</th>
								       <th>관계</th>
								       <th>등급</th>
								       <th>내용</th>
								     </tr>
								     <c:forEach begin="0" end="3">
								     	 <tr>
									       <td>&nbsp;</td>
									       <td></td>
									       <td></td>
									       <td></td>
									     </tr>	
								     </c:forEach>  
							    </tbody>				    
						    </table>
					  	</div>
					  	<!-- table 끝 -->		
					  			    
					</div>
					<!-- .col-xs-10 col-xs-offset-2 -->			  	
				</div>  
				<!-- .container -->
			</form>
			<br><br><br>
			
		</div>
		<!-- .col-xs-10 right-->			
	</div>
	<!-- .index -->

</html>



