<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
	<h2>스프링 시큐리티 Step2</h2>
	
	<h3>로그인 화면</h3>
	
	<h4>누구나 권한없이 접근가능</h4>
	
	<c:choose>
		<c:when test="${not empty user_id }">
			${user_id }님 환영합니다!
			
			<!--  
			시큐리티 설정이 logout-url="/security2/logout" 이와 같으므로
			로그아웃의 URL은 아래와 같이 설정한다.
			-->
			<form:form method="post" 
				action="${pageContext.request.contextPath }/security2/logout">
				<input type="submit" value="로그아웃" />
			</form:form>
		</c:when>
	
		<c:otherwise>
			<!--  
			security-context.xml에서 login-processing-url을 설정한 경우
			동일한 값으로 action 속성을 설정해야 한다.
			설정하지 않았다면 default값이 "/login"이므로 이와같이 기술한다.
			
			만약 해당 설정값을 추가했다면 컨텍스트 루트 경로를 제외한 나머지 경로를
			통해 action 속성을 기술해야 한다. 
			-->
			<!-- 방법1] JSTL의 url태그를 사용한 경우 컨텍스트 루트 경로가 자동으로 붙는다. -->
			<c:url value="/myLoginAction" var="loginUrl" />
			<!-- 앞에서 url태그를 통해 설정한 값을 EL로 출력한다. -->
			<%-- <form:form name="loginFrm" action="${loginUrl }" method="post"> --%>
			<!-- 방법2] 하드코딩으로 아래와 같이 기술한다. -->
			<form:form name="loginFrm" action="../myLoginAction" method="post">
				<!--  
				시큐리티 설정에 authentication-failure-url="/security2/login.do?error"
				이와같이 기술하였으므로 로그인에 실패한 경우에는 아래와 같이 처리하면 된다.
				-->
				<c:if test="${param.error != null }"> 
					<p>아이디와 패스워드가 잘못되었습니다.</p>
				</c:if>
				<c:if test="${param.login != null }">
					<p>로그아웃 하였습니다.</p>
				</c:if>
				
				<!--  
				시큐리티 설정에 
				username-parameter="id"
				password-parameter="pass" 이와같이 설정되어있으므로 name속성은
				아래와 같이 기술한다. 
				-->
				<p>
					아이디 : <input type="text" name="id" value="kosmo_" />
				</p>
				<p>
					패스워드 : <input type="password" name="pass" />
				</p>
				<button type="submit" class="btn btn-danger">
					로그인하기
				</button>
			</form:form>
		</c:otherwise>
	</c:choose>
	<jsp:include page="/resources/common_link.jsp" />
</div>
</body>
</html>