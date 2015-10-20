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
			window.location.replace("${ctx }/postUnionReplay/list");
		});
		
		$('#fresh_button').bind("click",function(){
			$("#titleContent").val("");
			$("#mobile").val("");
			$("#postContent").val("");
			$("input[name='createDateFrom']").val("");
			$("input[name='createDateTo']").val("");
		});
		
	});

function updateDelete(topicId,postId,type,deleteFlag){
	
	if(!confirm("是否确认对选择的信息进行操作？")){return false;}
	
	var ids = [];
	ids.push(postId);
	
	$.ajax({
		type: "POST",
       	url:"${ctx }/postUnionReplay/deleteFlag",
    	data:JSON.stringify({'topicId':topicId,'ids':ids,'deleteFlag':deleteFlag,'type':type}),
    	contentType: "application/json",
    	success:function(json) {
       		if(json.success){
       			alert('成功');
       			window.location.replace("${ctx }/postUnionReplay/list");
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
			<td colspan="4" style="background-color: #dff0d8;text-align: center;"><strong>评论回复管理</strong></td>
		</tr>	
		<tr>
			<th class="td_right">投票主题：</th>
			<td>
			  	<input type="text" name="titleContent" id="titleContent" value="${queryDto.titleContent }"/>
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
			<th class="td_right">评论内容：</th>
			<td style="text-align: left;">
			  	<input type="text" name="postContent" id="postContent" value="${queryDto.postContent }"/>
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
				<th>投票主题</th>
				<th>评论内容</th>
				<th>评论时间</th>
				<th>评论人IP</th>
				<th>举报次数</th>
				<th>评论人电话</th>
				<th>评论人姓名</th>
				<th>类型</th>
				<th>数据状态</th>
				<th>操作</th>
			</tr>
		</thead>
		<c:forEach items="${page.list }" var="u">
			<tr>
			   <td><input type="checkbox" name="ids" value="${u.postId }"/></td>
			   <td>&nbsp;${u.titleContent }</td>
			   <td>&nbsp;${u.postContent }</td>
			   <td><fmt:formatDate value='${u.createDate}' pattern='yyyy-MM-dd HH:mm:ss'/></td>
			   <td>&nbsp;${u.ipAddress }</td>
			   <td>&nbsp;${u.reportCount }</td>
			   <td>&nbsp;${u.mobile }</td>
			   <td>&nbsp;${u.cnName }</td>
			   <td>
			   		<c:choose>
			   			<c:when test="${u.type == '1' }"><font color="green">评论跟帖</font></c:when>
			   			<c:when test="${u.type == '2' }"><font color="orange">跟帖回复</font></c:when>
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
			      <c:choose>
			      	<c:when test="${u.deleteFlag == 1}"><a onclick="updateDelete('${u.topicId }','${u.postId}','${u.type}','0')">恢复</a>&nbsp;</c:when>
			      	<c:otherwise><a onclick="updateDelete('${u.topicId }','${u.postId}','${u.type}','1')">删除</a></c:otherwise>
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
