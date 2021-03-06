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
                                        <th>번호</th>
                                        <th>아파트 이름</th>
                                        <th>등록자</th>
                                        <th>등록날짜</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${list }" var="board">
                                    <tr class="odd gradeX">
                                        <td>${board.apt_bno }</td>
                                        <td><a href="/reserve/selectFac?apt_name=${board.apt_name }"><c:out value="${board.apt_name}"/></a></td>
                                        <td>${board.apt_admin }</td>
                                        <td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}" /></td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <!-- /.table-responsive -->
                            <form id="searchForm" action="/reserve/selectApart" method="get">
                            	<select name="type">
                            		<option value='T' ${pageMaker.cri.type eq 'T'? "selected":'' }>아파트 이름</option>
                            	</select>
                            	<input type='text' name='keyword' value='${pageMaker.cri.keyword }'>
                            	<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'>
                            	<input type='hidden' name='amount' value='${pageMaker.cri.amount }'>                            	
                            	<button class='btn btn-default'>검색</button>
                            </form>
                            <div class='pull-right'>
                            	<ul class="pagination">
                            		<c:if test="${pageMaker.prev }">
	                            	<li class="page-item">
								      <a class="page-link" href="${pageMaker.startPage-1 }" tabindex="-1">Previous</a>
								    </li>
								    </c:if>
                            		<c:forEach begin="${pageMaker.startPage }"
                            					end="${pageMaker.endPage }" var="num">
                         				<li class="page-item ${pageMaker.cri.pageNum == num?"active":"" }">
                         				<a class="page-link" href="${num }">${num }</a></li>     			
                            		</c:forEach>
                            		<c:if test="${pageMaker.next }">
                            		<li class="page-item">
								    	<a class="page-link" href="${pageMaker.endPage+1 }">Next</a>
								    </li>
								    </c:if>
                            	</ul>
                            </div>
                            <form id='actionForm' action="/reserve/selectApart" method='get'>
							  <input type='hidden' name='pageNum' value = '${pageMaker.cri.pageNum}'>
							  <input type='hidden' name='amount' value = '${pageMaker.cri.amount}'>
							 <input type='hidden' name='type' value = '${pageMaker.cri.type}'>
							  <input type='hidden' name='keyword' value = '${pageMaker.cri.keyword}'>
							  
							</form>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            
            <div id="myModal" class="modal" tabindex="-1" role="dialog">
				  <div class="modal-dialog" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title">Modal title</h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				      <div class="modal-body">
				        <p>Modal body text goes here.</p>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-primary">Save changes</button>
				        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				      </div>
				    </div>
				  </div>
				</div>
           
<script>
var actionForm = $("#actionForm");

$(".page-link").on("click", function(e) {		          
	e.preventDefault(); //기본 동작 제한           
	//<form>태그의 내용 변경후 submit
	actionForm.find("input[name='pageNum']").val($(this).attr("href"));
	actionForm.submit();
});
$(".move").on("click",function(e){
	e.preventDefault();
	var targetBno = $(this).attr("href");
	console.log(targetBno);
	actionForm.append("<input type='hidden' name='apt_bno' value='"+targetBno+"'>");
	actionForm.attr("action","/reserve/selectApart").submit();
	
});
					

var searchForm = $("#searchForm");

$("searchForm button").on("click", function(e){
e.preventDefault();

searchForm.find("input[name='pageNum']").val(1);
searchForm.submit();
});
</script>
<%@include file="../includes/footer.jsp" %>