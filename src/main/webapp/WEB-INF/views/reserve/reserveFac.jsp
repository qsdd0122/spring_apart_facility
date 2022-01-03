<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp" %>
<link href="/resources/css/reserveFac.css" rel="stylesheet">
<link rel="stylesheet" href="/resources/css/bootstrap-datepicker.css">
<script src="/resources/js/bootstrap-datepicker.js"></script>
<style>
#timetable{
width:750px;
height:150px;
white-space:nowrap;
overflow-x:scroll;
}
</style>

									<input value="${info.fac_aptname }" name="aptname" type="hidden"></input>
									<input value="${info.fac_name }" name="facname" type="hidden"></input>
									<input value="${info.fac_info }" type="hidden"></input>
									<input value="${info.fac_opentime }" type="hidden"></input>
									<input value="${info.fac_closetime }" type="hidden"></input>
									<input value="${info.fac_numperson }" type="hidden" id="numperson"></input>
									<input value="${info.fac_lat }" name="faclat" type="hidden"></input>
									<input value="${info.fac_lng }" name="faclng" type="hidden"></input>
									<input type="hidden" id="rcvopenhour" value="${openhour}"/>
									<input type="hidden" id="rcvopenmin" value="${openmin}"/>
									<input type="hidden" id="rcvclosehour" value="${closehour}"/>
									<input type="hidden" id="rcvclosemin" value="${closemin}"/>
									<input type="hidden" id="numblock" value="${numtimeblock}"/>

<div class="container">

  <div class="page-header">
    <h1>${info.fac_aptname } <small>${info.fac_name }</small></h1>
  </div>

  <div class="row">

    <div class="col-md-8">
      <article id="">

        <div class="entry-content">
          <a href="">
            <img src='${info.fac_img }' class="img-fluid" width ="700" height="300"/>
          </a>
          <div id="timetable">
			`<table border="1" bordercolor="blue" width ="1000" height="80" align = "center" >
			 	 <tr align = "center" bgcolor="skybule">
				 <c:forEach var="i" begin="1" end="${numtimeblock }">
					 <td id="td${i}"><c:out value="${i }"/></td>
				 </c:forEach>
				 </tr>
				 <tr align="center">
				 <c:forEach var="i" begin="1" end=	"${numtimeblock }">
				 	<td><input type="checkbox" name="item" id="check${i }" onclick='getCheckboxValue()'></td>
				 </c:forEach>
				 </tr>
				 <c:if test="${info.fac_numperson != 1 }">
				 <tr align="center">
				 <c:forEach var="i" begin="1" end=	"${numtimeblock }">
				 	<td><p id="numcheck${i }">0</p>/${info.fac_numperson }</td>
				 </c:forEach>
				 </tr>
				 </c:if>
			 </table>
		  </div>
		  <button onclick='splitandInsert()' class="btn btn-primary">예약</button>
          <p class="lead" style="margin-top:20px;">시설물 정보 및 주의사항</p>
		  <hr/>
			<div><c:out value="${info.fac_info}" escapeXml="false" /></div>
        </div>
        <footer>
        </footer>
      </article>

    </div>
    <aside class="col-md-4">

      <div class="card mb-3">
        <h3 class="card-header mb-3">날짜 선택</h3>
        <input id="datepicker"/>

      </div>

      <h3>해당 시설물 위치</h3>
      <div id="map" style="width:200px;height:200px;"></div>
      
      
      
    </aside>
  </div>
</div>

  <div style="margin:60px auto;text-align:center;">
    <hr>
  <a href="" target="_blank"><strong>A template by Hamzeen</strong></a>
    <br><br>

  <a  href="" target="_blank"><strong>First</strong></a>&emsp;&emsp;
  <a href="" target="_blank">Second</a>&emsp;&emsp;
  <a  href="" target="_blank">Third</a>
</div>

								<input id='result'/>
								<input id='result2'/>
								<button onclick='test()'></button>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=985f52f2cde50dbe19ca2aa591157924&libraries=services"></script>
<script>
function addOpt(type){

	var selectedhour = $('#openhour').val();
	var selectedhour_close = $('#closehour').val();
	if(type == 'open'){
		$('#openmin').empty();
		if(selectedhour	== $('#rcvopenhour').val() && $('#rcvopenmin').val() == '30'){	
	        $('#openmin').append($("<option>30</option>"));
		}
		else{
	        $('#openmin').append($("<option>00</option>"));	
			$('#openmin').append($("<option>30</option>"));
		}
	} else{
		$('#closemin').empty();	
		if(selectedhour_close	== $('#rcvclosehour').val() && $('#rcvclosemin').val() == '0'){	
	        $('#closemin').append($("<option>00</option>"));
		}
		else{
	        $('#closemin').append($("<option>00</option>"));	
	        $('#closemin').append($("<option>30</option>"));
		}
	}
}

$(document).ready(function() {
	
	$('#datepicker').datepicker('setDate', '0D');
	$.ajax({
 		url : "/reserve/loadSectionNum",
 		type : "post",
 		dataType : "json",
 		data : {
	 		"fac_name" : $('input[name=facname]').val(),
 			"fac_aptname" : $('input[name=aptname]').val(),
 			"reserve_date" : $('#datepicker').val()
 		},
 		success : function(data) {
 			handleSectionNum(data);
 		},
 		error : function(error) {
 			alert("error");
 		}
 	});
	$("#datepicker").datepicker({
		format: "mm/dd/yyyy",
		startDate: '0d'
	    }).on("changeDate", function(e) {
	    	
	    	$.ajax({
	     		url : "/reserve/loadSectionNum",
	     		type : "post",
	     		dataType : "json",
	     		data : {
	    	 		"fac_name" : $('input[name=facname]').val(),
	     			"fac_aptname" : $('input[name=aptname]').val(),
	     			"reserve_date" : $('#datepicker').val()
	     		},
	     		success : function(data) {
	     			handleSectionNum(data);
	     		},
	     		error : function(error) {
	     			alert("error");
	     		}
	     	});
	    });
	
	var num = $('#numblock').val();
	var text = "";
	var hour = $('#rcvopenhour').val();
	var min = $('#rcvopenmin').val();
	for(var i=1;i<=num;i++){
		text="";
		text += hour+":"+min;
		if(min == 30){
			hour++;
			min = 0;
		}
		else min = 30;
		text += "~ "+hour+":"+min;
		$('#td'+i).text(text);
		checkEvent(i);
	}
});
	/*$(document).ready(function() {
		$("#datepicker").datepicker({
			onSelect: function(dateText) {
				$.ajax({
			 		url : "/reserve/loadReserve",
			 		type : "post",
			 		dataType : "json",
			 		data : {
				 		"fac_name" : $('input[name=facname]').val(),
			 			"fac_aptname" : $('input[name=aptname]').val(),
			 			"reserve_date" : dateText
			 		},
			 		success : function(data) {
			 			//데이터 스플릿후 처리
			 			handleRcvData(data);
			 		},
			 		error : function(error) {
			 			alert("error");
			 		}
			 	});
		    }
		});*/

	
	function checkEvent(i){
		var txt = $('#td'+i).text();
		$('#check'+i).change(function(){
	        if($('#check'+i).is(":checked")){
	            if($('#datepicker').val() == ''){
	            	alert('날짜 먼저선책');
	            	return;
	            } else {
	            	alert(txt);
	            	$('#result2').val($('#result2').val()+" "+txt);
	            }
	        }else{
	            alert("체크박스 체크 해제!");
	        }
	    });
	}
		
	function getCheckboxValue()  {
		  // 선택된 목록 가져오기
		  const query = 'input[name="item"]:checked';
		  const selectedEls = 
		      document.querySelectorAll(query);
		  
		  // 선택된 목록에서 value 찾기
		  let result = '';
		  selectedEls.forEach((el) => {
		    result += el.id + ',';
		//여기서 AJAX로 데이터 전송 (DB 저장)		    
		  });
		  
		  // 출력
		  $('#result').val(result);
	}
	
	function splitandInsert(){
		
		var input = $('#result').val()+'';
		alert(input);
		var strarr = input.split(',');
		for(var i=0;i<strarr.length-1;i++){
			alert(strarr[i]);
			$.ajax({
		 		url : "/reserve/reserve",
		 		type : "post",
		 		dataType : "text",
		 		data : {
			 		"fac_name" : $('input[name=facname]').val(),
		 			"fac_aptname" : $('input[name=aptname]').val(),
		 			"check_section" : strarr[i],
		 			"reserve_date" : $('#datepicker').val(),
		 			"reserve_time" : setTime()
		 		},
		 		success : function(data) {
		 			location.reload();
		 			alert("예약하셨습니다.");	
		 		},
		 		error : function(error) {
		 			alert("error");
		 		}
		 	});
			
		}
	}
	
	function handleRcvData(data){
		if(data != null){ 
			data = data+"";
			var strarr = data.split(',');
			var num = $('#numblock').val();
			for(var i =0;i<num;i++){
				$('#check'+i).attr("disabled",false);	
			}
			for(var i=0;i<strarr.length;i++){
				$('#'+strarr[i]).attr("disabled",true);
			}
		}
	}
	
	function handleSectionNum(data){
		var size = $('#numblock').val();
		for(var i=1;i<=size;i++) {
			console.log(i);
			$('#numcheck'+i).text(0);
		}

		var num = $('#numblock').val();
		for(var i =0;i<num;i++){
			$('#check'+i).attr("disabled",false);	
		}
		for(var i=0;i<data.length;i++){
			var id = data[i].CHECK_SECTION;
			var cnt = data[i].CNTNUM;
			$('#num'+id).text(cnt);
			
			var numperson = $('#numperson').val();
			if(cnt == numperson){
				$('#'+id).attr("disabled",true);	
			}
		}
	}
	
	function setTime(){
		var txt = $('#result2').val();
		var start = txt.substring(0,6);
		var end = txt.slice(-5, txt.length);
		var result = start+"~"+end;
		alert(result);
		return result;
	}
	var faclat = $('input[name=faclat]').val();
	var faclng = $('input[name=faclng]').val();

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(faclat, faclng), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

	// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	// 마커가 표시될 위치입니다 
	var markerPosition  = new kakao.maps.LatLng(faclat, faclng); 

	// 마커를 생성합니다
	var marker = new kakao.maps.Marker({
	    position: markerPosition
	});

	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map);
</script>
<%@include file="../includes/footer.jsp" %>