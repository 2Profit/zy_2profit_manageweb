<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>会员证明审核</title>
<%@ include file="../common/common.jsp"%>

<script type="text/javascript" src="${ctx }/static/js/manage-web-common.js"/></script>

<link rel="stylesheet" href="${ctx }/static/css/lgl.css"  type="text/css">

<script type="text/javascript">
$(function(){
	
	$('select[name="posStatus"]').val('${posStatus}');
	
});

function myPos(posId){
	window.location.href = '${ctx}/mem/pos/img/edit?type=pos&posId=' + posId;
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
			url : '${ctx}/mem/pos/ajax/img/pass',
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
			url : '${ctx}/mem/pos/ajax/img/cancel',
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

</script>
</head>

<body style="overflow:auto;">

<form action="">
	<div class="l_main">
		<div class="l_titlebar">
			<div class="l_text">
				会员证明提案
			</div>
		</div>
		<div class="">
			<div class="l_toolBar">
				<div class="form-inline">
					
					<span>
						<label>提案号：</label>
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
						<label>姓名：</label>
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
				<c:if test="${isApprovier }">
					<a class="btn btn-success" href="javascript:void(0);" onclick="myPass()">提案通过</a>
					<a class="btn btn-danger" href="javascript:void(0);" onclick="myCancel()">提案拒绝</a>
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
						<th class="wd50">操作</th>
						<th class="wd50">提案号</th>
						<th class="wd100">提案时间</th>
						<th class="wd100">类型</th>
						<th class="wd100">状态</th>
						<th class="wd100">会员<br>编号</th>
						<th class="wd100">手机号码</th>
						<th class="wd100">昵称</th>
						<th class="wd100">姓名</th>
						<th class="wd100">证件类型</th>
						<th class="wd100">证件号</th>
						<th class="wd100">银行<br>账户</th>
						<th class="wd100">银行<br>账号</th>
						<th class="wd100">账户持有人姓名</th>
						<th class="wd100">审批人</th>
						<th class="wd100">审批时间</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${page.list }" var="p">
						<tr>
							<td>
								<input type="checkbox" name="chk" value="${p.id }" data-pos-status="${p.posStatus }"/>
							</td>
							<td>
								<c:choose>
									<c:when test="${p.posStatus eq 0 }">
										<a class="a_btn" href="javascript:void(0);" onclick="myPos('${p.id}')">审批</a>
									</c:when>
									<c:otherwise>
										<a class="a_btn gray" href="javascript:void(0);" title="已经审批" style="color: gray;">审批</a>
									</c:otherwise>
								</c:choose>
							</td>
							<td>${p.proposalNo }</td>
							<td><fmt:formatDate value="${p.createDate }"/></td>
							<td>
								<c:choose>
									<c:when test="${p.type eq 0 }">
										身份证明
									</c:when>
									<c:when test="${p.type eq 1 }">
										银行证明
									</c:when>
								</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${p.posStatus eq 0 }">
										待审批
									</c:when>
									<c:when test="${p.posStatus eq 1 }">
										通过
									</c:when>
									<c:when test="${p.posStatus eq 2 }">
										拒绝
									</c:when>
								</c:choose>
							</td>
							<td>${p.member.no }</td>
							<td>${p.member.mobile }</td>
							<td>${p.member.nickName }</td>
							<td>${p.member.cnName }</td>
							<td>
								<c:choose>
									<c:when test="${p.member.cardType eq 0 }">
										中国居民身份证
									</c:when>
									<c:when test="${p.member.cardType eq 1 }">
										护照
									</c:when>
								</c:choose>
							</td>
							<td>${p.member.card }</td>
							<td>${p.member.memBankInfo.bankAccount }</td>
							<td>${p.member.memBankInfo.bankCardNum }</td>
							<td>${p.member.memBankInfo.bankAddress }</td>
							<td>${p.approvier.realName }</td>
							<td><fmt:formatDate value="${p.approveDate }" type="date"/> </td>
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
