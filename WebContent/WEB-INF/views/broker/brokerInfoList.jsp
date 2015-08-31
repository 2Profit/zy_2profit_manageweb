<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page session="false" %>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>经纪商列表</title>
<%@ include file="../common/common.jsp"%>
<script type="text/javascript">
$(function(){
	$('#fresh_button').bind("click",function(){
		$("input[name='serialNumber']").val("");
		$("input[name='name']").val("");
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
			<td colspan="11">
				金银业贸易场编号：</i><input type="text" name="exchangeNo" value="${queryDto.exchangeNo }">&nbsp;&nbsp;
				经纪商名称：</i><input type="text" name="name" value="${queryDto.name }">&nbsp;&nbsp;
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
				<th width="20"><input type="checkbox" id="firstCheckbox"/></th>
				<th nowrap="nowrap">操作</th>
				<th>金银业贸易场编号</th>
				<th>交易商名称</th>
				<th>公司属地</th>
				<th>业务类型</th>
				<th>产品点差</th>
				<th>交易平台</th>
				<th>业务形式</th>
				<th>客户回佣</th>
				<th>长仓利息</th>
				<th>短仓利息</th>
				<th>结算币值</th>
				<th>开仓保证金</th>
				<th>维持保证金</th>
				<th>锁仓保证金</th>
				<th>网页显示</th>
				<th>杠杆比例</th>
				<th>交易商链接</th>
				<th>链接显示</th>
			</tr>
		</thead>
		<c:forEach items="${page.list }" var="u">
			<tr >
			   <td>
			      <a href="${ctx }/product/courseType/edit?id=${u.id}">编辑</a>
			      <c:choose>
			      	<c:when test="${u.deleteFlag == 1}"><a name="revert_href"><input type="hidden" value="${u.id}"/>恢复</a>&nbsp;</c:when>
			      	<c:otherwise><a name="delete_href"><input type="hidden" value="${u.id}"/>删除</a></c:otherwise>
			      </c:choose>
			   </td>
			   <td>&nbsp;${u.exchangeNo }</td>
			   <td>&nbsp;${u.name }</td>
			   <td>
			   		<c:choose>
			   			<c:when test="${u.companyArea == '0' }">香港</c:when>
			   			<c:when test="${u.companyArea == '1' }">中国</c:when>
			   			<c:when test="${u.companyArea == '2' }">台湾</c:when>
			   			<c:when test="${u.companyArea == '3' }">其他</c:when>
			   			<c:otherwise>&nbsp;</c:otherwise>
			   		</c:choose>
			   </td>
			   <td>
			   		<c:choose>
			   			<c:when test="${u.serviceType == '0' }">黄金</c:when>
			   			<c:when test="${u.serviceType == '1' }">外汇</c:when>
			   			<c:when test="${u.serviceType == '2' }">中国A股</c:when>
			   			<c:otherwise>&nbsp;</c:otherwise>
			   		</c:choose>
			   </td>
			   <td>
			   		<c:choose>
			   			<c:when test="${u.pointDiff == '0' }">固定</c:when>
			   			<c:when test="${u.pointDiff == '1' }">浮动</c:when>
			   			<c:otherwise>&nbsp;</c:otherwise>
			   		</c:choose>
			   </td>			   
			   <td>
			   		<c:choose>
			   			<c:when test="${u.platform == '0' }">mt4</c:when>
			   			<c:when test="${u.platform == '1' }">mt5</c:when>
			   			<c:when test="${u.platform == '2' }">gts1</c:when>
			   			<c:when test="${u.platform == '3' }">mfinance</c:when>
			   			<c:when test="${u.platform == '4' }">其他</c:when>
			   			<c:otherwise>&nbsp;</c:otherwise>
			   		</c:choose>
			   </td>
			   <td>
			   		<c:choose>
			   			<c:when test="${u.platform == '0' }">代理</c:when>
			   			<c:when test="${u.platform == '1' }">直销</c:when>
			   			<c:when test="${u.platform == '2' }">混合</c:when>
			   			<c:otherwise>&nbsp;</c:otherwise>
			   		</c:choose>
			   </td>
			   <td>
			   		<c:choose>
			   			<c:when test="${u.isReturnCommission == '0' }">不提供</c:when>
			   			<c:when test="${u.isReturnCommission == '1' }">提供</c:when>
			   			<c:otherwise>&nbsp;</c:otherwise>
			   		</c:choose>
			   </td>
			   <td>&nbsp;${u.longRate }</td>
			   <td>&nbsp;${u.shortRate }</td>
			   <td>
			   		<c:choose>
			   			<c:when test="${u.moneyType == '0' }">USD</c:when>
			   			<c:when test="${u.moneyType == '1' }">HKD</c:when>
			   			<c:when test="${u.moneyType == '2' }">CNY</c:when>
			   			<c:otherwise>&nbsp;</c:otherwise>
			   		</c:choose>
			   </td>
			   <td>&nbsp;${u.openMoney }</td>			   
			   <td>&nbsp;${u.holdMoeny }</td>			   
			   <td>&nbsp;${u.closeMoney }</td>
			   <td>
			   		<c:choose>
			   			<c:when test="${u.isShowPage == '1' }">开</c:when>
			   			<c:when test="${u.isShowPage == '0' }">关</c:when>
			   			<c:otherwise>&nbsp;</c:otherwise>
			   		</c:choose>
			   </td>
			   <td>&nbsp;${u.leverRate }</td>
			   <td>&nbsp;${u.url }</td>
			   <td>
			   		<c:choose>
			   			<c:when test="${u.isShowUrl == '1' }">开</c:when>
			   			<c:when test="${u.isShowUrl == '0' }">关</c:when>
			   			<c:otherwise>&nbsp;</c:otherwise>
			   		</c:choose>
			   </td>
		    </tr>
		</c:forEach>
		<tr>
			<td width="20"><input type="checkbox" id="checkAll"/></td>
			<td colspan="20">
				<button id="delete_button" class="btn btn-danger"><i class="icon-remove icon-white"></i>删除</button>&nbsp;
				<button id="revert_button" class="btn btn-warning"><i class="icon-repeat icon-white"></i>恢复</button>
			</td>
		</tr>		
		<tr><td colspan="16" style="text-align:center;"><%@ include file="../common/pager.jsp"%></td>
		</tr>
	</table>
</form>
 <script type="text/javascript">
	function toAdd(){
		var _url = "${ctx }/product/courseType/edit";
        var _form = $("#form");
		_form.attr("action",_url);
		_form.submit();
	}
 </script>
</body>
</html>
