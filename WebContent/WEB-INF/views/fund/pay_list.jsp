<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../common/common.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>付款</title>

<link rel="stylesheet" href="${ctx }/static/css/lgl.css"  type="text/css">

<script type="text/javascript">

function myEdit(id){
	window.location.href = '${ctx}/fund/pay/edit?type=add';
}

function myRefresh(){
	window.location.reload();
}

$(function(){
	
	$('select[name="curType"]').val('${curType}');
	$('select[name="payType"]').val('${payType}');
	$('select[name="status"]').val('${status}');
	
});

function myPass(){
	var posIds = getPosIds();
	if(posIds.length == 0){
		layer.alert('请选择待审批的提案');
		return;
	}
	
	layer.confirm('确定要提案通过吗？', function(){
		
		$.ajax({
			url : '${ctx}/fund/ajax/pay/pos/pass',
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
			url : '${ctx}/fund/ajax/pay/pos/cancel',
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
	$('input[name="chk"][data-pos-status="0"]:checked').each(function(idx, obj){
		chkVals.push($(obj).val());
	});
	return chkVals;
}

function myPos(posId){
	window.location.href = '${ctx}/fund/pay/edit?type=pos&posId=' + posId;
}

</script>

</head>
<body>
<form action="">
	<div class="l_main">
		<div class="l_titlebar">
			<div class="l_text">
				虚拟币充值
			</div>
		</div>
		<div class="">
			<div class="l_toolBar">
				<div class="form-inline">
					<span>
						<label>提案号：</label>
						<input type="text" class="input-small" style="height: auto;" name="proposalNo" value="${ proposalNo}"/>
					</span>
					<span>
						<label>存款途经：</label>
						<select name="payType">
							<option value="">全部</option>
							<option value="3">人工添加</option>
							<option value="0">支付宝</option>
							<option value="1">微信</option>
							<option value="2">银行</option>
						</select>
					</span>
					
					<span>
						<label>提案状态：</label>
						<select name="status">
							<option value="">全部</option>
							<c:forEach items="${proposalStatuses }" var="ps">
								<option value="${ps.key }">${ps.value }</option>
							</c:forEach>
						</select>
					</span>
					
					<span>
						<label>会员编号：</label>
						<input type="text" class="input-small" style="height: auto;" name="memberNo" value="${memberNo }"/>
					</span>
					
					<span>
						<label>手机号码：</label>
						<input type="text" class="input-small" style="height: auto;" name="mobile" value="${mobile }"/>
					</span>
					
					<span>
						<label>姓名：</label>
						<input type="text" class="input-small" style="height: auto;" name="cnName" value="${cnName }"/>
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
				<a class="btn btn-success" href="javascript:void(0);" onclick="myEdit()">
					<i class="icon-plus-sign icon-white"></i> 添加
				</a>
				<c:if test="${isApprovier }">
					<a class="btn btn-success" href="javascript:myPass();">提案通过</a>
					<a class="btn btn-danger" href="javascript:myCancel();">提案拒绝</a>
				</c:if>
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
						<th>提案号</th>
						<th>提案状态</th>
						<th>订单号</th>
						<th>会员编号</th>
						<th>手机号码</th>
						<th>会员姓名</th>
						<th>充值金额</th>
						<th>存款途经</th>
						<th>提案人</th>
						<th>提案时间</th>
						<th>审批人</th>
						<th>审批时间</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${page.list }" var="trade">
						<tr>
							<td><input type="checkbox" name="chk" value="${trade.id }" data-pos-status="${trade.status }"/></td>
							<td>
								<%-- <c:if test="${trade.status eq 0 }">
									<a class="a_btn" href="${ctx }/fund/pay/edit?type=update&id=${trade.id}">修改</a>
								</c:if>
								<a class="a_btn" href="${ctx }/fund/pay/edit?type=view&id=${trade.id}">查看</a> --%>
								<c:choose>
									<c:when test="${trade.status eq 0 }">
										<a class="a_btn" href="javascript:void(0);" onclick="myPos('${trade.id}')">审批</a>
									</c:when>
									<c:otherwise>
										<a class="a_btn gray" href="javascript:void(0);" title="已经审批" style="color: gray;">审批</a>
									</c:otherwise>
								</c:choose>
							</td>
							<td>${trade.proposalNo }</td>
							
							<td data-name="status" data-value="${trade.status }">
								<c:choose>
									<c:when test="${trade.status eq 0 }">待审核</c:when>
									<c:when test="${trade.status eq 1 }">通过</c:when>
									<c:when test="${trade.status eq 2 }">拒绝</c:when>
								</c:choose>
							</td>
							
							<td>${trade.tradeId }</td>
							<td>${trade.member.no }</td>
							<td>${trade.member.mobile }</td>
							<td>${trade.member.cnName }</td>
							<td>${trade.amount }</td>
							<td>
								<c:choose>
									<c:when test="${trade.payType eq 0 }">支付宝</c:when>
									<c:when test="${trade.payType eq 1 }">微信</c:when>
									<c:when test="${trade.payType eq 2 }">银行</c:when>
									<c:when test="${trade.payType eq 3 }">人工添加</c:when>
								</c:choose>
							</td>
							
							<td>${trade.applier.realName }</td>
							<td>
								<fmt:formatDate value="${trade.createDate }" type="date"/>
							</td>
							<td>${trade.approvier.realName }</td>
							<td><fmt:formatDate value="${trade.approveDate }" type="date"/></td>
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