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
	//window.location.href = '${ctx}/fund/pay/edit?type=add';
}

function myRefresh(){
	window.location.reload();
}

$(function(){
	
	$('select[name="curType"]').val('${curType}');
	$('select[name="payType"]').val('${payType}');
	$('select[name="status"]').val('${status}');
	
});

function pass(){
	
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
						<input type="text" class="input-small" style="height: auto;" name="proposalNo" value="${ proposalNo}"/>
					</span>
					
					<span>
						<label>提案状态：</label>
						<select name="status">
							<option value="">全部</option>
							<c:forEach items="${proposalStatus }" var="ps">
								<option value="${ps.key }">${ps.value }</option>
							</c:forEach>
						</select>
					</span>
					<span>
						<label>会员手机：</label>
						<input type="text" class="input-small" style="height: auto;" name="mobile" value=""/>
					</span>
					<span>
						<label>会员姓名：</label>
						<input type="text" class="input-small" style="height: auto;" name="name" value=""/>
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
				<a class="btn btn-success" href="javascript:void(0);">提案通过</a>
				<a class="btn btn-danger" href="javascript:void(0);">提案拒绝</a>
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
						<th>会员编号</th>
						<th>会员手机</th>
						<th>会员姓名</th>
						<th>调整额度</th>
						<th>账户货币</th>
						<th>提案状态</th>
						<th>提案人</th>
						<th>提案时间</th>
						<th>提案IP</th>
						<th>审批人</th>
						<th>备注</th>
					</tr>
				</thead>
				<tbody>
					
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