<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../views/includes/header.jsp" %>

<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <script>
        // SDK를 초기화 합니다. 사용할 앱의 JavaScript 키를 설정해 주세요.
        Kakao.init('985f52f2cde50dbe19ca2aa591157924'); //★ 수정 할 것
        // SDK 초기화 여부를 판단합니다.
        console.log(Kakao.isInitialized());
    </script>
    <header>
        <nav class="navbar-expand-sm navbar-toggleable-sm ng-white border-bottom box-shadow mb-3 navbar navbar-light">
            <div class="container"><a class="navbar-brand" href="/"><img src="/resources/img/kakao_login_medium_narrow.png" class="logo" alt="logo">Kakao API Test</a>
                <h1>카카오 로그인(JavaScript SDK)</h1>
            </div>
        </nav>
    </header>
    <div class="container">
        <ul class="list-group">
            <li class="list-group-item">
            	<c:if test="${userInfo == null }">
                <h2>JavaScript SDK 로그인(Redirect)</h2>
                <a id="custom-login-btn" href="javascript:loginWithKakao()"><img src="/resources/img/kakao_login_medium_narrow.png" width="222" /></a>
                <script type="text/javascript">
                    function loginWithKakao() {
                        Kakao.Auth.authorize({
                            redirectUri: 'http://localhost:8080/login' //★ 수정 할 것
                        })
                    }
                </script>
               </c:if>
               <c:if test="${userInfo != null }">
               	<form name="logout" action="http://localhost:8080/logout">
				<input type="submit" value="로그아웃"/>
				</form>
               </c:if>
            </li>        
        </ul>
    </div>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<%@include file="../views/includes/footer.jsp" %>