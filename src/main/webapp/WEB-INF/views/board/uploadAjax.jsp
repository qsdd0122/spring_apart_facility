<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.uploadResult {
	width:100%;
	background-color:gray;
}
.uploadResult ul{
	display:flex;
	flex-flow:row;
	justify-content:center;
	align-items:center;
}
.uploadResult ul li {
	list-style:none;
	padding:10px;
}
.uploadResult ul li img {
	width:200px;
}
</style>
<body>
<h1>upload with ajax</h1>

<div class='uploadDiv'>
	<input type='file' name='uploadFile' multiple>
</div>
<div class='uploadResult'>
	<ul></ul>
</div>
<button id='uploadBtn'>upload</button>

<script
  src="https://code.jquery.com/jquery-3.6.0.min.js"
  integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
  crossorigin="anonymous"></script>
<script>
$(document).ready(function(){
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
	$("#uploadBtn").on("click", function(e){
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
	 		url : "/board/uploadAjaxAction",
	 		processData: false,
	 		contentType : false,
	 		data : formData,
	 		type:'POST',
	 		dataType:'json',
	 		success : function(result) {
	 			console.log(result[0].uuid+result[0].fileName);
	 			showUploadedFile(result);
	 			$(".uploadDiv").html(cloneObj.html());
	 		}
	 	});
	});
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
			str+="<li><a href=\"javascript:showImage(\'"+originPath+"\')\"><img src='/board/board/display?fileName="+fileCallPath+"'></a></li>";
			
		}
	});
	uploadResult.append(str);
}

</script> 
</body>
</html>