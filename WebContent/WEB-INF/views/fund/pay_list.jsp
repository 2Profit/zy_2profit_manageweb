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

</script>

</head>
<body>
<form action="">
	<div class="l_main">
		<div class="l_titleBar">
			<div class="l_text">
				付款
			</div>
		</div>
		<div class="">
			<div class="l_toolBar">
				<div class="form-inline">
					<span>
						<label>提案号：</label>
						<input type="text" class="input-small" style="height: auto;" name="proposalNo"/>
					</span>
					<span>
						<label>账户货币：</label>
						<select name="curType">
							<option value="">全部</option>
							<option value="0">虚拟币</option>
							<option value="1">真实币</option>
						</select>
					</span>
					
					<span>
						<label>存款途经：</label>
						<select name="payType">
							<option value="">全部</option>
							<option value="0">支付宝</option>
							<option value="1">微信</option>
						</select>
					</span>
					
					<span>
						<label>提案状态：</label>
						<select name="status">
							<option value="">全部</option>
							<option value="0">未处理</option>
							<option value="1">已审批</option>
						</select>
					</span>
				</div>
			</div>
			
			<div class="l_toolbar">
				<button class="btn btn-primary">
					<i class="icon-search icon-white"></i> 查询
				</button>
				<button class="btn btn-info" id="fresh_button">
					<i class="icon-repeat icon-white"></i> 刷新
				</button>				
				<button class="btn btn-success" onclick="myEdit()">
					<i class="icon-plus-sign icon-white"></i> 添加
				</button>
			</div>
		</div>
	
		<div class="l_table mgt20">
			<table class="table table-bordered table-hover">
				<thead>
					<tr>
						<th>
							<input type="checkbox"/>
						</th>
						<th>操作</th>
						<th>提案号</th>
						<th>交易号</th>
						<th>账号</th>
						<th>存款金额</th>
						<th>存款途经</th>
						<th>账户货币</th>
						<th>提案状态</th>
						<th>提案人</th>
						<th>提案时间</th>
						<th>提案IP</th>
						<th>审批人</th>
						<th>最后更新时间</th>
						<th>前台备注</th>
						<th>后台备注</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${page.list }" var="trade">
						<tr>
							<td><input type="checkbox"/></td>
							<td>
								<a class="a_btn">修改</a><a class="a_btn">查看</a>
							</td>
							<td>${trade.proposalNo }</td>
							<td>${trade.tradeId }</td>
							<td>${trade.account }</td>
							<td>${trade.amount }</td>
							<td>
								<c:choose>
									<c:when test="${trade.payType eq 0 }">支付宝</c:when>
									<c:when test="${trade.payType eq 1 }">微信</c:when>
									<c:when test="${trade.payType eq 2 }">银行</c:when>
									<c:when test="${trade.payType eq 3 }">人工添加</c:when>
								</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${trade.curType eq 0 }">虚拟币</c:when>
									<c:when test="${trade.curType eq 1 }">真实币</c:when>
								</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${trade.status eq 0 }">未处理</c:when>
									<c:when test="${trade.status eq 1 }">通过</c:when>
									<c:when test="${trade.status eq 2 }">取消</c:when>
								</c:choose>
							</td>
							<td>${trade.applier.realName }</td>
							<td>
								<fmt:formatDate value="${trade.createDate }" type="date"/>
							</td>
							<td>${trade.ip }</td>
							<td>${trade.approvier.realName }</td>
							<td><fmt:formatDate value="${trade.createDate }" type="date"/></td>
							<td>${trade.frontMsg }</td>
							<td>${trade.bgMsg }</td>
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