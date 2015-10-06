<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="common/common.jsp"%>
<title>2Profit后台系统</title>
</head>
    <c:if test="${sessionScope.user_session_info == null || sessionScope.user_session_info == '' }">
     	<c:redirect url="${pageContext.request.contextPath}/boss/login"/>
    </c:if>

<frameset border="0" rows="70,*">
	<frame src="${pageContext.request.contextPath}/boss/top" name="topFrame">
	<frameset border="0" cols="200,*">
		<frame src="${pageContext.request.contextPath}/boss/menu" name="leftFrame">
		<frame src="${pageContext.request.contextPath}/boss/resource/list" name="rightFrame">
	</frameset>
</frameset>
</html>
