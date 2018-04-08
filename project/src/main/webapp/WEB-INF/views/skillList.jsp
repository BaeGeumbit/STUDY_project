<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

	<%@include file="header.jsp" %>
	
	<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/ax5ui/ax5ui-grid/master/dist/ax5grid.css" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5core/master/dist/ax5core.min.js"></script>
	<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-grid/master/dist/ax5grid.min.js"></script>
	
	<script type="text/javascript">
    $(document.body).ready(function () {
        var API_SERVER = "http://api-demo.ax5.io";
        var firstGrid = new ax5.ui.grid({
            target: $('[data-ax5grid="first-grid"]'),
            columns: [
                {
                    key: "a",
                    label: "field A",
                    width: 80,
                    styleClass: function () {
                        return "ABC";
                    },
                    enableFilter: true,
                    align: "center"
                },
                {key: "b", label: "field  B", align: "center"},
                {
                    key: undefined, label: "field C", columns: [
                    {key: "price", label: "price", formatter: "money", align: "right"},
                    {key: "amount", label: "amount", formatter: "money", align: "right"},
                    {key: "cost", label: "cost", align: "right", formatter: "money"}
                ]
                },
                {key: "saleDt", label: "saleDt", align: "center"},
                {key: "customer", label: "customer"},
                {key: "userType", label: "userType"}
            ]
        });
 
        firstGrid.setData(gridList);
 
        // 그리드 데이터 가져오기
        /*
        $.ajax({
            method: "GET",
            url: API_SERVER + "/api/v1/ax5grid/order",
            success: function (res) {
                firstGrid.setData(res);
            }
        });
        */
 
        $('[data-grid-control]').click(function () {
            switch (this.getAttribute("data-grid-control")) {
                case "row-add":
                    firstGrid.addRow($.extend({}, firstGrid.list[Math.floor(Math.random() * firstGrid.list.length)], {__index: undefined}));
                    break;
                case "row-remove":
                    firstGrid.removeRow();
                    break;
                case "row-update":
                    var updateIndex = Math.floor(Math.random() * firstGrid.list.length);
                    firstGrid.updateRow($.extend({}, firstGrid.list[updateIndex], {price: 100, amount: 100, cost: 10000}), updateIndex);
                    break;
            }
        });
    });
</script>
		
		<div class="col-xs-10 right">
			<div class="container">
				<br><br>
				  <form name="skillListfrm" method="post">
				  
				  <div style="position: relative;height:400px;" id="grid-parent">
						<div data-ax5grid="first-grid" data-ax5grid-config="{
						                showLineNumber: true,
						                showRowSelector: true,
						                sortable: true,
						                header: {align:"center"}
						                }" style="height: 100%;"></div>
						</div>
						 
						<div style="padding: 10px;">
						    <button class="btn btn-default" data-grid-control="row-add">row add</button>
						    <button class="btn btn-default" data-grid-control="row-remove">row remove</button>
						    <button class="btn btn-default" data-grid-control="row-update">row update</button>
						</div>
				  
				  </form>	  
			</div>  <!-- .container -->
		</div><!-- .col-xs-10 right-->	
	</div><!-- .index -->

</html>