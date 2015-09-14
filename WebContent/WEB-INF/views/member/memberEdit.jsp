<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>

<!DOCTYPE html>
<html>
<head>
<%@ include file="../common/common.jsp"%>
<%@ include file="../common/common_html_validator.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/My97DatePicker/WdatePicker.js"></script>
<title>添加用户</title>
<style>
	.td_right{text-align: right;}
	em {font-style: normal;color:red;}
</style>
<script type="text/javascript">
$(function(){
	$("#return_button").bind("click",function(event){
		event.preventDefault();
		window.location.replace("${ctx }/boss/member/list");
	});
	
	$("button[name='postData_button']").bind("click",function(event){
		event.preventDefault();
		$.ajax({
		    type:'POST',
		    url:'${ctx }/boss/memberUser/save',
		    data:$("#form").serialize(),
		    success:function(json){
		    	if(json.success){
	        		alert('保存成功！');
	        		window.location.replace("${ctx }/boss/member/list");
	        	}else{
	        		alert('保存失败！');
	        	} 
		    }
		});
	});
});

</script>
</head>

<body>
	<form action="" namespace="/" theme="simple" id="form" method = "POST">
		<table class="table table-bordered">
			<tr>
				<td colspan="4" style="background-color: #dff0d8;text-align: center;">
					<c:choose>
					  <c:when test="${member.id == null || member.id == '' }">
					    <strong>客户新增</strong>
					  </c:when>
					  <c:otherwise>
					    <strong>客户编辑</strong>
					  </c:otherwise>
					</c:choose>
					
				</td>
			</tr>
			<tr style="display:none;">
				<td><input type="hidden" name="id" value="${member.id }" /></td>
				<td><input type="hidden" name="deleteFlag" value="${member.deleteFlag }" /></td>
				<td><input type="hidden" name="createId" value="${member.createId }" /></td>
				<td><input type="hidden" name="createName" value="${member.createName }" /></td>
				<td><input type="hidden" name="memBankInfo.id" value="${member.memBankInfo.id }" /></td>
			</tr>
			
			<tr>
				<th class="td_right"><em>*</em>账号：</th>
				<td style="text-align: left;">
					<input type="text" name="userName" data-rule="名称:required;userName;length[1~64];" id="userName"  value="${member.userName }"/>
				</td>
				<th class="td_right">账号类别：</th>
				<td style="text-align: left;">
					<select id="accountCategory" name="accountCategory">
						<option value="">--请选择--</option>
					    <option value="0" <c:if test="${'0' == member.accountCategory }">selected="true"</c:if>>全部</option>
					    <option value="1" <c:if test="${'1' == member.accountCategory }">selected="true"</c:if>>客户</option>
					    <option value="2" <c:if test="${'2' == member.accountCategory }">selected="true"</c:if>>老师</option>
					</select>
				</td>				
			</tr>
			
			<tr>
				<th class="td_right">账号类型：</th>
				<td style="text-align: left;">
					<select id="accountType" name="accountType">
						<option value="">--请选择--</option>
					    <option value="0" <c:if test="${'0' == member.accountType }">selected="true"</c:if>>全部</option>
					    <option value="1" <c:if test="${'1' == member.accountType }">selected="true"</c:if>>真实</option>
					    <option value="2" <c:if test="${'2' == member.accountType }">selected="true"</c:if>>测试</option>
					</select>
				</td>			
				<th class="td_right">经纪商：</th>
				<td style="text-align: left;">
					<select id="brokerInfos" name="brokerInfos">
						<option value="">--请选择--</option>
						<c:forEach items="${brokerInfos }" var="r">
						    <option value="${r.id }" 
						    	<c:forEach items="${member.brokerInfos }" var="broker">
						    		<c:if test="${r.id == broker.id }">selected="true"</c:if>
						    	</c:forEach>>
						      ${r.name }
						     </option>
						</c:forEach>						
					</select>
				</td>			
			</tr>
			
			<tr>
				<th class="td_right">中文名称：</th>
				<td style="text-align: left;">
					<input type="text" name="cnName" id="cnName"  value="${member.cnName }"/>
				</td>
				<th class="td_right">英文名称：</th>
				<td style="text-align: left;">
					<input type="text" name="enName" id="enName"  value="${member.enName }"/>
				</td>
			</tr>
			
			<tr>
				<th class="td_right">银行账户：</th>
				<td style="text-align: left;">
					<input type="text" name="memBankInfo.bankAccount" id="bankAccount"  value="${member.memBankInfo.bankAccount }"/>
				</td>
				<th class="td_right">银行账号：</th>
				<td style="text-align: left;">
					<input type="text" name="memBankInfo.bankCardNum" id="bankCardNum"  value="${member.memBankInfo.bankCardNum }"/>
				</td>
			</tr>
			
			<tr>
				<th class="td_right">银行地址：</th>
				<td colspan="3">
					<input type="text" name="memBankInfo.bankAddress" id="bankAddress"  value="${member.memBankInfo.bankAddress }"/>
				</td>				
			</tr>

			<tr>
				<th class="td_right">电话号码：</th>
				<td style="text-align: left;">
					<input type="text" name="telephone" id="telephone"  value="${member.telephone }"/>
				</td>
				<th class="td_right">手机号码：</th>
				<td style="text-align: left;">
					<input type="text" name="cellphone" id="cellphone"  value="${member.cellphone }"/>
				</td>
			</tr>
			
			<tr>
				<th class="td_right">投票权限：</th>
				<td style="text-align: left;">
					<select id="isVoteAuth" name="isVoteAuth">
						<option value="">--请选择--</option>
					    <option value="0" <c:if test="${'0' == member.isVoteAuth }">selected</c:if>>关</option>
					    <option value="1" <c:if test="${'1' == member.isVoteAuth }">selected</c:if>>开</option>
					</select>
				</td>			
				<th class="td_right">评论权限：</th>
				<td style="text-align: left;">
					<select id="isCommentAuth" name="isCommentAuth">
						<option value="">--请选择--</option>
					    <option value="0" <c:if test="${'0' == member.isCommentAuth }">selected</c:if>>关</option>
					    <option value="1" <c:if test="${'1' == member.isCommentAuth }">selected</c:if>>开</option>
					</select>
				</td>			
			</tr>


			<tr>
				<th>开户日期：</th>
				<td>
					<input type="text" name="createAccountDate" id="createAccountDate" onClick="WdatePicker();"
						value="<fmt:formatDate value='${member.createAccountDate}' pattern='yyyy-MM-dd'/>"/>
				</td>			
				<th>Wechat绑定状态：</th>
				<td>
					<select id="isBindWeChat" name="isBindWeChat">
						<option value="">--请选择--</option>
					    <option value="0" <c:if test="${'0' == member.isBindWeChat }">selected</c:if>>全部</option>
					    <option value="1" <c:if test="${'1' == member.isBindWeChat }">selected</c:if>>绑定</option>
					    <option value="2" <c:if test="${'2' == member.isBindWeChat }">selected</c:if>>未绑定</option>
					</select>
				</td>			
			</tr>
			
			<tr>
				<th>状态：</th>
				<td>
					<select id="status" name="status">
						<option value="">--请选择--</option>
					    <option value="0" <c:if test="${'0' == member.status }">selected</c:if>>启用</option>
					    <option value="1" <c:if test="${'1' == member.status }">selected</c:if>>冻结</option>
					    <option value="2" <c:if test="${'2' == member.status }">selected</c:if>>黑名单</option>
					    <option value="3" <c:if test="${'3' == member.status }">selected</c:if>>销户</option>
					</select>
				</td>			
				<th></th>
				<td></td>			
			</tr>
			
			<tr >
				<td colspan="4" style="text-align: center;">
				   <c:choose>
				     <c:when test="${member.id == null || member.id == '' }">
				        <button method="save" class="btn btn-success" name="postData_button">
							<i class="icon-ok icon-white"></i> 新增
						</button>
				     </c:when>
				     <c:otherwise>
				        <button method="save" class="btn btn-success" name="postData_button">
							<i class="icon-ok icon-white"></i> 保存
						</button>
				     </c:otherwise>
				   </c:choose>
					
					<button class="btn btn-inverse" id="return_button">
			   			 <i class="icon-arrow-left icon-white"></i> 返回
					</button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
