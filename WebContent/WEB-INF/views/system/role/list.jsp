<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page session="false" %>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>角色管理列表</title>
<%@ include file="../../common/common.jsp"%>
</head>
<body>
<form action="" id="form1" name="form1"  method="post" theme="simple">
	<table class="table table-bordered table-condensed">
		<tr>
			<td colspan="11">
					<button method="list" class="btn btn-primary" onclick="selectList(this)">
						<i class="icon-search icon-white"></i> 查询
					</button>
					<button onclick="return toAdd();" class="btn btn-success">
						<i class="icon-plus-sign icon-white"></i> 添加
					</button>				
			</td>
		</tr>
	</table>
	
	<table class="table table-bordered table-hover">
		<thead>
			<tr style="background-color: #dff0d8">
				<th width="20"><input type="checkbox" id="firstCheckbox"/></th>
				<th>角色名称</th>
				<th>角色描述</th>
				<th>状态</th>
				<th nowrap="nowrap">操作</th>
			</tr>
		</thead>
		<c:forEach items="${roleList }" var="r">
			<tr >
			   <td><input type="checkbox" name="ids" value="${r.id }"/></td>
			   <td>&nbsp;${r.name }</td>
			   <td>&nbsp;${r.description }</td>
			   <td>&nbsp;
			     <c:choose>
			       <c:when test="${r.status == 1 }">
			        	 可用
			       </c:when>
			       <c:otherwise>
			                               停用
			       </c:otherwise>
			     </c:choose>
			   </td>
			   <td>
			      <a href="${pageContext.request.contextPath}/boss/role/add?id=${r.id}">编辑</a>
			   </td>
		    </tr>
		</c:forEach>
	</table>
</form>
 <script type="text/javascript">
	function toAdd(){
		var _url = "${pageContext.request.contextPath}/boss/role/add";
        var _form = $("#form1");
		_form.attr("action",_url);
		_form.submit();
	}
 </script>
</body>
</html>
