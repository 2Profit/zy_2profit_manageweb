<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page session="false" %>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>经纪商列表</title>
<%@ include file="../common/common.jsp"%>
<script type="text/javascript" src="${ctx }/static/js/manage-web-common.js"/></script>
<script type="text/javascript">
$(function(){
	$('#fresh_button').bind("click",function(){
		$("input[name='exchangeNo']").val("");
		$("input[name='name']").val("");
		$("#companyArea").val("");
		$("#companyType").val("");
		$("#deleteFlag").val("");
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
			<th>监管机构授权编号：</th>
			<td><input type="text" name="exchangeNo" value="${queryDto.exchangeNo }"></td>
			<th>经纪商名称：</th>
			<td><input type="text" name="name" value="${queryDto.name }"></td>		
			<th>状态：</th>
			<td>
				<select id="deleteFlag" name="deleteFlag">
					<option value="">--请选择--</option>
					<option value="0" <c:if test="${'0' == queryDto.deleteFlag }">selected="true"</c:if>>待审核</option>
					<option value="2" <c:if test="${'2' == queryDto.deleteFlag }">selected="true"</c:if>>正常</option>
					<option value="1" <c:if test="${'1' == queryDto.deleteFlag }">selected="true"</c:if>>删除</option>
					<option value="3" <c:if test="${'3' == queryDto.deleteFlag }">selected="true"</c:if>>停课</option>
				</select>
			</td>
		</tr>
		<tr>
			<th>公司属地：</th>
			<td>
				<select id=companyArea name="companyArea">
					<option value="">--请选择--</option>
				    <option value="0" <c:if test="${'0' == queryDto.companyArea }">selected="true"</c:if>>香港</option>
				    <option value="1" <c:if test="${'1' == queryDto.companyArea }">selected="true"</c:if>>中国</option>
				    <option value="2" <c:if test="${'2' == queryDto.companyArea }">selected="true"</c:if>>台湾</option>
				    <option value="3" <c:if test="${'3' == queryDto.companyArea }">selected="true"</c:if>>其他</option>
				</select>
			</td>
			<th>公司类型：</th>
			<td style="text-align: left;" colspan="3">
				<select id="companyType" name="companyType">
					<option value="">--请选择--</option>
				    <option value="0" <c:if test="${queryDto.companyType == '0'}">selected="true"</c:if>>黄金</option>
				    <option value="1" <c:if test="${queryDto.companyType == '1'}">selected="true"</c:if>>外汇</option>
				    <option value="2" <c:if test="${queryDto.companyType == '2'}">selected="true"</c:if>>中国A股</option>
				</select>
			</td>				
		</tr>
	
		<tr>
			<td colspan="11">

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
				<th width="10"><input type="checkbox" id="firstCheckbox"/></th>
				<th nowrap="nowrap">操作</th>
				<th>名称</th>
				<th>官方网站</th>
				<th>网页显示</th>
				<th>监管机构授权编号</th>
				<th>公司属地</th>
				<th>交易平台</th>
				<th>业务形式</th>
				<th>喊单服务</th>
				<th>账户分层</th>
				<th>公司类型</th>
				<th>产品</th>
				<th>结算币值</th>
				<th>产品点差</th>
				<th>产品点差(最低)</th>
				<th>单次最低交易手数</th>
				<th>单次最高交易手数</th>
				<th>持仓手数上限</th>
				<th>客户回佣</th>
				<th>交易编号</th>
				<th>建仓手续费</th>
				<th>平仓手续费</th>
				<th>长仓利息</th>
				<th>短仓利息</th>
				<th>开仓保证金</th>
				<th>维持保证金</th>
				<th>锁仓保证金</th>
				<th>杠杆比例</th>
				<th>强平百分比_平日</th>
				<th>强平百分比_周末/假期</th>
			</tr>
		</thead>
		<c:forEach items="${page.list }" var="u">
			<tr>
				<td><input type="checkbox" name="ids" value="${u.id }"/></td>			
			   <td>
			      <a href="${ctx }/boss/brokerExtInfo/edit?id=${u.id}">编辑</a>
			      <c:choose>
			      	<c:when test="${u.deleteFlag == 1}"><a name="revert_href"><input type="hidden" value="${u.id}"/>恢复</a>&nbsp;</c:when>
			      	<c:otherwise><a name="delete_href"><input type="hidden" value="${u.id}"/>删除</a></c:otherwise>
			      </c:choose>
			   </td>
			   <td>&nbsp;${u.name }</td>
			   <td>&nbsp;${u.url }</td>
			   <td>
			   		<c:choose>
			   			<c:when test="${u.isShowUrl == '0' }">关闭</c:when>
			   			<c:when test="${u.isShowUrl == '1' }">开启</c:when>
			   			<c:otherwise>&nbsp;</c:otherwise>
			   		</c:choose>
			   </td>
			   <td>&nbsp;${u.exchangeNo }</td>
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
			   		<c:if test="${fn:contains(u.platform, '0')}">MT4,</c:if>
			   		<c:if test="${fn:contains(u.platform, '1')}">MT5,</c:if>
			   		<c:if test="${fn:contains(u.platform, '2')}">GTS1,</c:if>
			   		<c:if test="${fn:contains(u.platform, '3')}">GTS2,</c:if>			   
			   		<c:if test="${fn:contains(u.platform, '4')}">mFinance,</c:if>			   
			   </td>
			   <td>
			   		<c:choose>
			   			<c:when test="${u.serviceShape == '0' }">代理</c:when>
			   			<c:when test="${u.serviceShape == '1' }">直销</c:when>
			   			<c:when test="${u.serviceShape == '2' }">混合</c:when>
			   			<c:otherwise>&nbsp;</c:otherwise>
			   		</c:choose>
			   </td>
			   <td>
			   		<c:choose>
			   			<c:when test="${u.isSingalService == '1' }">提供</c:when>
			   			<c:when test="${u.isSingalService == '0' }">不提供</c:when>
			   			<c:otherwise>&nbsp;</c:otherwise>
			   		</c:choose>
			   </td>			   			   
			   <td>
			   		<c:choose>
			   			<c:when test="${u.isAccountSeperate == '1' }">提供</c:when>
			   			<c:when test="${u.isAccountSeperate == '0' }">不提供</c:when>
			   			<c:otherwise>&nbsp;</c:otherwise>
			   		</c:choose>
			   </td>			   			   
			   <td>
					<c:if test="${fn:contains(u.companyType, '0')}">黄金,</c:if>
			   		<c:if test="${fn:contains(u.companyType, '1')}">外汇,</c:if>
			   		<c:if test="${fn:contains(u.companyType, '2')}">中国A股,</c:if>
			   </td>
			   <td>
			   		<c:if test="${fn:contains(u.productType, '0')}">LLG,</c:if>
			   		<c:if test="${fn:contains(u.productType, '1')}">LLS,</c:if>
			   		<c:if test="${fn:contains(u.productType, '2')}">HKG,</c:if>
			   		<c:if test="${fn:contains(u.productType, '3')}">LKG,</c:if>
			   </td>
			   <td>
			   		<c:choose>
			   			<c:when test="${u.moneyType == '0' }">美元</c:when>
			   			<c:when test="${u.moneyType == '1' }">人民币</c:when>
			   			<c:when test="${u.moneyType == '2' }">港元</c:when>
			   			<c:when test="${u.moneyType == '3' }">混合</c:when>
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
			   		<c:if test="${u.pointDiffMaxLlg != '' }">LLG:${u.pointDiffMaxLlg}<br/></c:if>
			   		<c:if test="${u.pointDiffMaxLls != '' }">LLS:${u.pointDiffMaxLls}<br/></c:if>
			   		<c:if test="${u.pointDiffMaxHkg != '' }">HKG:${u.pointDiffMaxHkg}<br/></c:if>
			   		<c:if test="${u.pointDiffMaxLkg != '' }">LKG:${u.pointDiffMaxLkg}</c:if>
			   </td>			   
			   <td>
			   		<c:if test="${u.pointDiffMinLlg != '' }">LLG:${u.pointDiffMinLlg}<br/></c:if>
			   		<c:if test="${u.pointDiffMinLls != '' }">LLS:${u.pointDiffMinLls}<br/></c:if>
			   		<c:if test="${u.pointDiffMinHkg != '' }">HKG:${u.pointDiffMinHkg}<br/></c:if>
			   		<c:if test="${u.pointDiffMinLkg != '' }">LKG:${u.pointDiffMinLkg}</c:if>
			   </td>			   
			   <td>
			   		<c:if test="${u.maxTradeNumLlg != '' }">LLG:${u.maxTradeNumLlg}<br/></c:if>
			   		<c:if test="${u.maxTradeNumLls != '' }">LLS:${u.maxTradeNumLls}<br/></c:if>
			   		<c:if test="${u.maxTradeNumHkg != '' }">HKG:${u.maxTradeNumHkg}<br/></c:if>
			   		<c:if test="${u.maxTradeNumLkg != '' }">LKG:${u.maxTradeNumLkg}</c:if>
			   </td>			   
			   	<td>&nbsp;${u.maxHoldNum }</td>
			   	<td>
			   		<c:choose>
			   			<c:when test="${u.isReturnCommission == '0' }">不提供</c:when>
			   			<c:when test="${u.isReturnCommission == '1' }">提供</c:when>
			   			<c:otherwise>&nbsp;</c:otherwise>
			   		</c:choose>
			   </td>	   
			   	<td>
			   		<c:choose>
			   			<c:when test="${u.isTradeCode == '0' }">不提供</c:when>
			   			<c:when test="${u.isTradeCode == '1' }">提供</c:when>
			   			<c:otherwise>&nbsp;</c:otherwise>
			   		</c:choose>
			   </td>	   
			   	<td>
			   		<c:choose>
			   			<c:when test="${u.isOpenFee == '0' }">不提供</c:when>
			   			<c:when test="${u.isOpenFee == '1' }">提供</c:when>
			   			<c:otherwise>&nbsp;</c:otherwise>
			   		</c:choose>
			   </td>	
			   	<td>
			   		<c:choose>
			   			<c:when test="${u.isCloseFee == '0' }">不提供</c:when>
			   			<c:when test="${u.isCloseFee == '1' }">提供</c:when>
			   			<c:otherwise>&nbsp;</c:otherwise>
			   		</c:choose>
			   </td>	
			   <td>&nbsp;${u.longRate }</td>   
			   <td>&nbsp;${u.shortRate }</td>   
			   <td>
			   		<c:if test="${u.openMoneyLlg != '' }">LLG:${u.openMoneyLlg}<br/></c:if>
			   		<c:if test="${u.openMoneyLls != '' }">LLS:${u.openMoneyLls}<br/></c:if>
			   		<c:if test="${u.openMoneyHkg != '' }">HKG:${u.openMoneyHkg}<br/></c:if>
			   		<c:if test="${u.openMoneyLkg != '' }">LKG:${u.openMoneyLkg}</c:if>
			   </td>			   
			   <td>
			   		<c:if test="${u.holdMoneyLlg != '' }">LLG:${u.holdMoneyLlg}<br/></c:if>
			   		<c:if test="${u.holdMoneyLls != '' }">LLS:${u.holdMoneyLls}<br/></c:if>
			   		<c:if test="${u.holdMoneyLlg != '' }">HKG:${u.holdMoneyHkg}<br/></c:if>
			   		<c:if test="${u.holdMoneyLkg != '' }">LKG:${u.holdMoneyLkg}</c:if>
			   </td>			   
			   <td>
			   		<c:if test="${u.closeMoneyLlg != '' }">LLG:${u.closeMoneyLlg}<br/></c:if>
			   		<c:if test="${u.closeMoneyLls != '' }">LLS:${u.closeMoneyLls}<br/></c:if>
			   		<c:if test="${u.closeMoneyHkg != '' }">HKG:${u.closeMoneyHkg}<br/></c:if>
			   		<c:if test="${u.closeMoneyLkg != '' }">LKG:${u.closeMoneyLkg}</c:if>
			   </td>			   
			   <td>&nbsp;${u.leverRate }</td>
			   <td>&nbsp;${u.closeRate }</td>
			   <td>&nbsp;${u.closeRateExt }</td>
		    </tr>
		</c:forEach>
		<tr>
			<td width="50"><input type="checkbox" id="checkAll"/></td>
			<td colspan="50">
				<button id="delete_button" class="btn btn-danger"><i class="icon-remove icon-white"></i>删除</button>&nbsp;
				<button id="revert_button" class="btn btn-warning"><i class="icon-repeat icon-white"></i>恢复</button>
			</td>
		</tr>		
		<tr><td colspan="50" style="text-align:center;"><%@ include file="../common/pager.jsp"%></td>
		</tr>
	</table>
</form>
 <script type="text/javascript">
	function toAdd(){
		var _url = "${ctx }/boss/brokerExtInfo/edit";
        var _form = $("#form");
		_form.attr("action",_url);
		_form.submit();
	}
 </script>
</body>
</html>
