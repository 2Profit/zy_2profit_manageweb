<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../common/common.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>虚拟币调整</title>

<link rel="stylesheet" href="${ctx }/static/css/lgl.css"  type="text/css">

<script type="text/javascript">

function myEdit(id){
	window.location.href = '${ctx}/pos/coin/edit?type=add';
}

function myRefresh(){
	window.location.reload();
}

$(function(){
	
	$('select[name="posStatus"]').val('${posStatus}');
	
});

function myPass(){
	var posIds = getPosIds();
	if(posIds.length == 0){
		layer.alert('请选择待审批的提案');
		return;
	}
	
	layer.confirm('确定要提案通过吗？', function(){
		
		$.ajax({
			url : '${ctx}/pos/coin/ajax/pos/pass',
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
			url : '${ctx}/pos/coin/ajax/pos/cancel',
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
	window.location.href = '${ctx}/pos/coin/edit?type=pos&posId=' + posId;
}

</script>

</head>
<body>
<form action="">
	<div class="l_main">
		<div class="l_titlebar">
			<div class="l_text">
				虚拟币调整
			</div>
		</div>
		<div class="">
			<div class="l_toolBar">
				<div class="form-inline">
					<span>
						<label>提案号：</label>
						<input type="text" class="input-small" style="height: auto;" name="proposalNo" value="${proposalNo }"/>
					</span>
					
					<span>
						<label>提案状态：</label>
						<select name="posStatus">
							<option value="">全部</option>
							<c:forEach items="${proposalStatus }" var="ps">
								<option value="${ps.key }">${ps.value }</option>
							</c:forEach>
						</select>
					</span>
					
					<span>
						<label>会员编号：</label>
						<input type="text" class="input-small" style="height: auto;" name="memberNo" value="${memberNo }"/>
					</span>
					
					<span>
						<label>会员手机：</label>
						<input type="text" class="input-small" style="height: auto;" name="mobile" value="${mobile }"/>
					</span>
					<span>
						<label>会员姓名：</label>
						<input type="text" class="input-small" style="height: auto;" name="name" value="${name }"/>
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
						<th>会员编号</th>
						<th>会员手机</th>
						<th>会员姓名</th>
						<th>调整额度</th>
						<th>提案人</th>
						<th>提案时间</th>
						<th>审批人</th>
						<th>审批时间</th>
					</tr>
				</thead>
				<tbody>
					
					<c:forEach items="${page.list }" var="p">
					
						<tr>
							<td><input type="checkbox" name="chk" value="${p.id }" data-pos-status="${p.posStatus }"/></td>
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
							<td data-name="status" data-value="${p.posStatus }">
								<c:choose>
									<c:when test="${p.posStatus eq 0 }">待审核</c:when>
									<c:when test="${p.posStatus eq 1 }">通过</c:when>
									<c:when test="${p.posStatus eq 2 }">拒绝</c:when>
								</c:choose>
							</td>
							<td>${p.member.no }</td>
							<td>${p.member.mobile }</td>
							<td>${p.member.cnName }</td>
							<td>${p.coin }</td>
							<td>${p.applier.realName }</td>
							<td><fmt:formatDate value="${p.createDate }" type="date"/></td>
							<td>${p.approvier.realName }</td>
							<td><fmt:formatDate value="${p.approvierDate }" type="date"/></td>
						</tr>
					
					</c:forEach>
					
					<tr>
						<td colspan="12">
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