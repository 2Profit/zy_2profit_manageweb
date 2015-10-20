<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page session="false" %>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>评论列表</title>
<%@ include file="../common/common.jsp"%>
<script type="text/javascript" src="${ctx}/static/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	$(function(){
		$("#return_button").bind("click",function(event){
			event.preventDefault();
			window.location.replace("${ctx }/postUnionReplay/report/list");
		});
		
		$('#fresh_button').bind("click",function(){
			$("#ipAddress").val("");
			$("#mobile").val("");
			$("#postContent").val("");
			$("#cnName").val("");
			$("input[name='createDateFrom']").val("");
			$("input[name='createDateTo']").val("");
		});
		
	});

</script>
</head>

<body>
<form action="" name="form" id="form" method="post" theme="simple">
	<table class="table table-bordered table-condensed">
		<tr>
			<td colspan="4" style="background-color: #dff0d8;text-align: center;"><strong>举报明细列表</strong></td>
		</tr>	
		<tr>
			<th class="td_right">评论/回复内容：</th>
			<td>
			  	<input type="text" name="postContent" id="postContent" value="${queryDto.postContent }"/>
			</td>
			<th class="td_right">用户名称：</th>
			<td>
			  	<input type="text" name="cnName" id="cnName" value="${queryDto.cnName }"/>
			</td>
		</tr>
    	<tr>
			<th class="td_right">用户手机：</th>
			<td style="text-align: left;">
			  	<input type="text" name="mobile" id="mobile" value="${queryDto.mobile }"/>
			</td>
			<th class="td_right">IP地址：</th>
			<td style="text-align: left;">
			  	<input type="text" name="ipAddress" id="ipAddress" value="${queryDto.ipAddress }"/>
			</td>
		</tr>			
		<tr>	
			<th class="td_right">评论时间：</th>
			<td colspan="3">
				从：<input type="text" name="createDateFrom" value="<fmt:formatDate value='${queryDto.createDateFrom}' pattern='yyyy-MM-dd HH:mm:ss'/>"
						onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">到：
				<input type="text" name="createDateTo" value="<fmt:formatDate value='${queryDto.createDateTo}' pattern='yyyy-MM-dd HH:mm:ss'/>"
						onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
			</td>
		</tr>
		<tr>
			<td colspan="11">
				<button method="list" class="btn btn-primary" onclick="selectList(this)">
					<i class="icon-search icon-white"></i> 查询
				</button>
				<button class="btn btn-info" id="fresh_button">
					<i class="icon-repeat icon-white"></i> 刷新
				</button>				
			</td>
		</tr>
	</table>
	
	<table class="table table-bordered table-hover">
		<thead>
			<tr style="background-color: #dff0d8">
				<th width="20"><input type="checkbox" id="firstCheckbox"/></th>
				<th>举报时间</th>
				<th>举报人IP</th>
				<th>评论内容</th>
				<th>评论状态</th>
				<th>总举报数</th>
				<th>举报人电话</th>
				<th>举报人姓名</th>
				<th>类型</th>
			</tr>
		</thead>
		<c:forEach items="${page.list }" var="u">
			<tr>
			   <td><input type="checkbox" name="ids" value="${u.id }"/></td>
			   <td><fmt:formatDate value='${u.createDate}' pattern='yyyy-MM-dd HH:mm:ss'/></td>
			   <td>&nbsp;${u.ipAddress }</td>
			   <td>&nbsp;<a href="${ctx }/postUnionReplay/list?postId=${u.id}">${u.postContent }</a></td>
			   <td>
			   		<c:choose>
			   			<c:when test="${u.deleteFlag == '0' }"><font color="green">正常</font></c:when>
			   			<c:when test="${u.deleteFlag == '1' }"><font color="red">删除</font></c:when>
			   			<c:otherwise>&nbsp;</c:otherwise>
			   		</c:choose>
			   </td>
			   <td>&nbsp;${u.reportCount }</td>
			   <td>&nbsp;${u.mobile }</td>
			   <td>&nbsp;${u.cnName }</td>
			   <td>
			   		<c:choose>
			   			<c:when test="${u.type == '1' }"><font color="green">评论举报</font></c:when>
			   			<c:when test="${u.type == '2' }"><font color="orange">跟帖举报</font></c:when>
			   			<c:otherwise>&nbsp;</c:otherwise>
			   		</c:choose>
			   </td>
		    </tr>
		</c:forEach>
		
		<tr>
			<td colspan="16" style="text-align:center;"><%@ include file="../common/pager.jsp"%></td>
		</tr>
	</table>
</form>
</body>
</html>
