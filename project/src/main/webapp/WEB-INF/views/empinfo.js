/**
 * 	empinfo.js
 */

$(document).ready(function(){

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

	var basicInfo = {};
	
	 basicInfo["EMP_NO"] = $("[name='EMP_NO']").val();
	
	 basicInfo["EMP_STTS_CODE"] = $("#EMP_STTS_CODE option:selected").val();		//select
	 basicInfo["EMP_NAME"] = $("[name='EMP_NAME']").val();
	 basicInfo["JOIN_DATE"] = $("[name='JOIN_DATE']").val();
	 basicInfo["RSGN_DATE"] = $("[name='RSGN_DATE']").val();
	 basicInfo["RNK_CODE"] = $("#RNK_CODE option:selected").val();		//select
	 basicInfo["DPT_NAME"] = $("[name='DPT_NAME']").val();
	 basicInfo["COMP_EMAIL"] = $("[name='COMP_EMAIL']").val();
	 basicInfo["CNTCT_NO"] = $("[name='CNTCT_NO']").val();
	 basicInfo["DPT_ROLE_CLS_CODE"] = $("#DPT_ROLE_CLS_CODE option:selected").val();		//select
	 //$("#셀렉트박스ID option:selected").val();
	 //$("input[type=radio][name=rdoName]:checked").val();


	 basicInfo["EMP_ENG_NAME"] = $("[name='EMP_ENG_NAME']").val();
	 basicInfo["EMP_CHN_NAME"] = $("[name='EMP_CHN_NAME']").val();
	 basicInfo["BRTH_DATE"] = $("[name='BRTH_DATE']").val();
	 basicInfo["GNDR_CODE"] = $("input[type='radio'][name='GNDR_CODE']:checked").val();		//radio
	 basicInfo["RSDN_REG_NO"] = $("[name='RSDN_REG_NO']").val();
	 basicInfo["ZIP_CODE"] = $("[name='ZIP_CODE']").val();
	 basicInfo["HOME_ADDR"] = $("[name='HOME_ADDR']").val();
	 basicInfo["HOME_DTL_NO"] = $("[name='HOME_DTL_NO']").val();
	 basicInfo["PSNL_EMAIL"] = $("[name='PSNL_EMAIL']").val();
	 basicInfo["EMRG_CNTCT_NO"] = $("[name='EMRG_CNTCT_NO']").val();
	 basicInfo["MSVC_CLS_CODE"] = $("input[type='radio'][name='MSVC_CLS_CODE']:checked").val();		//radio
	 basicInfo["MSVC_STRT_DATE"] = $("[name='MSVC_STRT_DATE']").val();
	 basicInfo["MSVC_END_DATE"] = $("[name='MSVC_END_DATE']").val();
	 basicInfo["MRRG_YN"] = $("input[type='radio'][name='MRRG_YN']:checked").val();		//radio
	 basicInfo["MRRG_DATE"] = $("[name='MRRG_DATE']").val();
	 basicInfo["MRRG_DATE"] = $("[name='MRRG_DATE']").val();
	
	
	console.log("#######");
	console.log(basicInfo);
	console.log("#######");

////////////학력정보

	var edu_info = {};
	var edu_arr = new Array();
	
	$('#edu-tr tr').each(function(index,t){
		
		edu_info = {};
		if($('input[name="SCHL_NAME"]').eq(index).val() != null){
			edu_info["SCHL_NAME"] = $('input[name="SCHL_NAME"]').eq(index).val();
			edu_info["ENTR_DATE"] = $('input[name="ENTR_DATE"]').eq(index).val();
			edu_info["GRDN_DATE"] = $('input[name="GRDN_DATE"]').eq(index).val();
			edu_info["MAJR_NAME"] = $('input[name="MAJR_NAME"]').eq(index).val();
			edu_info["GRAD_VAL01"] = $('input[name="GRAD_VAL01"]').eq(index).val();
			edu_info["GRDN_CLS_CODE"] = $("select[name='GRDN_CLS_CODE']").eq(index).val();
			edu_info["DEGR_CLS_CODE"] = $("select[name='DEGR_CLS_CODE']").eq(index).val();
			edu_arr.push(edu_info); 
		}
	}); // 학력사항
	
	console.log(edu_arr);
	
	var work_info = {};
	var work_arr = new Array();
	
////////////경력정보			
	$('#work-tr tr').each(function(index,t){
		//("select[name='NAME']").val()
		work_info = {};
		if($('input[name="OFFC_NAME"]').eq(index).val() != null){
			work_info["OFFC_NAME"] = $('input[name="OFFC_NAME"]').eq(index).val();
			work_info["WRK_SCLS_CODE"] = $('select[name="WRK_SCLS_CODE"]').eq(index).val();
			work_info["WRK_STRT_DATE"] = $('input[name="WRK_STRT_DATE"]').eq(index).val();
			work_info["WRK_END_DATE"] = $('input[name="WRK_END_DATE"]').eq(index).val();
			work_info["WRK_DPT_NAME"] = $('input[name="WRK_DPT_NAME"]').eq(index).val();
			work_info["CHRG_TSK_CNTT"] = $('input[name="CHRG_TSK_CNTT"]').eq(index).val();
			work_info["RSGN_RESN_CNTT"] = $('input[name="CHRG_TSK_CNTT"]').eq(index).val();
			work_arr.push(work_info); 
		}
	}); // 경력사항
	
	console.log(wokd_arr);
	
}