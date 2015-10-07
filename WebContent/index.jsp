<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>2Profit后台管理系统</title>
</head>
<body>
    <c:choose>
      <c:when test="${sessionScope.user_session_info == null || sessionScope.user_session_info == '' }">
     	<c:redirect url="/boss/login"/>
      </c:when>
      <c:otherwise>
        <c:redirect url="/boss/index"/>
      </c:otherwise>
    </c:choose>
    
</body>
</html>