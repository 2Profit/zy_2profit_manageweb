<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>

<!DOCTYPE html>
<html>
<head>
<%@ include file="../common/common.jsp"%>
<%@ include file="../common/common_html_validator.jsp"%>
<title>添加课程类型</title>
<style>
	.td_right{text-align: right;}
	em {font-style: normal;color:red;}
</style>
<script type="text/javascript">
$(function(){
	$("#return_button").bind("click",function(event){
		event.preventDefault();
		window.location.replace("${ctx }/boss/brokerExtInfo/list");
	});
	
	$('#companyType').multiselect();
	$('#platform').multiselect();
	$('#productType').multiselect();
});

</script>
</head>

<body>
	<form action="" namespace="/" theme="simple" id="form" method = "POST">
		<table class="table table-bordered">
			<tr>
				<td colspan="4" style="background-color: #dff0d8;text-align: center;">
					<c:choose>
					  <c:when test="${brokerExtInfo.id == null || brokerExtInfo.id == '' }">
					    <strong>经纪商新增</strong>
					  </c:when>
					  <c:otherwise>
					    <strong>经纪商编辑</strong>
					  </c:otherwise>
					</c:choose>
					
				</td>
			</tr>
			<tr style="display:none;">
				<td><input type="hidden" name="id" value="${brokerExtInfo.id }" /></td>
				<td><input type="hidden" name="deleteFlag" value="${brokerExtInfo.deleteFlag }" /></td>
				<td><input type="hidden" name="createId" value="${brokerExtInfo.createId }" /></td>
				<td><input type="hidden" name="createName" value="${brokerExtInfo.createName }" /></td>
			</tr>
			
			<tr>
				<th class="td_right"><em>*</em>名称：</th>
				<td style="text-align: left;">
					<input type="text" name="name" data-rule="名称:required;name;length[1~64];" id="name"  value="${brokerExtInfo.name }"/>
				</td>
				<th class="td_right"><em>*</em>监管机构授予编号：</th>
				<td style="text-align: left;">
					<input type="text" name="exchangeNo" data-rule="监管机构授予编号:required;exchangeNo;length[1~64];" id="exchangeNo"  value="${brokerExtInfo.exchangeNo }"/>
				</td>
			</tr>
			
			<tr>
				<th class="td_right"><em>*</em>显示链接：</th>
				<td style="text-align: left;">
					<select id="isShowUrl" name="isShowUrl">
						<option value="">--请选择--</option>
					    <option value="1" <c:if test="${'1' == brokerExtInfo.isShowUrl }">selected="true"</c:if>>开启</option>
					    <option value="0" <c:if test="${'0' == brokerExtInfo.isShowUrl }">selected="true"</c:if>>关闭</option>
					</select>
				</td>			
				<th class="td_right">官网链接：</th>
				<td style="text-align: left;">
					<input type="text" name="url" id="url" value="${brokerExtInfo.url }"/>
				</td>			
			</tr>
			
			<tr>
				<th class="td_right">公司属地：</th>
				<td style="text-align: left;">
					<select id="companyArea" name="companyArea">
						<option value="">--请选择--</option>
					    <option value="0" <c:if test="${'0' == brokerExtInfo.companyArea }">selected="true"</c:if>>香港</option>
					    <option value="1" <c:if test="${'1' == brokerExtInfo.companyArea }">selected="true"</c:if>>中国</option>
					    <option value="2" <c:if test="${'2' == brokerExtInfo.companyArea }">selected="true"</c:if>>台湾</option>
					    <option value="3" <c:if test="${'3' == brokerExtInfo.companyArea }">selected="true"</c:if>>其他</option>
					</select>
				</td>			
				
				<th class="td_right">交易平台：</th>
				<td style="text-align: left;">
					<select id="platform" name="platform" multiple="multiple">
						<option value="">--请选择--</option>
					    <option value="0" <c:if test="${fn:contains(brokerExtInfo.platform, '0')}">selected="true"</c:if>>MT4</option>
					    <option value="1" <c:if test="${fn:contains(brokerExtInfo.platform, '1')}">selected="true"</c:if>>MT5</option>
					    <option value="2" <c:if test="${fn:contains(brokerExtInfo.platform, '2')}">selected="true"</c:if>>GTS1</option>
					    <option value="3" <c:if test="${fn:contains(brokerExtInfo.platform, '3')}">selected="true"</c:if>>GTS2</option>
					    <option value="4" <c:if test="${fn:contains(brokerExtInfo.platform, '4')}">selected="true"</c:if>>mFinance</option>
					</select>
				</td>			
			</tr>
			
			<tr>
				<th class="td_right">业务形式：</th>
				<td style="text-align: left;">
					<select id="serviceShape" name="serviceShape">
						<option value="">--请选择--</option>
					    <option value="0" <c:if test="${'0' == brokerExtInfo.serviceShape }">selected="true"</c:if>>代理</option>
					    <option value="1" <c:if test="${'1' == brokerExtInfo.serviceShape }">selected="true"</c:if>>直销</option>
					    <option value="2" <c:if test="${'2' == brokerExtInfo.serviceShape }">selected="true"</c:if>>混合</option>
					</select>
				</td>			
				
				<th class="td_right">公司类型：</th>
				<td style="text-align: left;">
					<select id="companyType" name="companyType" multiple="multiple">
						<option value="">--请选择--</option>
					    <option value="0" <c:if test="${fn:contains(brokerExtInfo.companyType, '0')}">selected="true"</c:if>>黄金</option>
					    <option value="1" <c:if test="${fn:contains(brokerExtInfo.companyType, '1')}">selected="true"</c:if>>外汇</option>
					    <option value="2" <c:if test="${fn:contains(brokerExtInfo.companyType, '2')}">selected="true"</c:if>>中国A股</option>
					</select>
				</td>			
			</tr>
			<tr>
				<th class="td_right">喊单服务：</th>
				<td style="text-align: left;">
					<select id="isSingalService" name="isSingalService">
						<option value="">--请选择--</option>
					    <option value="0" <c:if test="${'0' == brokerExtInfo.isSingalService }">selected="true"</c:if>>不提供</option>
					    <option value="1" <c:if test="${'1' == brokerExtInfo.isSingalService }">selected="true"</c:if>>提供</option>
					</select>
				</td>			
				<th class="td_right">账户分层：</th>
				<td style="text-align: left;">
					<select id="isAccountSeperate" name="isAccountSeperate">
						<option value="">--请选择--</option>
					    <option value="0" <c:if test="${'0' == brokerExtInfo.isAccountSeperate }">selected="true"</c:if>>不提供</option>
					    <option value="1" <c:if test="${'1' == brokerExtInfo.isAccountSeperate }">selected="true"</c:if>>提供</option>
					</select>
				</td>			
			</tr>

			<tr>
				<th class="td_right">产品：</th>
				<td style="text-align: left;">
					<select id="productType" name="productType" multiple="multiple">
						<option value="">--请选择--</option>
					    <option value="0" <c:if test="${fn:contains(brokerExtInfo.productType, '0')}">selected="true"</c:if>>LLG</option>
					    <option value="1" <c:if test="${fn:contains(brokerExtInfo.productType, '1')}">selected="true"</c:if>>LLS</option>
					    <option value="2" <c:if test="${fn:contains(brokerExtInfo.productType, '2')}">selected="true"</c:if>>HKG</option>
					    <option value="3" <c:if test="${fn:contains(brokerExtInfo.productType, '3')}">selected="true"</c:if>>LKG</option>
					</select>
				</td>			
				
				<th class="td_right">结算币值：</th>
				<td style="text-align: left;">
					<select id="moneyType" name="moneyType">
						<option value="">--请选择--</option>
					    <option value="0" <c:if test="${'0' == brokerExtInfo.moneyType }">selected="true"</c:if>>美元</option>
					    <option value="1" <c:if test="${'1' == brokerExtInfo.moneyType }">selected="true"</c:if>>人民币</option>
					    <option value="2" <c:if test="${'2' == brokerExtInfo.moneyType }">selected="true"</c:if>>港元</option>
					    <option value="3" <c:if test="${'3' == brokerExtInfo.moneyType }">selected="true"</c:if>>混合</option>
					</select>
				</td>			
			</tr>
			
			<tr>
				<th class="td_right">产品点差：</th>
				<td style="text-align: left;" colspan="3">
					<select id="pointDiff" name="pointDiff">
						<option value="">--请选择--</option>
					    <option value="0" <c:if test="${'0' == brokerExtInfo.pointDiff }">selected="true"</c:if>>固定</option>
					    <option value="1" <c:if test="${'1' == brokerExtInfo.pointDiff }">selected="true"</c:if>>浮动</option>
					</select>
				</td>			
			</tr>
			<tr>	
				<th class="td_right">产品点差 (最低)：</th>
				<td style="text-align: left;" colspan="3">
					LLG:<input type="text" name="holdMoneyLlg"  id="pointDiffMinLlg" value="${brokerExtInfo.pointDiffMinLlg}"/>
					LLS:<input type="text" name="pointDiffMinLls"  id="pointDiffMinLls" value="${brokerExtInfo.pointDiffMinLls}"/>
					HKG:<input type="text" name="pointDiffMinHkg"  id="pointDiffMinHkg" value="${brokerExtInfo.pointDiffMinHkg}"/>
					LKG:<input type="text" name="pointDiffMinLkg"  id="pointDiffMinLkg" value="${brokerExtInfo.pointDiffMinLkg}"/>
				</td>			
			</tr>
			<tr>	
				<th class="td_right">单次最低交易手数：</th>
				<td style="text-align: left;" colspan="3">
					LLG:<input type="text" name="closeMoneyLlg"  id="pointDiffMaxLlg" value="${brokerExtInfo.pointDiffMaxLlg}"/>
					LLS:<input type="text" name="pointDiffMaxLls"  id="pointDiffMaxLls" value="${brokerExtInfo.pointDiffMaxLls}"/>
					HKG:<input type="text" name="pointDiffMaxHkg"  id="pointDiffMaxHkg" value="${brokerExtInfo.pointDiffMaxHkg}"/>
					LKG:<input type="text" name="pointDiffMaxLkg"  id="pointDiffMaxLkg" value="${brokerExtInfo.pointDiffMaxLkg}"/>
				</td>			
			</tr>
			<tr>	
				<th class="td_right">单次最高交易手数：</th>
				<td style="text-align: left;" colspan="3">
					LLG:<input type="text" name="maxTradeNumLlg"  id="maxTradeNumLlg" value="${brokerExtInfo.maxTradeNumLlg}"/>
					LLS:<input type="text" name="maxTradeNumLls"  id="maxTradeNumLls" value="${brokerExtInfo.maxTradeNumLls}"/>
					HKG:<input type="text" name="maxTradeNumHkg"  id="maxTradeNumHkg" value="${brokerExtInfo.maxTradeNumHkg}"/>
					LKG:<input type="text" name="maxTradeNumLkg"  id="maxTradeNumLkg" value="${brokerExtInfo.maxTradeNumLkg}"/>
				</td>			
			</tr>

			<tr>
				<th class="td_right">持仓手数上线：</th>
				<td style="text-align: left;">
					<input type="text" name="maxHoldNum" id="maxHoldNum"  value="${brokerExtInfo.maxHoldNum }"/>
				</td>
				<th class="td_right">杠杆比例：</th>
				<td style="text-align: left;">
					<input type="text" name="leverRate" id="leverRate"  value="${brokerExtInfo.leverRate }"/>
				</td>
			</tr>			

			<tr>
				<th class="td_right">客户回佣：</th>
				<td style="text-align: left;">
					<select id="isReturnCommission" name="isReturnCommission">
						<option value="">--请选择--</option>
					    <option value="0" <c:if test="${'0' == brokerExtInfo.isReturnCommission }">selected="true"</c:if>>不提供</option>
					    <option value="1" <c:if test="${'1' == brokerExtInfo.isReturnCommission }">selected="true"</c:if>>提供</option>
					</select>
				</td>			
				<th class="td_right">交易编码：</th>
				<td style="text-align: left;">
					<select id="isTradeCode" name="isTradeCode">
						<option value="">--请选择--</option>
					    <option value="0" <c:if test="${'0' == brokerExtInfo.isTradeCode }">selected="true"</c:if>>不提供</option>
					    <option value="1" <c:if test="${'1' == brokerExtInfo.isTradeCode }">selected="true"</c:if>>提供</option>
					</select>
				</td>			
			</tr>
			
			<tr>
				<th class="td_right">建仓手续费：</th>
				<td style="text-align: left;">
					<select id="isOpenFee" name="isOpenFee">
						<option value="">--请选择--</option>
					    <option value="0" <c:if test="${'0' == brokerExtInfo.isOpenFee }">selected="true"</c:if>>不收取</option>
					    <option value="1" <c:if test="${'1' == brokerExtInfo.isOpenFee }">selected="true"</c:if>>收取</option>
					</select>
				</td>			
				<th class="td_right">平仓手续费：</th>
				<td style="text-align: left;">
					<select id="isCloseFee" name="isCloseFee">
						<option value="">--请选择--</option>
					    <option value="0" <c:if test="${'0' == brokerExtInfo.isCloseFee }">selected="true"</c:if>>不收取</option>
					    <option value="1" <c:if test="${'1' == brokerExtInfo.isCloseFee }">selected="true"</c:if>>收取</option>
					</select>
				</td>			
			</tr>
			
			<tr>
				<th class="td_right">长仓利息：</th>
				<td style="text-align: left;">
					<input type="text" name="longRate" id="longRate" value="${brokerExtInfo.longRate }"/>
				</td>
				<th class="td_right">短仓利息：</th>
				<td style="text-align: left;">
					<input type="text" name="shortRate" id="shortRate" value="${brokerExtInfo.shortRate }"/>
				</td>
			</tr>
			
			<tr>	
				<th class="td_right">开仓保证金：</th>
				<td style="text-align: left;" colspan="3">
					LLG:<input type="text" name="openMoneyLlg"  id="openMoneyLlg" value="${brokerExtInfo.openMoneyLlg}"/>
					LLS:<input type="text" name="openMoneyLls"  id="openMoneyLls" value="${brokerExtInfo.openMoneyLls}"/>
					HKG:<input type="text" name="openMoneyHkg"  id="openMoneyHkg" value="${brokerExtInfo.openMoneyHkg}"/>
					LKG:<input type="text" name="openMoneyLkg"  id="openMoneyLkg" value="${brokerExtInfo.openMoneyLkg}"/>
				</td>			
			</tr>
			<tr>	
				<th class="td_right">维持保证金：</th>
				<td style="text-align: left;" colspan="3">
					LLG:<input type="text" name="pointDiffMaxLlg"  id="holdMoneyLlg" value="${brokerExtInfo.holdMoneyLlg}"/>
					LLS:<input type="text" name="holdMoneyLls"  id="holdMoneyLls" value="${brokerExtInfo.holdMoneyLls}"/>
					HKG:<input type="text" name="holdMoneyHkg"  id="holdMoneyHkg" value="${brokerExtInfo.holdMoneyHkg}"/>
					LKG:<input type="text" name="holdMoneyLkg"  id="holdMoneyLkg" value="${brokerExtInfo.holdMoneyLkg}"/>
				</td>			
			</tr>
			<tr>	
				<th class="td_right">锁仓保证金：</th>
				<td style="text-align: left;" colspan="3">
					LLG:<input type="text" name="maxTradeNumLlg"  id="closeMoneyLlg" value="${brokerExtInfo.closeMoneyLlg}"/>
					LLS:<input type="text" name="closeMoneyLls"  id="closeMoneyLls" value="${brokerExtInfo.closeMoneyLls}"/>
					HKG:<input type="text" name="closeMoneyHkg"  id="closeMoneyHkg" value="${brokerExtInfo.closeMoneyHkg}"/>
					LKG:<input type="text" name="closeMoneyLkg"  id="closeMoneyLkg" value="${brokerExtInfo.closeMoneyLkg}"/>
				</td>			
			</tr>
			
			<tr>
				<th class="td_right">强平百分比（平日）：</th>
				<td style="text-align: left;">
					<input type="text" name="closeRate" id="closeRate" value="${brokerExtInfo.closeRate }"/>
				</td>
				<th class="td_right">强平百分比（周末/假期）：</th>
				<td style="text-align: left;">
					<input type="text" name="closeRateExt" id="closeRateExt" value="${brokerExtInfo.closeRateExt }"/>
				</td>
			</tr>
			
			<tr >
				<td colspan="4" style="text-align: center;">
				   <c:choose>
				     <c:when test="${brokerExtInfo.id == null || brokerExtInfo.id == '' }">
				        <button method="save" class="btn btn-success">
							<i class="icon-ok icon-white"></i> 新增
						</button>
				     </c:when>
				     <c:otherwise>
				        <button method="save" class="btn btn-success" name="postData_button">
							<i class="icon-ok icon-white"></i> 保存
						</button>
				     </c:otherwise>
				   </c:choose>
					
					<button class="btn btn-inverse" id="return_button">
			   			 <i class="icon-arrow-left icon-white"></i> 返回
					</button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
