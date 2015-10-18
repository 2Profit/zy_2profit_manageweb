<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../common/common.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>支付交易记录</title>

<script type="text/javascript" src="${ctx }/static/js/My97DatePicker/WdatePicker.js"></script>

<link rel="stylesheet" href="${ctx }/static/css/lgl.css"  type="text/css">

</head>
<body>
<form action="">
	<div class="l_main">
		<div class="l_titlebar">
			<div class="l_text">
				支付交易记录
			</div>
		</div>
	
		<div class="">
			<div class="l_toolBar">
				<div class="form-inline">
					<span>
						<label>订单号：</label>
						<input type="text" class="wd100" style="height: auto;" name="orderId" value="${orderId }"/>
					</span>
					
					<span>
						<label>会员编号：</label>
						<input type="text" class="input-small" style="height: auto;" name="memberNo" value="${memberNo }"/>
					</span>
					
					<span>
						<label>会员手机：</label>
						<input type="text" class="wd100" style="height: auto;" name="mobile" value="${mobile }"/>
					</span>
					<span>
						<label>会员姓名：</label>
						<input type="text" class="wd100" style="height: auto;" name="name" value="${name }"/>
					</span>
					
					<span>
						<label>时间：</label>
						<input type="text" class="wd100 Wdate" style="height: auto;" name="startDate" value='<fmt:formatDate value="${startDate }"/>' onclick="WdatePicker()"/>
						<label>至</label>
						<input type="text" class="wd100 Wdate" style="height: auto;" name="endDate" value='<fmt:formatDate value="${endDate }"/>' onclick="WdatePicker()"/>
					</span>
					
				</div>
			</div>
			
			<div class="l_toolbar">
				<button class="btn btn-primary" method="list">
					<i class="icon-search icon-white"></i> 查询
				</button>
			</div>
			
		</div>
		
		<div class="l_table mgt20">
			<table class="table table-bordered table-hover">
				<thead>
					<tr>
						<th>
							<input type="checkbox" name="checkAll" onclick="checkAllClick(this, 'chk')"/>
						</th>
						<!-- <th>操作</th> -->
						<th>订单号</th>
						<th>会员编号</th>
						<th>会员手机</th>
						<th>会员名称</th>
						<th>金额</th>
						<th>订单状态</th>
						<th>支付渠道</th>
						<th>操作时间</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${page.list }" var="order">
						<tr>
							<td><input type="checkbox" name="chk" value="${trade.id }"/></td>
							<%-- <td>${order.id }</td> --%>
							<td>${order.orderId }</td>
							<td>${order.member.no }</td>
							<td>${order.member.mobile }</td>
							<td>${order.member.cnName }</td>
							<td>${order.amount }</td>
							<td>
								<c:choose>
									<c:when test="${order.status eq 0 }">未支付</c:when>
									<c:when test="${order.status eq 1 }">支付成功</c:when>
								</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${order.payType eq 0 }">支付宝</c:when>
									<c:when test="${order.payType eq 1 }">微信</c:when>
								</c:choose>
							</td>
							<td><fmt:formatDate value="${order.createDate }" type="date"/></td>
						</tr>
					</c:forEach>
					<tr>
						<td colspan="8">
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