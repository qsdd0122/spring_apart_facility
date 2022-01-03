<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@include file = "./includes/header.jsp" %>
<html>
   <head>
      <meta charest="utf-8">
      <title></title>
      <script>
         function print_dan() {
            var sel = document.getElementByld("dan");
            var d = sel.options[sel.selectedlndex].value;
            
            document.write("== " + d + " 단 == <br>");
            for (var n = d;n <= 10; n++) {
               document.write(d + "*" + n + " = " + d*n + <br>");
	  		alert(d);
            }
         }
      </script>
   </head>
   <body>
      <h3>1에서부터 100까지의 수에서 특정 수의 배수의 합 구하기</h3>
      <hr size=3 color=blue>
      <form>
         합을 구하기 원하는 배 수 선택
         <select id="dan" onchange="print_dan()">
            <option value="0">선택</option>
            <option value="1">1</option></a>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
            <option value="6">6</option>
            <option value="7">7</option>
            <option value="8">8</option>
            <option value="9">9</option>
            <option value="10">10</option>
         </select>
      </form>
   </body>
</html>