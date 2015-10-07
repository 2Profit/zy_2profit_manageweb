<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page session="false" %>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>客户列表</title>
<%@ include file="../common/common.jsp"%>
<script type="text/javascript" src="${ctx }/static/js/manage-web-common.js"/></script>
<script type="text/javascript">
$(function(){
	$('#fresh_button').bind("click",function(){
		$("input[name='exchangeNo']").val("");
		$("input[name='name']").val("");
		$("#companyArea").val("");
		$("#companyType").val("");
		$("#deleteFlag").val("");
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
			<th>账号类型：</th>
			<td><input type="text" name="userName" value="${queryDto.userName }"></td>		
			<th>账户类别：</th>
			<td>
				<select id="accountCategory" name="accountCategory">
					<option value="">--请选择--</option>
					<option value="0" <c:if test="${'0' == queryDto.accountCategory }">selected</c:if>>全部</option>
					<option value="1" <c:if test="${'1' == queryDto.accountCategory }">selected</c:if>>客户</option>
					<option value="2" <c:if test="${'2' == queryDto.accountCategory }">selected</c:if>>老师</option>
				</select>
			</td>
			<th></th>
			<td></td>
		</tr>
		<tr>
			<th>中文名称：</th>
			<td><input type="text" name="cnName" value="${queryDto.cnName }"></td>
			<th>英文名称：</th>
			<td><input type="text" name="enName" value="${queryDto.enName }"></td>		
			<th>电话号码：</th>
			<td><input type="text" name="mobile" value="${queryDto.mobile }"></td>
			<th>手机号码：</th>
			<td><input type="text" name="telephone" value="${queryDto.telephone }"></td>		
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
				<th width="10"><input type="checkbox" id="firstCheckbox"/></th>
				<th>账号</th>
				<th>账号类别</th>
				<th>账号类型</th>
				<th>经纪商</th>
				<th>中文名称</th>
				<th>英文名称</th>
				<th>银行账户</th>
				<th>银行账号</th>
				<th>银行地址</th>
				<th>手机号码</th>
				<th>开户日期</th>
				<th>weChat绑定状态</th>
				<th>投票权限</th>
				<th>评论权限</th>
				<th>状态</th>
				<th nowrap="nowrap">操作</th>
			</tr>
		</thead>
		<c:forEach items="${page.list }" var="u">
			<tr>
				<td><input type="checkbox" name="ids" value="${u.id }"/></td>			
			   <td>&nbsp;${u.userName }</td>
			   <td>
					<c:choose>
			   			<c:when test="${u.accountCategory == '0' }">客户</c:when>
			   			<c:when test="${u.accountCategory == '1' }">老师</c:when>
			   		</c:choose>			   
			   </td>
			   <td>
					<c:choose>
			   			<c:when test="${u.accountType == '0' }">真实</c:when>
			   			<c:when test="${u.accountType == '1' }">测试</c:when>
			   		</c:choose>			   
			   </td>
			   <td>
		   			<c:choose>
				   		<c:when test="${s.brokerInfos!=null}">
							<c:forEach items="${s.brokerInfos }" var="brokerInfo" varStatus="status">
								<c:set var="brokerNames" value="${userNames}${status.first ? '' : ','}${brokerInfo.cnName}"/>
							</c:forEach>
				   		</c:when>
				   		<c:otherwise>&nbsp;
				   			<c:set var="brokerNames" value=""/>
				   		</c:otherwise>
			   		</c:choose>${brokerNames }
			   		<c:set var="brokerNames" value=""/>
			   </td>
			   <td>&nbsp;${u.cnName }</td>
			   <td>&nbsp;${u.enName }</td>
			   <td>&nbsp;${u.memBankInfo.bankAccount }</td>
			   <td>&nbsp;${u.memBankInfo.bankCardNum }</td>
			   <td>&nbsp;${u.memBankInfo.bankAddress }</td>
			   <td>&nbsp;${u.mobile }</td>
			   <%-- <td>&nbsp;${u.telephone }</td>
			   <td>&nbsp;${u.cellphone }</td> --%>
			   <td>&nbsp;${u.createAccountDate }</td>
				<td>
					<c:choose>
			   			<c:when test="${u.isBindWeChat == '1' }">已绑定</c:when>
			   			<c:when test="${u.isBindWeChat == '0' }">未绑定</c:when>
			   			<c:otherwise>&nbsp;</c:otherwise>
			   		</c:choose>			   
			    </td>
				<td>
					<c:choose>
			   			<c:when test="${u.isVoteAuth == '0' }">关</c:when>
			   			<c:when test="${u.isVoteAuth == '1' }">开</c:when>
			   			<c:otherwise>&nbsp;</c:otherwise>
			   		</c:choose>			   
			   </td>
				<td>
					<c:choose>
			   			<c:when test="${u.isCommentAuth == '0' }">关</c:when>
			   			<c:when test="${u.isCommentAuth == '1' }">开</c:when>
			   			<c:otherwise>&nbsp;</c:otherwise>
			   		</c:choose>			   
			   </td>
				<td>
					<c:choose>
			   			<c:when test="${u.status == '0' }">启用</c:when>
			   			<c:when test="${u.status == '1' }">冻结</c:when>
			   			<c:when test="${u.status == '2' }">黑名单</c:when>
			   			<c:when test="${u.status == '3' }">销户</c:when>
			   			<c:otherwise>&nbsp;</c:otherwise>
			   		</c:choose>			   
			   </td>
				<td>
			      <a href="${ctx }/member/edit?id=${u.id}">编辑</a>
			      <c:choose>
			      	<c:when test="${u.deleteFlag == 1}"><a name="revert_href"><input type="hidden" value="${u.id}"/>恢复</a>&nbsp;</c:when>
			      	<c:otherwise><a name="delete_href"><input type="hidden" value="${u.id}"/>删除</a></c:otherwise>
			      </c:choose>
			   </td>			   
		    </tr>
		</c:forEach>
		<tr>
			<td width="50"><input type="checkbox" id="checkAll"/></td>
			<td colspan="50">
				<button id="delete_button" class="btn btn-danger"><i class="icon-remove icon-white"></i>删除</button>&nbsp;
				<button id="revert_button" class="btn btn-warning"><i class="icon-repeat icon-white"></i>恢复</button>
			</td>
		</tr>		
		<tr><td colspan="50" style="text-align:center;"><%@ include file="../common/pager.jsp"%></td>
		</tr>
	</table>
</form>
 <script type="text/javascript">
	function toAdd(){
		var _url = "${ctx }/member/edit";
        var _form = $("#form");
		_form.attr("action",_url);
		_form.submit();
	}
 </script>
</body>
</html>
