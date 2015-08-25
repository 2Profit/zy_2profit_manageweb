<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page session="false" %>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>用户管理列表</title>
<%@ include file="../../common/common.jsp"%>
</head>
<body>
<form action="" name="form" id="form" method="post" theme="simple">
	<table class="table table-bordered table-condensed">
		<tr>
			<td colspan="11">
					<button method="list" class="btn btn-primary" onclick="selectList(this)">
						<i class="icon-search icon-white"></i> 查询
					</button>
					<button class="btn btn-success" onclick="return toAdd();">
						<i class="icon-plus-sign icon-white"></i> 添加
					</button>	
					<div style="float: right;vertical-align: middle;bottom: 0px;top: 10px;">
						<%@ include file="../../common/pager.jsp"%>
				    </div>			
			</td>
		</tr>
	</table>
	
	<table class="table table-bordered table-hover">
		<thead>
			<tr style="background-color: #dff0d8">
				<th width="20"><input type="checkbox" id="firstCheckbox"/></th>
				<th>帐号</th>
				<th>真实姓名</th>
				<th>邮箱</th>
				<th>电话</th>
				<th>状态</th>
				<th nowrap="nowrap">操作</th>
			</tr>
		</thead>
		<c:forEach items="${page.list }" var="u">
			<tr >
			   <td><input type="checkbox" name="ids" value="${u.id }"/></td>
			   <td>&nbsp;${u.username }</td>
			   <td>&nbsp;${u.realName }</td>
			   <td>&nbsp;${u.email }</td>
			   <td>&nbsp;${u.mobile }</td>
			   <td>&nbsp;
			      <c:choose>
					   <c:when test="${u.status == 0 }">
					             禁用
					   </c:when>
					   <c:otherwise>
					            正常     
					   </c:otherwise>
					</c:choose>
			   </td>
			   <td>
			      <a href="${pageContext.request.contextPath}/boss/user/add?id=${u.id}">编辑</a>
			   </td>
		    </tr>
		</c:forEach>
		<tr><td colspan="16" style="text-align:center;"><%@ include file="../../common/pager.jsp"%></td>
		</tr>
	</table>
</form>
 <script type="text/javascript">
	function toAdd(){
		var _url = "${pageContext.request.contextPath}/boss/user/add";
        var _form = $("#form");
		_form.attr("action",_url);
		_form.submit();
	}
 </script>
</body>
</html>
