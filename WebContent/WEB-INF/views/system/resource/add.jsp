<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="../../common/common.jsp"%>
<%@ include file="../../common/common_html_validator.jsp"%>
<title>资源新增/修改</title>
</head>
<body>
	<form action="" theme="simple" id="form" method="post" name="form">
	    <input type="hidden" name="id" value="${id }" />		
		<table class="table table-bordered" style="width: 95%;margin: auto;">
            <tr>
				<td style="text-align: right;">分类</td>
				<td style="text-align: left;">
				   <select name="pid">
				       <option value="">--请选择--</option>
					   <c:forEach items="${resourceList }" var="r">
					       <option value="${r.id }" 
					       <c:if test="${rootResource.id == r.id }">
					        	selected="true"
					       </c:if>
					       >${r.name }</option>
					   </c:forEach>
				   </select>
				</td>
			</tr>
			
			<tr>
				<td style="text-align: right;">资源类型</td>
				<td style="text-align: left;">
				   <select name="type">
				       <option value="">--请选择--</option>
					   <option value="module" 
					   <c:if test="${resource.type == 'module' }">
					      selected="true" 
					   </c:if>
					   >模块</option>
					   <option value="page"
					    <c:if test="${resource.type == 'page' }">
					      selected="true" 
					   </c:if>
					   >页面</option>
				   </select>
				</td>
			</tr>
			
			<tr>
				<td style="text-align: right;">名称</td>
				<td style="text-align: left;"><input type="text" name="name" value="${resource.name }"  id="name" data-rule="名称;required;name;" size="20" maxlength="20" />
				</td>
			</tr>
			
			<tr>
				<td style="text-align: right;">资源URL</td>
				<td style="text-align: left;"><input type="text" name="url" value="${resource.url }"  id="url" />
				</td>
			</tr>
			
			<tr>
				<td colspan="2" style="text-align: center;">
						<c:choose>
						  <c:when test="${id == null || id == '' }">
						    <button  method="saveorupdate" class="btn btn-success">
								<i class="icon-ok icon-white"></i> 新增
							</button>
						  </c:when>
						  <c:otherwise>
						  	<button method="saveorupdate" class="btn btn-success">
								<i class="icon-ok icon-white"></i> 保存
							</button>
						  </c:otherwise>
						</c:choose>
					<button class="btn btn-inverse" onclick="history.go(-1);">
						<i class="icon-arrow-left icon-white"></i> 返回
					</button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
