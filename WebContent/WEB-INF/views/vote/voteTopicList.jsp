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
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/My97DatePicker/WdatePicker.js"></script>
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
	});

function updateDeleteFlag(ids,deleteFlag){
	$.ajax({
		type: "POST",
       	url:"${ctx }/voteTopic/deleteFlag",
    	data:JSON.stringify({'ids':ids,'deleteFlag':deleteFlag}),
    	contentType: "application/json",
    	success:function(json) {
       		if(json.success){
       			alert('成功');
       			window.location.replace("${ctx }/voteTopic/list");
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
			<th class="td_right">投票题目：</th>
			<td>
				<input type="text" name="titleContent" value="${queryDto.titleContent }">
			</td>
			<th class="td_right">显示模式：</th>
			<td>
				<select id="displayType" name="displayType">
					<option value="">--请选择--</option>
					<option value="0" <c:if test="${'0' == queryDto.displayType }">selected</c:if>>百分比</option>
					<option value="1" <c:if test="${'1' == queryDto.displayType }">selected</c:if>>实数</option>
				</select>
			</td>			
		</tr>
		<tr>
			<th class="td_right">显示位置：</th>
			<td>
				<select id="displayPosition" name="displayPosition">
					<option value="">--请选择--</option>
					<option value="0" <c:if test="${'0' == queryDto.displayPosition }">selected</c:if>>用户中心</option>
					<option value="1" <c:if test="${'1' == queryDto.displayPosition }">selected</c:if>>网页</option>
					<option value="2" <c:if test="${'2' == queryDto.displayPosition }">selected</c:if>>用户中心+网页</option>
				</select>
			</td>
			<th class="td_right">评论功能：</th>
			<td>
				<select id="isComment" name="isComment">
					<option value="">--请选择--</option>
					<option value="0" <c:if test="${'0' == queryDto.isComment }">selected</c:if>>关闭</option>
					<option value="1" <c:if test="${'1' == queryDto.isComment }">selected</c:if>>开启</option>
				</select>
			</td>
		</tr>
		<tr>	
			<th class="td_right">开始时间：</th>
			<td colspan="3">
				从：<input type="text" name="startDateBegin" value="<fmt:formatDate value='${queryDto.startDateBegin}' pattern='yyyy-MM-dd HH:mm:ss'/>"
						onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">到：
				<input type="text" name="startDateEnd" value="<fmt:formatDate value='${queryDto.startDateEnd}' pattern='yyyy-MM-dd HH:mm:ss'/>"
						onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
			</td>
		</tr>
		<tr>	
			<th class="td_right">结束时间：</th>
			<td colspan="3">
				从：<input type="text" name="toDateBegin" value="<fmt:formatDate value='${queryDto.toDateBegin}' pattern='yyyy-MM-dd HH:mm:ss'/>"
						onClick='WdatePicker();'/>到：
				<input type="text" name="toDateEnd" value="<fmt:formatDate value='${queryDto.toDateEnd}' pattern='yyyy-MM-dd HH:mm:ss'/>"
						onClick='WdatePicker();'/>
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
				<th>题目内容</th>
				<th>显示位置</th>
				<th>显示模式</th>
				<th>评论功能</th>
				<th>开始日期</th>
				<th>结束日期</th>
				<th>发布者</th>
				<th>提案状态</th>
				<th>数据状态</th>
				<th nowrap="nowrap">操作</th>
			</tr>
		</thead>
		<c:forEach items="${page.list }" var="u">
			<tr >
			   <td><input type="checkbox" name="ids" value="${u.id }"/></td>
			   <td>&nbsp;${u.titleContent }</td>
			   <td>
			   		<c:choose>
			   			<c:when test="${u.displayPosition == '0' }">用户中心</c:when>
			   			<c:when test="${u.displayPosition == '1' }">网页</c:when>
			   			<c:when test="${u.displayPosition == '2' }">用户中心+网页</c:when>
			   			<c:otherwise>&nbsp;</c:otherwise>
			   		</c:choose>
			   </td>
			   <td>
			   		<c:choose>
			   			<c:when test="${u.displayType == '0' }">百分比</c:when>
			   			<c:when test="${u.displayType == '1' }">实数</c:when>
			   			<c:otherwise>&nbsp;</c:otherwise>
			   		</c:choose>
			   </td>
			   <td>
			   		<c:choose>
			   			<c:when test="${u.isComment}"><font color="green">开启</font></c:when>
			   			<c:when test="${u.isComment == false}"><font color="red">关闭</font></c:when>
			   			<c:otherwise>&nbsp;</c:otherwise>
			   		</c:choose>
			   </td>			   
			   <td><fmt:formatDate value="${u.startDate}" type="both" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			   <td><fmt:formatDate value="${u.endDate}" type="both" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			   <td>&nbsp;${u.createName }</td>
			   <td>
			   		<c:choose>
			   			<c:when test="${u.deleteFlag == '1' }"><font color="red">删除</font></c:when>
			   			<c:when test="${u.deleteFlag == '0' }"><font color="green">初始</font></c:when>
			   			<c:otherwise>&nbsp;</c:otherwise>
			   		</c:choose>
			   </td>
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
		var _url = "${ctx }/voteTopic/edit";
        var _form = $("#form");
		_form.attr("action",_url);
		_form.submit();
	}
 </script>
</body>
</html>
