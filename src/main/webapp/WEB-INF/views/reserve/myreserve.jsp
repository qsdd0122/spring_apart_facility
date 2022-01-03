<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp" %>

            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Tables</h1>
                 
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            DataTables Advanced Tables
                        	<button id = "removeBtn" type = "button" class = "btn btn-xs pull-right">Remove</button>
                            <button id = "regBtn" type="button" class="btn btn-xs pull-right">Register</button>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <table width="100%" class="table table-striped table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>아파트 이름</th>
                                        <th>시설물 이름</th>
                                        <th>예약 시간</th>
                                        <th>예약 날짜</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${mylist }" var="board">
                                    <tr class="odd gradeX">
                                        <td id="facaptname">${board.fac_aptname}</td>
                                        <td id="facname">${board.fac_name }</td>
                                        <td>${board.reserve_time }</td>
                                        <td id="reservedate">${board.reserve_date }</td>
                                        <td><button class="cancelReserve">취소</button></td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <!-- /.table-responsive -->
                            
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
<script type="text/javascript">

    
	$(".cancelReserve").click(function(){
		var str = ""
        var tdArr = new Array();    // 배열 선언
        var checkBtn = $(this);
        var tr = checkBtn.parent().parent();
        var td = tr.children();
        console.log("클릭한 Row의 모든 데이터 : "+tr.text());
		var facaptname = td.eq(0).text();
		var facname = td.eq(1).text();
		var reservedate = td.eq(3).text();
		alert(facaptname+facname+reservedate);

		$.ajax({
	 		url : "/reserve/cancelReserve",
	 		type : "post",
	 		dataType : "text",
	 		data : {
		 		"fac_name" : facname,
	 			"fac_aptname" : facaptname,
	 			"reserve_date" : reservedate
	 		},
	 		success : function(data) {
	 			location.reload();
	 			alert(data);
	 		},
	 		error : function(error) {
	 			alert("error");
	 		}
	 	});	
	});
	
</script>
<%@include file="../includes/footer.jsp" %>