<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page session="false" %>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>公告列表</title>
<%@ include file="../common/common.jsp"%>
<script type="text/javascript" src="${ctx }/static/js/manage-web-common.js"/></script>
<script type="text/javascript">
	$(function(){
		$('#fresh_button').bind("click",function(){
			$("input[name='id']").val("");
			$("input[name='title']").val("");
			$("#displayType").val("");
			$("#noticeType").val("");
			$("input[name='startDateFrom']").val("");
			$("input[name='startDateTo']").val("");
			$("input[name='endDateFrom']").val("");
			$("input[name='endDateTo']").val("");
		});
		
		$("input[name='startDateFrom']").datepicker({
		  	format: 'yyyy-mm-dd',
	        weekStart: 1,
	        autoclose: true,
	        todayBtn: 'linked',
	        language: 'cn'
		});
		$("input[name='startDateTo']").datepicker({
		  	format: 'yyyy-mm-dd',
	        weekStart: 1,
	        autoclose: true,
	        todayBtn: 'linked',
	        language: 'cn'
		});
		$("input[name='endDateFrom']").datepicker({
		  	format: 'yyyy-mm-dd',
	        weekStart: 1,
	        autoclose: true,
	        todayBtn: 'linked',
	        language: 'cn'
		});
		$("input[name='endDateTo']").datepicker({
		  	format: 'yyyy-mm-dd',
	        weekStart: 1,
	        autoclose: true,
	        todayBtn: 'linked',
	        language: 'cn'
		});
	});

function updateDeleteFlag(ids,deleteFlag){
	$.ajax({
		type: "POST",
       	url:"${ctx }/notice/deleteFlag",
    	data:JSON.stringify({'ids':ids,'deleteFlag':deleteFlag}),
    	contentType: "application/json",
    	success:function(json) {
       		if(json.success){
       			alert('成功');
       			window.location.replace("${ctx }/notice/list");
       		}else{
       			alert('失败');
       		}
       	}    
	});
}
</script>
</head>

<body>
<form action="" name="form" id="form" method="post" theme="simple">
	<table class="table table-bordered table-condensed">
		<tr>
			<th class="td_right">ID：</th>
			<td>
				<input type="text" name="id" value="${queryDto.id }">
			</td>
			<th class="td_right">标题：</th>
			<td>
				<input type="text" name="titleContent" value="${queryDto.title }">
			</td>
		</tr>
		<tr>
			<th class="td_right">公告类型：</th>
			<td>
				<select id="noticeType" name="noticeType">
					<option value="">--请选择--</option>
					<option value="0" <c:if test="${'0' == queryDto.noticeType }">selected</c:if>>重要公告</option>
					<option value="1" <c:if test="${'1' == queryDto.noticeType }">selected</c:if>>优惠通知</option>
				</select>
			</td>
			<th class="td_right">是否有效：</th>
			<td>
				<select id="status" name="status">
					<option value="">--请选择--</option>
					<option value="0" <c:if test="${'0' == queryDto.status }">selected</c:if>>无效</option>
					<option value="1" <c:if test="${'1' == queryDto.status }">selected</c:if>>有效</option>
				</select>
			</td>
		</tr>
		<tr>	
			<th class="td_right">有效期开始时间：</th>
			<td colspan="3">
				从：<input type="text" name="startDateFrom" value="<fmt:formatDate value='${queryDto.startDateFrom}' pattern='yyyy-MM-dd'/>">到：
				<input type="text" name="startDateTo" value="<fmt:formatDate value='${queryDto.startDateTo}' pattern='yyyy-MM-dd'/>">
			</td>
		</tr>
		<tr>	
			<th class="td_right">有效期截止时间：</th>
			<td colspan="3">
				从：<input type="text" name="endDateFrom" value="<fmt:formatDate value='${queryDto.endDateFrom}' pattern='yyyy-MM-dd'/>">到：
				<input type="text" name="endDateTo" value="<fmt:formatDate value='${queryDto.endDateTo}' pattern='yyyy-MM-dd'/>">
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
				<button class="btn btn-success" onclick="return toAdd();">
					<i class="icon-plus-sign icon-white"></i> 添加
				</button>	
			</td>
		</tr>
	</table>
	
	<table class="table table-bordered table-hover">
		<thead>
			<tr style="background-color: #dff0d8">
				<th width="20"><input type="checkbox" id="firstCheckbox"/></th>
				<th>ID</th>
				<th>标题</th>
				<th>应用平台</th>
				<th>显示类型</th>
				<th>公告类型</th>
				<th>是否有效</th>
				<th>有效期开始日期</th>
				<th>有效期截止日期</th>
				<th>状态</th>
				<th nowrap="nowrap">操作</th>
			</tr>
		</thead>
		<c:forEach items="${page.list }" var="u">
			<tr >
			   <td><input type="checkbox" name="ids" value="${u.id }"/></td>
			   <td>&nbsp;${u.id }</td>
			   <td>&nbsp;${u.title }</td>
			   <td>
			   		<c:choose>
			   			<c:when test="${u.applyType == '0' }"><font color="green">交易平台</font></c:when>
			   			<c:when test="${u.applyType == '1' }"><font color="blue">前台系统</font></c:when>
			   			<c:when test="${u.applyType == '2' }">通用</c:when>
			   			<c:otherwise>&nbsp;</c:otherwise>
			   		</c:choose>
			   </td>
			   <td>
			   		<c:choose>
			   			<c:when test="${u.displayType == '0' }"><font color="green">弹窗</font></c:when>
			   			<c:when test="${u.displayType == '1' }"><font color="red">通知栏</font></c:when>
			   			<c:when test="${u.displayType == '2' }"><font color="red">通用</font></c:when>
			   			<c:otherwise>&nbsp;</c:otherwise>
			   		</c:choose>
			   </td>			   
			   <td>
			   		<c:choose>
			   			<c:when test="${u.noticeType == '0' }"><font color="green">重要公告</font></c:when>
			   			<c:when test="${u.noticeType == '1' }"><font color="red">优惠通知</font></c:when>
			   			<c:otherwise>&nbsp;</c:otherwise>
			   		</c:choose>
			   </td>			   
			   <td>
			   		<c:choose>
			   			<c:when test="${u.status == '1' }"><font color="green">有效</font></c:when>
			   			<c:when test="${u.status == '0' }"><font color="red">无效</font></c:when>
			   			<c:otherwise>&nbsp;</c:otherwise>
			   		</c:choose>
			   </td>			   
			   <td><fmt:formatDate value="${u.startDate}" type="both" pattern="yyyy-MM-dd"/></td>
			   <td><fmt:formatDate value="${u.endDate}" type="both" pattern="yyyy-MM-dd"/></td>
			   <td>
			   		<c:choose>
			   			<c:when test="${u.deleteFlag == '0' }"><font color="green">正常</font></c:when>
			   			<c:when test="${u.deleteFlag == '1' }"><font color="red">删除</font></c:when>
			   			<c:otherwise>&nbsp;</c:otherwise>
			   		</c:choose>
			   </td>			   
			   <td>
			      <a href="${ctx }/voteTopic/edit?id=${u.id}">编辑</a>
			      <c:choose>
			      	<c:when test="${u.deleteFlag == 1}"><a name="revert_href"><input type="hidden" value="${u.id}"/>恢复</a>&nbsp;</c:when>
			      	<c:otherwise><a name="delete_href"><input type="hidden" value="${u.id}"/>删除</a></c:otherwise>
			      </c:choose>
			   </td>
		    </tr>
		</c:forEach>
		<tr>
			<td width="20"><input type="checkbox" id="checkAll"/></td>
			<td colspan="20">
				<button id="delete_button" class="btn btn-danger"><i class="icon-remove icon-white"></i>删除</button>&nbsp;
				<button id="revert_button" class="btn btn-warning"><i class="icon-repeat icon-white"></i>恢复</button>
			</td>
		</tr>		
		<tr><td colspan="16" style="text-align:center;"><%@ include file="../common/pager.jsp"%></td>
		</tr>
	</table>
</form>
 <script type="text/javascript">
	function toAdd(){
		var _url = "${ctx }/notice/edit";
        var _form = $("#form");
		_form.attr("action",_url);
		_form.submit();
	}
 </script>
</body>
</html>
