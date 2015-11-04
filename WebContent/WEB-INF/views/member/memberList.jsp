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

<link rel="stylesheet" href="${ctx }/static/css/lgl.css"  type="text/css">

<script type="text/javascript">
$(function(){
	
	$('select[name="accountType"]').val('${accountType}');
	$('select[name="accountCategory"]').val('${accountCategory}');
	$('select[name="status"]').val('${status}');
	
});

function myAdd(){
	window.location.href = '${ctx}/member/edit?type=add';
}

function myUpdate(memberId){
	window.location.href = '${ctx}/member/edit?type=update&memberId=' + memberId;
}

function myRefresh(){
	window.location.reload();
}

</script>
</head>

<body>

<form action="">
	<div class="l_main">
		<div class="l_titlebar">
			<div class="l_text">
				会员管理
			</div>
		</div>
		<div class="">
			<div class="l_toolBar">
				<div class="form-inline">
					<span>
						<label>账号类型：</label>
						<select name="accountType">
							<option value="">全部</option>
							<option value="0">真实</option>
							<option value="1">测试</option>
						</select>
					</span>
					<span>
						<label>账号类别：</label>
						<select name="accountCategory">
							<option value="">全部</option>
							<option value="0">客户</option>
							<option value="1">老师</option>
						</select>
					</span>
					<span>
						<label>会员编号：</label>
						<input type="text" name="mNo" value="${mNo }" class="wd100"/>
					</span>
					<span>
						<label>中文名称：</label>
						<input type="text" name="cnName" value="${cnName }" class="wd100"/>
					</span>
					<%-- <span>
						<label>英文名称：</label>
						<input type="text" name="enName" value="${enName }" class="wd100"/>
					</span> --%>
					<span>
						<label>电话号码：</label>
						<input type="text" name="mobile" value="${mobile }" class="wd100"/>
					</span>
					<span>
						<label>状态：</label>
						<select name="status">
							<option value="">全部</option>
							<option value="0">启用</option>
						    <option value="1">冻结</option>
						    <option value="2">黑名单</option>
						    <option value="3">销户</option>
						</select>
					</span>
					
				</div>
			</div>
			
			<div class="l_toolbar">
				<button class="btn btn-primary" method="list">
					<i class="icon-search icon-white"></i> 查询
				</button>
				<a class="btn btn-info" id="fresh_button" onclick="myRefresh()">
					<i class="icon-repeat icon-white"></i> 刷新
				</a>
				<a class="btn btn-success" href="javascript:void(0);" onclick="myAdd()">
					<i class="icon-plus-sign icon-white"></i> 添加
				</a>
			</div>
		</div>
	
		<div class="l_table mgt20">
			<table class="table table-bordered table-hover">
				<thead>
					<tr>
						<!-- <th>
							<input type="checkbox" name="checkAll" onclick="checkAllClick(this, 'chk')"/>
						</th> -->
						<th>操作</th>
						<th>会员编号</th>
						<th>账号类别</th>
						<th>账号类型</th>
						<th>手机号码</th>
						<th>邮箱</th>
						<th>中文名称</th>
						<th>昵称</th>
						<th>银行名称</th>
						<th>银行账号</th>
						<th>身份证明</th>
						<th>银行证明</th>
						<th>注册日期</th>
						<th>状态</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${page.list }" var="m">
						<tr>
							<td>
								<a class="a_btn" href="javascript:void(0);" onclick="myUpdate('${m.id}')">修改</a>
							</td>
							<td>${m.no }</td>
							<td>
								<c:choose>
									<c:when test="${m.accountCategory eq 0 }">
										客户
									</c:when>
									<c:when test="${m.accountCategory eq 1 }">
										老师
									</c:when>
								</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${m.accountType eq 0 }">
										真实
									</c:when>
									<c:when test="${m.accountType eq 1 }">
										测试
									</c:when>
								</c:choose>
							</td>
							<td>${m.mobile }</td>
							<td>${m.email }</td>
							<td>${m.cnName }</td>
							<td>${m.nickName }</td>
							<td>${m.memBankInfo.bankAccount }</td>
							<td>${m.memBankInfo.bankCardNum }</td>
							<td>
								<c:choose>
									<c:when test="${empty m.imgIDCardStatus or m.imgIDCardStatus eq 0 }">
										未上传
									</c:when>
									<c:when test="${m.imgIDCardStatus eq 1 }">
										待审核
									</c:when>
									<c:when test="${m.imgIDCardStatus eq 2 }">
										有效
									</c:when>
									<c:when test="${m.imgIDCardStatus eq 3 }">
										审批未通过
									</c:when>
								</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${empty m.imgBackCardStatus or m.imgBackCardStatus eq 0 }">
										未上传
									</c:when>
									<c:when test="${m.imgBackCardStatus eq 1 }">
										待审核
									</c:when>
									<c:when test="${m.imgBackCardStatus eq 2 }">
										有效
									</c:when>
									<c:when test="${m.imgBackCardStatus eq 3 }">
										审批未通过
									</c:when>
								</c:choose>
							</td>
							<td> <fmt:formatDate value="${m.createAccountDate }"/> </td>
							<td>
								<c:choose>
									<c:when test="${m.status eq '0' }">
										启用
									</c:when>
									<c:when test="${m.status eq '1' }">
										冻结
									</c:when>
									<c:when test="${m.status eq '2' }">
										黑名单
									</c:when>
									<c:when test="${m.status eq '3' }">
										销户
									</c:when>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
					
					<tr>
						<td colspan="16">
							<%@ include file="../common/pager.jsp"%>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		
	</div>
</form>


</body>
</html>
