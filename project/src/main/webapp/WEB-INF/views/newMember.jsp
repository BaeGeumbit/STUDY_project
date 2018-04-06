<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="ko">
	<%@include file="header.jsp" %>
	
<!-- 	<script src="/empinfo.js"></script> -->
	
	<script type="text/javascript">	
	var work_delarr = "";
	var edu_delarr = "";
	var edu_insert = "";
	var work_insert = "";
	$(document).ready(function(){
		
		alert("${new_emp_no}");
		if("${new_emp_no}" != "" || "${new_emp_no}" != null){
			$("input[name='EMP_NO']").val("${new_emp_no}");
			//${emp_no} = "${new_emp_no}";
		}
		

	//////학력사항
		//$("${edustr}").appendTo($('#edu-tr'));

		$("[id='edu-del-bt']").bind('click',function(){
			edu_deltr( $(this).attr('name'));
		});
					
		$("[id='edu-insert-bt']").on('click',function(){
			
			var delid = $('#edu-tr > tr:last').attr('id')*1+1;
			
			var num = 0;
			$('#edu-tr tr').each(function(i,t){
				++num;
			});
			
			if(num == 1) delid=1;

			$("<tr id='"+delid+"'>"
		    + "	<td><input type='text' class='edutext'  value='' name='SCHL_NAME'></td>" 				    
		    + "	<td><input type='date' class='edutext'  value='' name='ENTR_DATE'>"
	    	+ " <input type='date' class='edutext'  value='' name='GRDN_DATE'>"
	    	+ "</td>"  
		    + "	<td><input type='text' class='edutext'  value='' name='MAJR_NAME'></td>"  
		    + "	<td>"
		    + "	 <select name='WRK_CLS_CODE' class='form-control info-sel'>" 
		    + "			<option> 선택 </option>"	
			+ "		<c:forEach var='wrk' items='${groupCode.WRK_CLS_CODE}'>"
			+ "			<option> ${wrk.CODE_NAME} </option>"	
			+ "	    </c:forEach>"		
			+ "  </select>"		
			+ "	</td>"
			+ "	<td>"
			+ "	 <select name='WRK_CLS_CODE' class='form-control info-sel'>" 
			+ "			<option> 선택 </option>"	
			+ "		<c:forEach var='wrk' items='${groupCode.WRK_CLS_CODE}'>"
			+ "			<option> ${wrk.CODE_NAME} </option>"	
			+ "	    </c:forEach>"		
			+ "  </select>"	
			+ "	</td>"
		    + "	<td><input type='text' class='edutext'  value='' name='GRAD_VAL01'>	</td>"  
		    + "	<td>" 	
		    + "		<button type='button' name='"+delid+"' class='btn btn-sm btn-default' id='edu-del-bt'>"		 
			+ "			삭제" 		
			+ "		</button>" 	
		    + "	</td>" 
		    + "</tr>").insertAfter($('#edu-tr > tr:last'));
			
			$("[id='edu-del-bt']").bind('click',function(){	
				edu_deltr( $(this).attr('name'));
			});				
		});
		
		
		
		function edu_deltr(delid){
			
			if(edu_delarr == "") edu_delarr += delid;
			else edu_delarr += "/"+delid; 
			
			$('#edu-tr > tr[id='+delid+']').remove();
		}
		
	//////경력사항		
		//$("${workstr}").appendTo($('#work-tr'));
		
		$("[id='work-del-bt']").on('click',function(){
			work_deltr($(this).attr('name'));
		});
		
		$("[id='work-insert-bt']").on('click',function(){
			
			var delid = $('#work-tr > tr:last').attr('id')*1+1;
			
			var num = 0;
			$('#work-tr tr').each(function(i,t){
				++num;
			});
			
			if(num == 1) delid=1;				

			$("<tr id='"+delid+"'>"
		    + "	<td><input type='text' class='worktext'  value='' name='OFFC_NAME'>	</td>" 				    
		    + "	<td><input type='date' class='worktext'  value='' name='WRK_STRT_DATE'>~ "
			+ " 	<input type='date' class='worktext'  value='' name='WRK_END_DATE'> "
			+ "</td>" 
			+ " <td>"			
			+ "	 <select name='WRK_CLS_CODE' class='form-control info-sel'>" 
			+ "			<option> 선택 </option>"	
			+ "		<c:forEach var='wrk' items='${groupCode.WRK_CLS_CODE}'>"
			+ "			<option> ${wrk.CODE_NAME} </option>"	
			+ "	    </c:forEach>"		
			+ "  </select>"	 					    
			+ " </td>"
		    + "	<td><input type='text' class='worktext'  value='' name='WRK_DPT_NAME'></td>"  
		    + "	<td><input type='text' class='worktext'  value='' name='CHRG_TSK_CNTT'></td>"  
		    + "	<td><input type='text' class='worktext'  value='' name='RSGN_RESN_CNTT'></td>"  
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
			
			if(work_delarr == "") work_delarr += delid;
			else work_delarr += "/"+delid;
			
			$('#work-tr > tr[id='+delid+']').remove();
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
		

	//////// select / radio에 값 뿌려주기

		//상태
		if( "${empBasicinfo.EMP_STTS_CODE}" == null || "${empBasicinfo.EMP_STTS_CODE}" == "") {
			$("option[id='default']").attr("selected","selected");
		}else {
			$("option[id='${empBasicinfo.EMP_STTS_CODE}']").attr("selected","selected");
		}
		
		//직위
		if( "${empBasicinfo.DPT_ROLE_CLS_CODE}" == null || "${empBasicinfo.DPT_ROLE_CLS_CODE}" == "") {
			$("select[name='DPT_ROLE_CLS_CODE']").val("선택");
		} else {
			$("option[id='${empBasicinfo.DPT_ROLE_CLS_CODE}']").attr("selected","selected");
		}
		
		//직급
		if( "${empBasicinfo.RNK_CODE}" == null || "${empBasicinfo.RNK_CODE}" == "") {
			$("option[id='default']").attr("selected","selected");
		} else {
			$("option[id='${empBasicinfo.RNK_CODE}']").attr("selected","selected");
		}
		//성별
		if( "${empBasicinfo.GNDR_CODE}" != null) {
			$('input[type="radio"][value="${empBasicinfo.GNDR_CODE}"]').attr("checked", true);
		}
		
		//결혼
		if( "${empBasicinfo.MRRG_YN}" != null) {			
			//alert("helelel");
			//$('input[type="radio"][id="MRRG_YN"][value=Y]').attr("checked", true);
			$('input[type="radio"][id="MRRG_YN"][value="${empBasicinfo.MRRG_YN}"]').attr("checked", true);
		}
		
		//병역사항
		if( "${empBasicinfo.MSVC_CLS_CODE}" != null) {
			$('input[type="radio"][id="MSVC_CLS_CODE"][value="${empBasicinfo.MSVC_CLS_CODE}"]').attr("checked", true); 
		}
		
	}); // document
	
	


	function update_data(){
		
	////////////기본정보 바꾸기
// d[a] = {
//     greetings: b,
//     data: c
// };   
	    var empNo = $("[name='EMP_NO']").val();
		var basicInfo = {};
		
		 basicInfo["emp_no"] = $("[name='EMP_NO']").val();
		 basicInfo["auth_cls_code"] = $("[name='AUTH_CLS_CODE']").val();
		
		 basicInfo["emp_stts_code"] = $("#EMP_STTS_CODE option:selected").attr("class");		//select
		 basicInfo["emp_name"] = $("[name='EMP_NAME']").val();
		 basicInfo["join_date"] = $("[name='JOIN_DATE']").val();
		 var rsgn_date = "";
		 if($("[name='RSGN_DATE']").val() != '9999-12-31') rsgn_date = $("[name='RSGN_DATE']").val();
		 basicInfo["rsgn_date"] = rsgn_date;
		 basicInfo["rnk_code"] = $("#RNK_CODE option:selected").attr("class");		//select
		 basicInfo["comp_email"] = $("[name='COMP_EMAIL']").val();
		 basicInfo["cntct_no"] = $("[name='CNTCT_NO']").val();
		 basicInfo["dpt_role_cls_code"] = $("#DPT_ROLE_CLS_CODE option:selected").attr("class");		//select
		// $('select[name="WRK_CLS_CODE"] option:selected').eq(index).attr("class");
		 //$("#셀렉트박스ID option:selected").val();
		 //$("input[type=radio][name=rdoName]:checked").val();

		 basicInfo["emp_eng_name"] = $("[name='EMP_ENG_NAME']").val();
		 basicInfo["emp_chn_name"] = $("[name='EMP_CHN_NAME']").val();
		 basicInfo["brth_date"] = $("[name='BRTH_DATE']").val();
		 
		 var gndr_radio = $("input[type='radio'][id='GNDR_CODE']:checked").attr('class');
		 if(gndr_radio == undefined) gndr_radio = "";
		 
		 basicInfo["gndr_code"] = gndr_radio;		//radio
		 
		 basicInfo["rsdn_reg_no"] = $("[name='RSDN_REG_NO_1']").val()+$("[name='RSDN_REG_NO_2']").val();
		 basicInfo["zip_code"] = $("[name='ZIP_CODE']").val();
		 basicInfo["home_addr"] = $("[name='HOME_ADDR']").val();
		 basicInfo["home_dtl_no"] = $("[name='HOME_DTL_NO']").val();
		 basicInfo["psnl_email"] = $("[name='PSNL_EMAIL']").val();
		 basicInfo["emrg_cntct_no"] = $("[name='EMRG_CNTCT_NO']").val();
		 
		 //alert($("input[type='radio'][id='MSVC_CLS_CODE']:checked").attr('class'));
		 var msvs_radio = $("input[type='radio'][id='MSVC_CLS_CODE']:checked").attr('class');
		 if(msvs_radio == undefined) msvs_radio = "";
		 
		 basicInfo["msvc_cls_code"] = msvs_radio;		//radio
		 basicInfo["msvc_strt_date"] = $("[name='MSVC_STRT_DATE']").val();
		 basicInfo["msvc_end_date"] = $("[name='MSVC_END_DATE']").val();
		 
		 var mrrg_radio = $("input[type='radio'][id='MRRG_YN']:checked").attr('class');
		 if(mrrg_radio == undefined) mrrg_radio = "";
		 
		 basicInfo["mrrg_yn"] = mrrg_radio;		//radio
		 basicInfo["mrrg_date"] = $("[name='MRRG_DATE']").val();
		 //basicInfo["MRRG_DATE"] = $("[name='MRRG_DATE']").val();
		
		// basicInfo["DPT_NAME"] = $("[name='DPT_NAME']").val();
		
		console.log("###work_delarr####");
		console.log(work_delarr);
		console.log("#######");
		
		console.log("###edu_delarr####");
		console.log(edu_delarr);
		console.log("#######");
		
		console.log("###basicInfo####");
		console.log(basicInfo);
		console.log("#######");

 		dptinfo = $("[name='DPT_NAME']").val();
// 		var dptstr = $("[name='DPT_NAME']").val().split(',');
// 		for(var i=0; i<dptstr.length; i++){
// 			dptinfo.push(dptstr[i]);
// 		}
		
		console.log("###dptinfo####");
		console.log(dptinfo);
		console.log("#######");
		//dptinfo.push($("[name='DPT_NAME']").val());
			
		//alert(dptinfo[0]);
		
		
	////////////학력정보
	

		
		var edu_map = {}; 
		var aa = "";
		
		$('#edu-tr tr').each(function(index,t){
// 			eduInfo[1][emp_no]=2
// 			 eduInfo[1][emp_accr_no]=1
// 			 eduInfo[1][schl_name]=서울여대
			edu_info = {};
			if($('input[name="SCHL_NAME"]').eq(index).val() != null && $('input[name="SCHL_NAME"]').eq(index).val() != "" ){
				var b =$('input[name="EMP_ACCR_NO"]').eq(index).val();	
				if(edu_insert == "") edu_insert += b;
				else edu_insert += "/"+b;
				  edu_map[b] = {
					 	"emp_no" : $("[name='EMP_NO']").val() ,
						"emp_accr_no" : $('input[name="EMP_ACCR_NO"]').eq(index).val() ,
						"schl_name" : $('input[name="SCHL_NAME"]').eq(index).val() ,
						"entr_date" : $('input[name="ENTR_DATE"]').eq(index).val() ,
						"grdn_date" : $('input[name="GRDN_DATE"]').eq(index).val() ,
						"majr_name" : $('input[name="MAJR_NAME"]').eq(index).val() ,
						"grad_val01" : $('input[name="GRAD_VAL01"]').eq(index).val() ,
						"grad_val02" : $('input[name="GRAD_VAL02"]').eq(index).val() ,
						"grdn_cls_code" : $("select[name='GRDN_CLS_CODE'] option:selected").eq(index).attr("class") ,
						"degr_cls_code" : $("select[name='DEGR_CLS_CODE'] option:selected").eq(index).attr("class")
					}
						
					
				//edu_map[$('input[name="EMP_ACCR_NO"]').eq(index).val()] = edu_info ;
			
				//$("#셀렉트박스ID option:selected").val();
				//$("input[type=radio][name=rdoName]:checked").val();
			}
		}); // 학력사항
		
		console.log("###edu_map####");
		console.log(edu_map);
		console.log("#######");
		
		var work_info = {};
		var work_map = {};
		
	////////////경력정보			
		$('#work-tr tr').each(function(index,t){
			//("select[name='NAME']").val()
			work_info = {};
			if($('input[name="OFFC_NAME"]').eq(index).val() != null && $('input[name="OFFC_NAME"]').eq(index).val() != ""){
				
				var b = $('input[name="EMP_CARR_NO"]').eq(index).val();
				if(work_insert == "") work_insert += b;
				else work_insert += "/"+b;
				
				work_info["emp_no"] = $("[name='EMP_NO']").val();
				work_info["emp_carr_no"] = $('input[name="EMP_CARR_NO"]').eq(index).val();
				work_info["offc_name"] = $('input[name="OFFC_NAME"]').eq(index).val();
				work_info["wrk_cls_code"] = $('select[name="WRK_CLS_CODE"] option:selected').eq(index).attr("class");
				work_info["wrk_strt_date"] = $('input[name="WRK_STRT_DATE"]').eq(index).val();
				work_info["wrk_end_date"] = $('input[name="WRK_END_DATE"]').eq(index).val();
				work_info["wrk_dpt_name"] = $('input[name="WRK_DPT_NAME"]').eq(index).val();
				work_info["chrg_tsk_cntt"] = $('input[name="CHRG_TSK_CNTT"]').eq(index).val();
				work_info["rsgn_resn_cntt"] = $('input[name="CHRG_TSK_CNTT"]').eq(index).val();
				
				work_map[$('input[name="EMP_CARR_NO"]').eq(index).val()] = work_info ; 
			}
		}); // 경력사항
		
		console.log("###work_map####");
		console.log(work_map);
		console.log("#######");

		// basicInfo 기본 /인적 사항
		
		// dptinfo 부서사항
		
		// edu_map 학력테이블
		
		// work_map 경력테이블
		
		$.ajax({
			method : "POST",
			data : {
		  	     "emp_no" : empNo,
			     "workInfo" : work_map,
			     "work_del" : work_delarr,
			     "work_insert" : work_insert,
			     "eduInfo" : edu_map,
			     "edu_del" : edu_delarr,
			     "edu_insert" : edu_insert,
			     "basicInfo" : basicInfo,
			     "dptInfo" : dptinfo
			},
			url : "/updateEmpinfo",
			dataType : "json", 
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
			//var id = "";
			//if(${empBasicinfo.EMP_NO} != null && ${empBasicinfo.EMP_NO} != "") id = ${empBasicinfo.EMP_NO};
			var url='/empinfo/dpt?emp_no='+${empBasicinfo.EMP_NO};
	        window.open(url,"","width=700,height=700,left=10,top=50");		
		}
		
		function check_only(obj, id){
			$('input[type="radio"][id="'+id+'"]').each(function(i,t){
				//alert($(t).attr('class')+"/"+$(obj).attr('class'));
				if($(t).attr('class') != $(obj).attr('class')) $(t).prop("checked", false);

			});
		}
	</script>	
	
	<style>
		#edu-tr,
		#work-tr {
		
		}
		
		
		.emp_dpt_name input[type='text']{
			float : left;
			width : 80%;
		}
	</style>
	
		<div class="col-xs-10 right">
			<form name="infofrm" method="post" id="infofrm">
			
				<input type="hidden" name="AUTH_CLS_CODE" id="AUTH_CLS_CODE" value="${empBasicinfo.AUTH_CLS_CODE}">
				
				<div class="col-xs-12">
					&nbsp;
				</div>
				<div class="col-xs-12">
					<div class="col-xs-10">
						&nbsp;
					</div>
					<div class="col-xs-2">
						&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" class="btn btn-md" onclick="update_data()">
							저장
						</button>
						<button type="reset" class="btn btn-md">
							취소
						</button>
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
					    		<input id="name-ko" type="text" class="form-control" name="EMP_NO" value="${empBasicinfo['EMP_NO']}" readonly>		    		
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
						    	<input id="name-ko" type="text" class="form-control" value="${empBasicinfo['EMP_NAME']}" name="EMP_NAME" placeholder="-">
						  	</div>
					  	</div>
					  	<div class="col-xs-4 emp_stts_name">
							<div class="input-group">
						    	<span class="input-group-addon">상태</span>
						    		
						    	<select class="form-control" name="EMP_STTS_CODE" id="EMP_STTS_CODE"> 
						    			<option class="">선택</option>
									<c:forEach var="emp_stts" items="${groupCode.EMP_STTS_CODE}">
										<option class="${emp_stts.CODE_ID}">${emp_stts.CODE_NAME} / ${emp_stts.CODE_ID}</option>
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
						    	<input id="name-ko" type="date" class="form-control" value="${empBasicinfo['JOIN_DATE']}" name="JOIN_DATE"  placeholder="-">
						  	</div>
					  	</div>
					  	<div class="col-xs-4 emp_end_date">
							<div class="input-group">
						    	<span class="input-group-addon">퇴사일자</span>
						    	<input id="name-ko" type="date" class="form-control" value="${empBasicinfo['RSGN_DATE']}" name="RSGN_DATE"  placeholder="-">
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
					  	
<!-- 					  	<div class="col-xs-4"> -->
							
<!-- 					  	</div> -->
					  	
					  	<div class="col-xs-4 emp_dpt_">
							<div class="input-group">
						    	<span class="input-group-addon">직위</span>
						    	
						    	<select class="form-control" name="DPT_ROLE_CLS_CODE" id="DPT_ROLE_CLS_CODE"> 
						    		<option class="">선택</option>
									<c:forEach var="dpt_role" items="${groupCode.DPT_ROLE_CLS_CODE}">
										<option class='${dpt_role.CODE_ID}'>${dpt_role.CODE_NAME} / ${dpt_role.CODE_ID}</option>
									</c:forEach>
								</select>	
						  	</div>
					  	</div>
					  	
					  	<div class="col-xs-4">
							<div class="input-group emp_">
						    	<span class="input-group-addon">직급</span>
						    	<select class="form-control" name="RNK_CODE" id="RNK_CODE"> 
						    		<option id="default" class="">선택</option>
						    		<c:forEach var="rnk" items="${groupCode.RNK_CODE}">
						    			<option class="${rnk.CODE_ID}">
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
						    		value="${empBasicinfo['DPT_NAME']}" name="DPT_NAME" readonly  placeholder="-">
						    	<button type="button" class="btn btn-default" id="dtpsearchbt" onclick="searchdpt()">
							    	<span class="glyphicon glyphicon-search"></span>
							    </button>
						  	</div>
					  	</div>
					  	
					  	<div class="col-xs-4 emp_email">
							<div class="input-group">
						    	<span class="input-group-addon">Email</span>
						    	<input id="name-ko" type="text" class="form-control" value="${empBasicinfo['COMP_EMAIL']}"name="COMP_EMAIL"  placeholder="-">
						  	</div>
					  	</div>
					  	
					  	<div class="col-xs-4 emp_tel">
							<div class="input-group">
						    	<span class="input-group-addon">연락처</span>
						    	<input id="name-ko" type="text" class="form-control" value="${empBasicinfo['CNTCT_NO']}"name="CNTCT_NO"  placeholder="-">
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
								       		<input type="text" class="basictext" value="${empBasicinfo['EMP_ENG_NAME']}" placeholder="-" name="EMP_ENG_NAME" >
								       </td>							       
								       <th>주민등록번호</th>
								       
								       <c:set var="ref_no" value="${empBasicinfo['RSDN_REG_CODE']}"/>
								       
								       <td colspan="3">
								       		<input type="text" class="basictext" value="${fn:substring(TextValue,0,5) }" name="RSDN_REG_NO_1" placeholder="" >
								       		&nbsp;&nbsp; - &nbsp;&nbsp;
								       		<input type="passwd" class="basictext" value="${fn:substring(TextValue,6,12) }" name="RSDN_REG_NO_2" placeholder="" >								       		 
								       </td>
								     </tr>
								     <tr>
								       <td class="name">한문</td>
								       <td>
								       		<input type="text" class="basictext" value="${empBasicinfo['EMP_CHN_NAME']}" name="EMP_CHN_NAME"  placeholder="-">
								       </td>
								       <th>생년월일</th>
								       <td>
								       		<input type="date" class="basictext" value="${empBasicinfo['BRTH_DATE']}" name="BRTH_DATE"  placeholder="-">
								       </td>
								       <th>성별</th>
								       <td>
								       		<c:forEach var="gndr" items="${groupCode.GNDR_CODE}">
								    			<div class="form-check info-radio">
													<label>
														<input type="radio" id="GNDR_CODE" class="${gndr.CODE_ID}" onclick="check_only(this, 'GNDR_CODE')"> 
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
								       		<input type="text" class="basictext" value="${empBasicinfo['ZIP_CODE']}" name="ZIP_CODE" id="ZIP_CODE" placeholer="-">
								       		<button type="button" class="btn btn-default" id="address-bt" onclick="address()">
										    	<span class="glyphicon glyphicon-search"></span>
										    </button>
								       </td>
								       <td>기본주소</td>
								       <td colspan="4">
								       		<input type="text" class="basictext" value="${empBasicinfo['HOME_ADDR']}" id="HOME_ADDR" name="HOME_ADDR" placeholer="-">
								       </td>
								     </tr>	
								     <tr>
								     	<td>상세주소</td>
								     	<td colspan="5">								       		
								       		<input type="text" class="basictext" value="${empBasicinfo['HOME_DTL_NO']}" name="HOME_DTL_NO" placeholder="-"> 						        			  
								       </td>
								     </tr>
								     <tr>
								       <th>Email</th>
								       <td colspan="2">
								       		<input type="text" class="basictext" value="${empBasicinfo['PSNL_EMAIL']}" name="PSNL_EMAIL"  placeholder="-">
								       </td>
								       <th>비상연락처</th>
								       <td colspan="3">
								       		<input type="text" class="basictext" value="${empBasicinfo['EMRG_CNTCT_NO']}" name="EMRG_CNTCT_NO"  placeholder="-">
								       </td>
								     </tr>	
								     <tr>								       
								       <th rowspan="2">결혼</th>
								       <td colspan="2">
								       		<div class="mrrg-radio-div">
									       		<div class="form-check info-radio">
													<label>
														<input id="MRRG_YN" type="radio" value="N" class="N" onclick="check_only(this, 'MRRG_YN')">  <span class="label-text">미혼</span>
													</label>
												</div>	
												<div class="form-check info-radio">
													<label>
														<input id="MRRG_YN" type="radio"  value="Y" class="Y" onclick="check_only(this, 'MRRG_YN')"> <span class="label-text">기혼</span>
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
															<input type="radio" id="MSVC_CLS_CODE" value="${msvc.CODE_ID}" class="${msvc.CODE_ID}"  onclick="check_only(this, 'MSVC_CLS_CODE')"> 
															<span class="label-text">${msvc.CODE_NAME}</span>
														</label>
													</div>	
									    		</c:forEach>	
											</div>							       		
								       </td>
								     </tr>
								     <tr>
								     	<td colspan="2">
								     		<input type="date" class="basictext" value="${empBasicinfo['MRRG_DATE']}" name="MRRG_DATE" >							     		
								     	</td>
								     	<td colspan="3">
								     		<input type="date" class="basictext" value="${empBasicinfo['MSVC_STRT_DATE']}" name="MSVC_STRT_DATE" >
								     		~
								     		<input type="date" class="basictext" value="${empBasicinfo['MSVC_END_DATE']}" name="MSVC_END_DATE" >
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
								     
								     <c:set var="num" value="${1}"/>
								     <c:forEach var="edu" items="${empEducationinfo}">		
								     	<c:set var="num" value="${num+1}"/>					     
										<tr id='${edu.EMP_ACCR_NO}'>
										    <td>
												<input type='text' class='edutext'  value='${edu.SCHL_NAME}' name='SCHL_NAME'>
												<input type="hidden" name='EMP_ACCR_NO' value="${edu.EMP_ACCR_NO}">					    
										    </td>
										    <td>
										    	<input type='text' class='edutext'  value='${edu.ENTR_DATE}' name='ENTR_DATE'>	~<br>
										    	<input type='text' class='edutext'  value='${edu.GRDN_DATE}' name='GRDN_DATE'>
										    </td>	
										    <td>
												<input type='text' class='edutext'  value='${edu.MAJR_NAME}' name='MAJR_NAME'>					    
										    </td>
										    <td>
										    	<select id="GRDN_CLS_CODE" name="GRDN_CLS_CODE" class="form-control info-sel">										 
													<option class="">선택</option> 
										    		<c:forEach var="grdn" items="${groupCode.GRDN_CLS_CODE}">
										    			<option <c:if test="${edu.GRDN_CLS_CODE eq grdn.CODE_ID}"> selected</c:if> class='${grdn.CODE_ID}'>
										    				${grdn.CODE_NAME} 
										    			</option>	
										    		</c:forEach>
												</select>			    
										    </td>
										    <td>
											    <select id="DEGR_CLS_CODE" name="DEGR_CLS_CODE" class="form-control info-sel">
										    		<option class="">선택</option> 
										    		<c:forEach var="degr" items="${groupCode.DEGR_CLS_CODE}">
										    			<option <c:if test="${edu.DEGR_CLS_CODE eq degr.CODE_ID}"> selected</c:if> class='${degr.CODE_ID}'>
										    				${degr.CODE_NAME}
										    			</option>	
										    		</c:forEach>
												</select>				    
										    </td>
										    <td>	
												<input type='text' class='edutext' name='GRAD_VAL01'>	
													&nbsp;&nbsp; / &nbsp;&nbsp;
												<input type='text' class='edutext' name='GRAD_VAL02'>				    
										    </td>		
										    <td>
										   		<button type='button' name='${edu.EMP_ACCR_NO}' class='btn btn-sm btn-default' id='edu-del-bt'> 
													삭제
												</button>
										    </td>
									    </tr>
								     </c:forEach>
								     
								     <c:if test="${num < 5}">
								     	<c:forEach begin="${num}" end="5">
									     	<tr id='${num}'>
											    <td>
													<input type='text' class='edutext'  value='' name='SCHL_NAME'>		
													<input type="hidden" name='EMP_ACCR_NO' value="${num}">					    
											    </td>
											    <td>
											    	<input type='date' class='edutext'  value='' name='ENTR_DATE'>
											    	<input type='date' class='edutext'  value='' name='GRDN_DATE'>
											    </td>	
											    <td>
													<input type='text' class='edutext'  value='' name='MAJR_NAME'>					    
											    </td>
											     <td>
												<select id="GRDN_CLS_CODE" name="GRDN_CLS_CODE" class="form-control info-sel">										 
													<option class="">선택</option> 
										    		<c:forEach var="grdn" items="${groupCode.GRDN_CLS_CODE}">
										    			<option class='${grdn.CODE_ID}'>
										    				${grdn.CODE_NAME} 
										    			</option>	
										    		</c:forEach>
												</select>			    
										    </td>
										    <td>
											    <select id="DEGR_CLS_CODE" name="DEGR_CLS_CODE" class="form-control info-sel">
										    		<option class="">선택</option> 
										    		<c:forEach var="degr" items="${groupCode.DEGR_CLS_CODE}">
										    			<option class='${degr.CODE_ID}'>
										    				${degr.CODE_NAME} 
										    			</option>	
										    		</c:forEach>
												</select>				    
										    </td>
											    <td>
													<input type='text' class='edutext'  value='' name='GRAD_VAL01'>	
													&nbsp;&nbsp; / &nbsp;&nbsp;
													<input type='text' class='edutext'  value='' name='GRAD_VAL01'>					    
											    </td>		
											    <td>
											   		<button type='button' name='${num}' class='btn btn-sm btn-default' id='edu-del-bt'> 
														삭제
													</button>
											    </td>
										    </tr>
										    <c:set var="num" value="${num+1}"/>	
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
								     <c:forEach var="work" items="${empCareerinfo}">
								     	<c:set var="work_num" value="${work_num +1}" />
								     	<tr id='${work.EMP_CARR_NO}'>						     	
									     	<td>
												<input type='text' class='worktext'  value='${work.OFFC_NAME}' name='OFFC_NAME'>	
												<input type="hidden" name='EMP_CARR_NO' value="${work.EMP_CARR_NO}">				    
										    </td>
										    <td>
												<input type='date' class='worktext'  value='${work.WRK_STRT_DATE}' name='WRK_STRT_DATE'>
												~
												<input type='date' class='worktext'  value='${work.WRK_END_DATE}' name='WRK_END_DATE'>				    
										    </td>
										    <td>
												<select name="WRK_CLS_CODE" class="form-control info-sel"> 
													<option>선택</option>
										    		<c:forEach var="wrk" items="${groupCode.WRK_CLS_CODE}">
										    			<option <c:if test="${work.WRK_CLS_CODE eq wrk.CODE_ID}"> selected</c:if> class='${wrk.CODE_ID}'>
										    				${wrk.CODE_NAME} / ${work.WRK_CLS_CODE} / ${wrk.CODE_ID}
										    			</option>	
										    		</c:forEach>
												</select>					    
										    </td>
										    <td>
												<input type='text' class='worktext'  value='${work.WRK_DPT_NAME}' name='WRK_DPT_NAME'>					    
										    </td>
										    <td>
												<input type='text' class='worktext'  value='${work.CHRG_TSK_CNTT}' name='CHRG_TSK_CNTT'>					    
										    </td>
										    <td>
												<input type='text' class='worktext'  value='${work.RSGN_RESN_CNTT}' name='RSGN_RESN_CNTT'>					    
										    </td>
										    <td>
											    <button type='button' name='${work.EMP_CARR_NO}' class='btn btn-sm btn-default' id='work-del-bt'>
													삭제
												</button>
										    </td>
					   					</tr>
								     </c:forEach>
								     <c:if test="${work_num < 5}">
								     	<c:forEach begin="${work_num}" end="5">
								     		<tr id='${work_num}'>					     	
										     	<td>
													<input type='text' class='worktext'  value='' name='OFFC_NAME'>		
													<input type="hidden" name='EMP_CARR_NO' value="${work_num}">			    
											    </td>
											    <td>
													<input type='date' class='worktext'  value='' name='WRK_STRT_DATE'>
													~
													<input type='date' class='worktext'  value='' name='WRK_END_DATE'>				    
											    </td>
											    <td>
													<select name="WRK_CLS_CODE" class="form-control info-sel"> 
														<option>선택</option>
											    		<c:forEach var="wrk" items="${groupCode.WRK_CLS_CODE}">
											    			<option class='${wrk.CODE_ID}'>
											    				${wrk.CODE_NAME}
											    			</option>	
											    		</c:forEach>
													</select>						    
										   	 	</td>
											    <td>
													<input type='text' class='worktext'  value='' name='WRK_DPT_NAME'>					    
											    </td>
											    <td>
													<input type='text' class='worktext'  value='' name='CHRG_TSK_CNTT'>					    
											    </td>
											    <td>
													<input type='text' class='worktext'  value='' name='RSGN_RESN_CNTT'>					    
											    </td>
											    <td>
												    <button type='button' name='${work_num}' class='btn btn-sm btn-default' id='work-del-bt'>
														삭제
													</button>
											    </td>
						   					</tr>
						   					<c:set var="work_num" value="${work_num +1}" />
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



