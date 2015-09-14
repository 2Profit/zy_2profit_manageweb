<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page session="false" %>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>投票主题列表</title>
<%@ include file="../common/common.jsp"%>
<script type="text/javascript" src="${ctx }/static/js/manage-web-common.js"/></script>
<script type="text/javascript">
	$(function(){
		$('#fresh_button').bind("click",function(){
			$("input[name='id']").val("");
			$("input[name='titleContent']").val("");
			$("#displayPosition").val("");
			$("#isDisplay").val("");
			$("input[name='startDateBegin']").val("");
			$("input[name='startDateEnd']").val("");
		});
		
		$("input[name='startDateBegin']").datepicker({
		  	format: 'yyyy-mm-dd',
	        weekStart: 1,
	        autoclose: true,
	        todayBtn: 'linked',
	        language: 'cn'
		});
		$("input[name='startDateEnd']").datepicker({
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
       	url:"${ctx }/product/courseType/deleteFlag",
    	data:JSON.stringify({'ids':ids,'deleteFlag':deleteFlag}),
    	contentType: "application/json",
    	success:function(json) {
       		if(json.success){
       			alert('成功');
       			window.location.replace("${ctx }/product/courseType/list");
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
			<th class="td_right">题目内容：</th>
			<td>
				<input type="text" name="titleContent" value="${queryDto.titleContent }">
			</td>
		</tr>
		<tr>
			<th class="td_right">显示位置：</th>
			<td>
				<select id="displayPosition" name="displayPosition">
					<option value="">--请选择--</option>
					<option value="0" <c:if test="${'0' == queryDto.displayPosition }">selected</c:if>>副</option>
					<option value="1" <c:if test="${'1' == queryDto.displayPosition }">selected</c:if>>主</option>
				</select>
			</td>
			<th class="td_right">显示功能：</th>
			<td>
				<select id="isDisplay" name="isDisplay">
					<option value="">--请选择--</option>
					<option value="0" <c:if test="${'0' == queryDto.isDisplay }">selected</c:if>>关</option>
					<option value="1" <c:if test="${'1' == queryDto.isDisplay }">selected</c:if>>开</option>
				</select>
			</td>
		</tr>
		<tr>	
			<th class="td_right">开始时间：</th>
			<td colspan="3">
				从：<input type="text" name="startDateBegin" value="<fmt:formatDate value='${queryDto.startDateBegin}' pattern='yyyy-MM-dd'/>">到：
				<input type="text" name="startDateEnd" value="<fmt:formatDate value='${queryDto.startDateEnd}' pattern='yyyy-MM-dd'/>">
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
				<th>开始日期</th>
				<th>投票天数</th>
				<th>题目内容</th>
				<th>显示位置</th>
				<th>显示功能</th>
				<th nowrap="nowrap">操作</th>
			</tr>
		</thead>
		<c:forEach items="${page.list }" var="u">
			<tr >
			   <td><input type="checkbox" name="ids" value="${u.id }"/></td>
			   <td>&nbsp;${u.id }</td>
			   <td><fmt:formatDate value="${u.startDate}" type="both" pattern="yyyy-MM-dd"/></td>
			   <td>&nbsp;${u.lastDays }</td>
			   <td>&nbsp;${u.titleContent }</td>
			   <td>
			   		<c:choose>
			   			<c:when test="${u.displayPosition == '1' }"><font color="green">主</font></c:when>
			   			<c:when test="${u.displayPosition == '0' }"><font color="blue">副</font></c:when>
			   			<c:otherwise>&nbsp;</c:otherwise>
			   		</c:choose>
			   </td>
			   <td>
			   		<c:choose>
			   			<c:when test="${u.isDisplay == '1' }"><font color="green">开</font></c:when>
			   			<c:when test="${u.isDisplay == '0' }"><font color="red">关</font></c:when>
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
		var _url = "${ctx }/voteTopic/edit";
        var _form = $("#form");
		_form.attr("action",_url);
		_form.submit();
	}
 </script>
</body>
</html>
