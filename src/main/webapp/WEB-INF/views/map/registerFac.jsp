<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp" %>

<div id="map" style="width:100%;height:350px;"></div>

<div id="clickLatlng"></div>

            <div id="myModal" class="modal" tabindex="-1" role="dialog">
				  <div class="modal-dialog" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title">아파트 정보를 저장하시겠습니끼?</h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				      <div class="modal-body">
				        	    <div class="form-group">
									<label>시설물 이름을 입력하세요</label>
                                	<input class="form-control" name = "fac_name" id="fac_name">
                                </div>
                           		<div class="form-group">
									<label>아파트 이름</label>
                                	<input class="form-control" name = "fac_aptname" id="fac_aptname" value="${apt_name }" readonly>
                                </div>
                                <div class="form-group">
                                	<label>오픈 시간</label>
                                    <select name="fac_opentime" id="openhour">
										<c:forEach var="i" begin="00" end="23">
										  <option value="${i}">${i}</option>
										</c:forEach>
								    </select>
								    <select id="openmin">
								    	<option>00</option>
								    	<option>30</option>
								    </select>
                                </div>
                                <div class="form-group">
                                	<label>클로징 시간</label>
                                    <select name="fac_closetime" id="closehour">
								        <c:forEach var="i" begin="00" end="23">
										  <option value="${i}">${i}</option>
										</c:forEach>
								    </select>
								    <select id="closemin">
								    	<option>00</option>
								    	<option>30</option>
								    </select>
								</div>
                                <div class="form-group">
									<label>보여줄 시설물 정보(시간, 특이사항 등)</label>
                                	<textarea class="form-control" rows="10" cols="50" name="fac_info" id="fac_info"></textarea>
                                </div>
								<div>
									<label>최대 인원 수(1은 대관 예약식)</label> 
									<input type="number" name="fac_numperson" id="fac_numperson" value=1/>
								</div>
								<div class="form-group">
									<div class='uploadDiv'>
										<input type='file' name='uploadFile' multiple>
									</div>
									<div class='uploadResult'>
										<ul></ul>
									</div>
								</div>
                                <div class="form-group">
                                	<input class="form-control" name = "fac_lat" id="fac_lat"  type="hidden">
                                	<input class="form-control" name = "fac_lng" id="fac_lng"  type="hidden">
	                               	<input class="form-control" name = "fac_admin" type="hidden" value = "user00">
                                </div>
                                <button type="submit" class="btn btn-default" onclick="submitForm()">Submit Button</button>
                                <button type="reset" class="btn btn-default">Reset Button</button>
                     
				      </div>
				    </div>
				  </div>
				</div>
	<input id="hidden_lat" type="hidden" value="${getApart.apt_lat }">
	<input id="hidden_lng" type="hidden" value="${getApart.apt_lng }">
	<input id="hidden_lat2" type="hidden">
	<input id="hidden_lng2" type="hidden">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=985f52f2cde50dbe19ca2aa591157924&libraries=services"></script>
<script>
var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
var maxSize = 5242880; //5MB

//파일 업로드 예외처리
function checkExtension(fileName, fileSize){
	if(fileSize >= maxSize){
		alert("파일 사이즈 초과!");
		return false;
	}
	if(regex.test(fileName)) {
		alert("해당 종류의 파일은 업로드할 수 없습니다.");
		return false;
	}
	return true;
}
var cloneObj = $(".uploadDiv").clone();
function regFac(fac_img){
	$.ajax({
 		url : "/map/registerFacility",
 		type : "post",
 		dataType : "text",
 		data : {
	 		"fac_name" : $('input[name=fac_name]').val(),
 			"fac_lat" : $('#hidden_lat2').val(),
 			"fac_lng" : $('#hidden_lng2').val(),
	 		"fac_admin" : $('input[name=fac_admin]').val(),
 			"fac_numperson" : $('input[name=fac_numperson]').val(),
 			"fac_usingperson" : 0,
 			"fac_aptname" : $('input[name=fac_aptname]').val(),
 			"fac_info" : $('textarea[name=fac_info]').val(),
 			"fac_opentime" : $('#openhour').val() + ":" + $('#openmin').val(),
 			"fac_closetime" : $('#closehour').val() + ":" + $('#closemin').val(),
 			"fac_img" : fac_img
 		},
 		success : function(data) {
 			
 			location.href="/map/facilityList";
 			alert("시설물을 등록했습니다.");
 		},
 		error : function(error) {
 			alert("error");
 		}
 	});
}
function submitForm(){
	
	
	var formData = new FormData();
	var inputFile = $("input[name='uploadFile']");
	var files = inputFile[0].files;
	
	console.log(files);

	//add filedate to formdata
	for(var i=0; i<files.length;i++){
		if(!checkExtension(files[i].name, files[i].size)) return false;
		formData.append("uploadFile", files[i]);
	}
	
	$.ajax({
 		url : "/map/uploadAjaxAction",
 		processData: false,
 		contentType : false,
 		data : formData,
 		type:'POST',
 		dataType:'json',
 		success : function(result) {
 			regFac("http://localhost:8080/map/display?fileName="+result[0].uuid+"_"+result[0].fileName);
 			console.log("http://localhost:8080/display?filaName=/"+result[0].uuid+result[0].fileName);
 			showUploadedFile(result);
 			$(".uploadDiv").html(cloneObj.html());
 		}
 	});
}

$(document).ready(function(){
	$('#fac_numperson').spinner();
	
});


// 마커를 담을 배열입니다
var markers = [];

var initLat = document.getElementById('hidden_lat').value;
var initLng = document.getElementById('hidden_lng').value;

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(initLat, initLng), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

//지도를 클릭한 위치에 표출할 마커입니다
var marker = new kakao.maps.Marker({ 
    // 지도 중심좌표에 마커를 생성합니다 
    position: map.getCenter() 
}); 
// 지도에 마커를 표시합니다
marker.setMap(map);

// 지도에 클릭 이벤트를 등록합니다
// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
    
    // 클릭한 위도, 경도 정보를 가져옵니다 
    var latlng = mouseEvent.latLng; 
    
    // 마커 위치를 클릭한 위치로 옮깁니다
    marker.setPosition(latlng);
    
    var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
    message += '경도는 ' + latlng.getLng() + ' 입니다';
    $("#hidden_lat2").val(latlng.getLat());
    $("#hidden_lng2").val(latlng.getLng());
    
    var resultDiv = document.getElementById('clickLatlng'); 
    resultDiv.innerHTML = message;

    $("#fac_lat").val(latlng.getLat());
	$("#fac_lng").val(latlng.getLng());
	$("#myModal").modal("show");
    
});

function showImage(fileCallPath){
	alert(fileCallPath);
}
var uploadResult = $(".uploadResult ul");
function showUploadedFile(uploadResultArr){
	var str="";
	$(uploadResultArr).each(function(i,obj){
		if(!obj.image){
			var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
			str += "<li><img src='/resources/img/attach.png'>"+ obj.fileName + "</li>";	
		} else {
			//str += "<li>" + obj.fileName + "</li>";
			var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
			var originPath = obj.uuid + "_" + obj.fileName;
			originPath = originPath.replace(new RegExp(/\\/g),"/");
			str+="<li><a href=\"javascript:showImage(\'"+originPath+"\')\"><img src='/map/display?fileName="+fileCallPath+"'></a></li>";
			
		}
	});
	uploadResult.append(str);
}
</script>
<%@include file="../includes/footer.jsp" %>