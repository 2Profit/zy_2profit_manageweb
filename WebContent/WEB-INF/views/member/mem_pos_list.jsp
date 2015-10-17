<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page session="false" %>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>提案列表</title>
<%@ include file="../common/common.jsp"%>

<script type="text/javascript" src="${ctx }/static/js/manage-web-common.js"/></script>

<link rel="stylesheet" href="${ctx }/static/css/lgl.css"  type="text/css">

<script type="text/javascript">
$(function(){
	
	$('select[name="posStatus"]').val('${posStatus}');
	
});

function myAdd(){
	window.location.href = '${ctx}/member/edit?type=add';
}

function myPos(posId){
	window.location.href = '${ctx}/member/edit?type=pos&posId=' + posId;
}

function myRefresh(){
	window.location.reload();
}

function myPass(){
	var posIds = getPosIds();
	if(posIds.length == 0){
		layer.alert('请选择待审批的提案');
		return;
	}
	
	layer.confirm('确定要提案通过吗？', function(){
		
		$.ajax({
			url : '${ctx}/mem/pos/ajax/pass',
			async : false,
			traditional : true,
			data : {
				posIds : posIds
			},
			success : function(result){
				if(result.success){
					layer.alert('操作成功', function(){
						window.location.reload();
					});
				}else{
					layer.alert(result.msg);
				}
			}
		});
		
	}, function(){
		
	});
	
}

function myCancel(){
	var posIds = getPosIds();
	if(posIds.length == 0){
		layer.alert('请选择待审批的提案');
		return;
	}
	
	layer.confirm('确定要提案拒绝吗？', function(){
		
		$.ajax({
			url : '${ctx}/mem/pos/ajax/cancel',
			async : false,
			traditional : true,
			data : {
				posIds : posIds
			},
			success : function(result){
				if(result.success){
					layer.alert('操作成功', function(){
						window.location.reload();
					});
				}else{
					layer.alert(result.msg);
				}
			}
		});
		
	}, function(){
		
	});
	
}

function getPosIds(){
	var chkVals = new Array();
	$('input[name="chk"][data-pos-status]:checked').each(function(idx, obj){
		chkVals.push($(obj).val());
	});
	return chkVals;
}

</script>
</head>

<body>

<form action="">
	<div class="l_main">
		<div class="l_titlebar">
			<div class="l_text">
				会员提案
			</div>
		</div>
		<div class="">
			<div class="l_toolBar">
				<div class="form-inline">
					
					<span>
						<label>提案编号：</label>
						<input type="text" name="proposalNo" value="${proposalNo }" class="wd100"/>
					</span>
					
					<span>
						<label>会员编号：</label>
						<input type="text" name="no" value="${no }" class="wd100"/>
					</span>
					
					<span>
						<label>提案状态：</label>
						<select name="posStatus">
							<option value="">全部</option>
							<c:forEach items="${posStatuses }" var="ps">
								<option value="${ps.key }">${ps.value }</option>
							</c:forEach>
						</select>
					</span>
					<span>
						<label>中文名称：</label>
						<input type="text" name="cnName" value="${cnName }" class="wd100"/>
					</span>
					<span>
						<label>电话号码：</label>
						<input type="text" name="mobile" value="${mobile }" class="wd100"/>
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
				
				<a class="btn btn-success" href="javascript:void(0);" onclick="myPass()">提案通过</a>
				<a class="btn btn-danger" href="javascript:void(0);" onclick="myCancel()">提案拒绝</a>
				
			</div>
		</div>
	
		<div class="l_table mgt20">
			<table class="table table-bordered table-hover">
				<thead>
					<tr>
						<th>
							<input type="checkbox" name="checkAll" onclick="checkAllClick(this, 'chk')"/>
						</th>
						<th>操作</th>
						<th>编号</th>
						<th>提案时间</th>
						<th>类型</th>
						<th>状态</th>
						<th>会员<br>编号</th>
						<th>账号<br>类别</th>
						<th>账号类型</th>
						<th>手机号码</th>
						<th>邮箱</th>
						<th>中文<br>名称</th>
						<th>英文<br>名称</th>
						<th>银行<br>账户</th>
						<th>银行<br>账号</th>
						<th>身份<br>证明</th>
						<th>银行<br>证明</th>
						<th>会员<br>状态</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${page.list }" var="m">
						<tr>
							<td>
								<input type="checkbox" name="chk" value="${m.id }" data-pos-status="${m.posStatus }"/>
							</td>
							<td>
								<c:choose>
									<c:when test="${m.posStatus eq 0 }">
										<a class="a_btn" href="javascript:void(0);" onclick="myPos('${m.id}')">审批</a>
									</c:when>
									<c:otherwise>
										<a class="a_btn gray" href="javascript:void(0);" title="已经审批" style="color: gray;">审批</a>
									</c:otherwise>
								</c:choose>
							</td>
							<td>${m.proposalNo }</td>
							<td><fmt:formatDate value="${m.createDate }"/></td>
							<td>${m.posType }</td>
							<td>
								<c:choose>
									<c:when test="${m.posStatus eq 0 }">
										待审批
									</c:when>
									<c:when test="${m.posStatus eq 1 }">
										通过
									</c:when>
									<c:when test="${m.posStatus eq 2 }">
										拒绝
									</c:when>
								</c:choose>
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
							<td>${m.enName }</td>
							<td>${m.bankAccount }</td>
							<td>${m.bankCardNum }</td>
							<td>
								<c:choose>
									<c:when test="${not empty m.imgIDCardA }">
										已上传
									</c:when>
									<c:otherwise>
										未上传
									</c:otherwise>
								</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${not empty m.imgBankCard }">
										已上传
									</c:when>
									<c:otherwise>
										未上传
									</c:otherwise>
								</c:choose>
							</td>
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
						<td colspan="18">
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
