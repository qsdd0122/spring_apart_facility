<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp" %>
<form action="/reserve/upload" enctype="multipart/form-data" method="post">
    <input type="file" name="imgFile" />
    <input type="submit" value="이미지저장"/>
</form>

<%@include file="../includes/footer.jsp" %>