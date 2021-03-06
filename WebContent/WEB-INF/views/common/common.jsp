<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<link rel="stylesheet" href="<%=request.getContextPath()%>/static/bootstrap/css/bootstrap.min.css"  type="text/css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/base.css"  type="text/css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/bootstrap-multiselect.css"  type="text/css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/bootstrap-datepicker.min.css"  type="text/css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/dialogCommon.css"  type="text/css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/style.css"  type="text/css">

<script type="text/javascript" src="<%=request.getContextPath() %>/static/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/static/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/static/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/static/js/manage.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/static/js/bootstrap-multiselect.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/static/js/bootstrap-datepicker.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/static/js/dialogCommon.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/static/js/jquery.form.js"></script>
<script type="text/javascript" src="${ctx }/static/layer/layer.js"></script>
<script type="text/javascript" src="${ctx }/static/js/base_util.js"></script>


<c:set var="isApprovier" value="false"/>
<c:if test="${not empty sessionScope.user_session_role }">
	<c:forEach items="${sessionScope.user_session_role }" var="r">
		<c:if test="${sessionScope.approvierRoleId eq r.id }">
			<c:set var="isApprovier" value="true"/>
		</c:if>
	</c:forEach>
</c:if>

<c:if test="${sessionScope.user_session_info.username eq 'admin' }">
	<c:set var="isApprovier" value="true"/>
</c:if>

<%
String path = request.getContextPath();
String serverPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/";
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<script type="text/javascript">
var ctx = '${ctx}';
</script>