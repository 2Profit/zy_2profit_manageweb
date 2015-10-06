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
	img {height: auto;width:auto;}
</style>
<script type="text/javascript">
$(function(){
	//图片修改后预览
	$('#image').change(function(){
		if (this.files && this.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function (e) {
	            $('#blah').attr('src', e.target.result);
	        }
	        reader.readAsDataURL(this.files[0]);
	    }
	});
	
	
	$("#return_button").bind("click",function(event){
		event.preventDefault();
		window.location.replace("${ctx }/brokerExtInfo/list");
	});
	
	$('#companyType').multiselect();
	$('#platform').multiselect();
	$('#productType').multiselect();
	
	$('input[name=cnName]').blur(function(){
		if($('input[name=id]').val()!=''){return;}//新增的时候验证
		$.post(
	       	"${ctx }/brokerExtInfo/validate",
	    	{'cnName':$('input[name=cnName]').val()},
	    	function(json) {
	       		if(!json.success){
	       			alert("中文名称:"+$('input[name=cnName]').val()+"，已经存在！");
	       			$('input[name=cnName]').focus();
	       		}
	       	}    
		);
	});
	$('input[name=enName]').blur(function(){
		if($('input[name=id]').val()!=''){return;}//新增的时候验证
		$.post(
	       	"${ctx }/brokerExtInfo/validate",
	    	{'enName':$('input[name=enName]').val()},
	    	function(json) {
	       		if(!json.success){
	       			alert("英文名称:"+$('input[name=enName]').val()+"，已经存在！");
	       			$('input[name=enName]').focus();
	       		}
	       	}    
		);
	});
	$('input[name=companyIndex]').blur(function(){
		if($('input[name=id]').val()!=''){return;}//新增的时候验证
		$.post(
	       	"${ctx }/brokerExtInfo/validate",
	    	{'companyIndex':$('input[name=companyIndex]').val()},
	    	function(json) {
	       		if(!json.success){
	       			alert("公司推荐值:"+$('input[name=companyIndex]').val()+"，已经存在！");
	       			$('input[name=companyIndex]').focus();
	       		}
	       	}    
		);
	});
	$('input[name=exchangeNo]').blur(function(){
		if($('input[name=id]').val()!=''){return;}//新增的时候验证
		$.post(
	       	"${ctx }/brokerExtInfo/validate",
	    	{'exchangeNo':$('input[name=exchangeNo]').val()},
	    	function(json) {
	       		if(!json.success){
	       			alert("交易编码:"+$('input[name=exchangeNo]').val()+"，已经存在！");
	       			$('input[name=exchangeNo]').focus();
	       		}
	       	}    
		);
	});
		
	$('button[name=post_button]').click(function(){
		var formData = new FormData($('#form')[0]);
		$.ajax({
	        type: "POST",
	        url: "${ctx }/voteTopic/save",
	        cache: false,
	        async: false,
	        contentType: false,
	        processData: false,
	        data:formData,
	        dataType:"json",
	        success: function (json) {
	        	if(json.success){
	        		alert('保存成功！');
	        		window.location.replace("${ctx }/brokerExtInfo/list");
	        	}else{
	        		alert('保存失败！','');
	        	}
	        }
	    });		
	});
		
});


</script>
</head>

<body>
	<form action="" namespace="/" theme="simple" id="form" method = "POST" enctype="multipart/form-data">
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
				<th class="td_right"><em>*</em>中文名称：</th>
				<td style="text-align: left;">
					<input type="text" name="cnName" data-rule="名称:required;name;length[1~64];" 
							id="cnName"  value="${brokerExtInfo.cnName }"/>
				</td>
				<th class="td_right"><em>*</em>英文名称：</th>
				<td style="text-align: left;">
					<input type="text" name="enName" data-rule="名称:required;enName;length[1~64];" 
							id="enName"  value="${brokerExtInfo.enName }"/>
				</td>
			</tr>	
				<th class="td_right"><em>*</em>监管机构类型：</th>
				<td style="text-align: left;">
					<select id="exchangeType" name="exchangeType" data-rule="监管机构类型:required;exchangeType;" >
						<option value="">--请选择--</option>
					    <option value="0" <c:if test="${brokerExtInfo.id == null || '0' == brokerExtInfo.exchangeType }">selected</c:if>>银行业贸易场</option>
					    <option value="1" <c:if test="${'1' == brokerExtInfo.exchangeType }">selected</c:if>>证监会</option>
					    <option value="2" <c:if test="${'2' == brokerExtInfo.exchangeType }">selected</c:if>>不设</option>
					</select>						
				</td>
				<th class="td_right"><em>*</em>监管机构授予编号：</th>
				<td style="text-align: left;">
					<input type="text" name="exchangeNo" data-rule="监管机构授予编号:required;exchangeNo;length[1~64];" 
						id="exchangeNo"  value="${brokerExtInfo.exchangeNo }"/>
				</td>
			</tr>
			
			<tr>
				<th class="td_right"><em>*</em>显示链接：</th>
				<td style="text-align: left;">
					<select id="isShowUrl" name="isShowUrl">
						<option value="">--请选择--</option>
					    <option value="1" <c:if test="${brokerExtInfo.id == null || '1' == brokerExtInfo.isShowUrl }">selected</c:if>>开启</option>
					    <option value="0" <c:if test="${'0' == brokerExtInfo.isShowUrl }">selected</c:if>>关闭</option>
					</select>
				</td>			
				<th class="td_right"><em>*</em>官网链接：</th>
				<td style="text-align: left;">
					<input type="text" name="websiteUrl" data-rule="监管机构授予编号:required;websiteUrl;"
						id="websiteUrl" value="${brokerExtInfo.websiteUrl }"/>
				</td>			
			</tr>
			
			<tr>
				<th class="td_right"><em>*</em>公司属地：</th>
				<td style="text-align: left;">
					<select id="companyArea" name="companyArea" data-rule="公司属地:required;companyArea;">
						<option value="">--请选择--</option>
					    <option value="0" <c:if test="${brokerExtInfo.id == null || '0' == brokerExtInfo.companyArea }">selected</c:if>>香港</option>
					    <option value="1" <c:if test="${'1' == brokerExtInfo.companyArea }">selected</c:if>>中国</option>
					    <option value="2" <c:if test="${'2' == brokerExtInfo.companyArea }">selected</c:if>>台湾</option>
					    <option value="3" <c:if test="${'3' == brokerExtInfo.companyArea }">selected</c:if>>其他</option>
					</select>
				</td>			
				<th class="td_right"><em>*</em>交易平台：</th>
				<td style="text-align: left;">
					<select id="platform" name="platform" multiple="multiple">
						<option value="">--请选择--</option>
					    <option value="0" <c:if test="${brokerExtInfo.id == null || fn:contains(brokerExtInfo.platform, '0')}">selected</c:if>>MT4</option>
					    <option value="1" <c:if test="${fn:contains(brokerExtInfo.platform, '1')}">selected</c:if>>MT5</option>
					    <option value="2" <c:if test="${fn:contains(brokerExtInfo.platform, '2')}">selected</c:if>>GTS1</option>
					    <option value="3" <c:if test="${fn:contains(brokerExtInfo.platform, '3')}">selected</c:if>>GTS2</option>
					    <option value="4" <c:if test="${fn:contains(brokerExtInfo.platform, '4')}">selected</c:if>>mFinance</option>
					</select>
				</td>			
			</tr>
			
			<tr>
				<th class="td_right"><em>*</em>业务形式：</th>
				<td style="text-align: left;">
					<select id="serviceShape" name="serviceShape" data-rule="业务形式:required;serviceShape;">
						<option value="">--请选择--</option>
					    <option value="0" <c:if test="${'0' == brokerExtInfo.serviceShape }">selected</c:if>>代理</option>
					    <option value="1" <c:if test="${'1' == brokerExtInfo.serviceShape }">selected</c:if>>直销</option>
					    <option value="2" <c:if test="${'2' == brokerExtInfo.serviceShape }">selected</c:if>>混合</option>
					</select>
				</td>			
				<th class="td_right"><em>*</em>喊单服务：</th>
				<td style="text-align: left;">
					<select id="isSingalService" name="isSingalService" data-rule="喊单服务:required;isSingalService;">
						<option value="">--请选择--</option>
					    <option value="0" <c:if test="${brokerExtInfo.id == null || '0' == brokerExtInfo.isSingalService }">selected</c:if>>不提供</option>
					    <option value="1" <c:if test="${'1' == brokerExtInfo.isSingalService }">selected</c:if>>提供</option>
					</select>
				</td>				
			</tr>
			<tr>
				<th class="td_right"><em>*</em>账户分层：</th>
				<td style="text-align: left;">
					<select id="isAccountSeperate" name="isAccountSeperate" data-rule="账户分层:required;isAccountSeperate;">
						<option value="">--请选择--</option>
					    <option value="0" <c:if test="${brokerExtInfo.id == null || '0' == brokerExtInfo.isAccountSeperate }">selected</c:if>>不提供</option>
					    <option value="1" <c:if test="${'1' == brokerExtInfo.isAccountSeperate }">selected</c:if>>提供</option>
					</select>
				</td>
				<th class="td_right"><em>*</em>公司类型：</th>
				<td style="text-align: left;">
					<select id="companyType" name="companyType" multiple="multiple" data-rule="公司类型:required;companyType;">
						<option value="">--请选择--</option>
					    <option value="0" <c:if test="${brokerExtInfo.id == null || fn:contains(brokerExtInfo.companyType, '0')}">selected</c:if>>黄金</option>
					    <option value="1" <c:if test="${fn:contains(brokerExtInfo.companyType, '1')}">selected</c:if>>外汇</option>
					    <option value="2" <c:if test="${fn:contains(brokerExtInfo.companyType, '2')}">selected</c:if>>中国A股</option>
					</select>
				</td>							
			</tr>

			<tr>
				<th class="td_right"><em>*</em>产品：</th>
				<td style="text-align: left;">
					<select id="productType" name="productType" multiple="multiple" data-rule="产品:required;productType;">
						<option value="">--请选择--</option>
					    <option value="0" <c:if test="${brokerExtInfo.id == null || fn:contains(brokerExtInfo.productType, '0')}">selected</c:if>>伦敦金</option>
					    <option value="1" <c:if test="${brokerExtInfo.id == null || fn:contains(brokerExtInfo.productType, '1')}">selected</c:if>>伦敦银</option>
					    <option value="2" <c:if test="${fn:contains(brokerExtInfo.productType, '2')}">selected</c:if>>港金</option>
					    <option value="3" <c:if test="${fn:contains(brokerExtInfo.productType, '3')}">selected</c:if>>人民币公斤条</option>
					</select>
				</td>			
				
				<th class="td_right"><em>*</em>结算币值：</th>
				<td style="text-align: left;">
					<select id="moneyType" name="moneyType" data-rule="结算币值:required;moneyType;">
						<option value="">--请选择--</option>
					    <option value="0" <c:if test="${brokerExtInfo.id == null || '0' == brokerExtInfo.moneyType }">selected</c:if>>美元</option>
					    <option value="1" <c:if test="${'1' == brokerExtInfo.moneyType }">selected</c:if>>人民币</option>
					    <option value="2" <c:if test="${'2' == brokerExtInfo.moneyType }">selected</c:if>>港元</option>
					    <option value="3" <c:if test="${'3' == brokerExtInfo.moneyType }">selected</c:if>>混合</option>
					</select>
				</td>			
			</tr>
			
			<tr>
				<th class="td_right"><em>*</em>产品点差：</th>
				<td style="text-align: left;" colspan="3">
					<select id="pointDiff" name="pointDiff" data-rule="产品点差:required;pointDiff;">
						<option value="">--请选择--</option>
					    <option value="0" <c:if test="${'0' == brokerExtInfo.pointDiff }">selected</c:if>>固定</option>
					    <option value="1" <c:if test="${brokerExtInfo.id == null || '1' == brokerExtInfo.pointDiff }">selected</c:if>>浮动</option>
					</select>
				</td>			
			</tr>
			<tr>	
				<th class="td_right"><em>*</em>产品点差 (最低)：</th>
				<td style="text-align: left;" colspan="3">
					伦敦金:<input type="text" name="pointDiffMinLlg"  id="pointDiffMinLlg" value="${brokerExtInfo.pointDiffMinLlg}"/>
					伦敦银:<input type="text" name="pointDiffMinLls"  id="pointDiffMinLls" value="${brokerExtInfo.pointDiffMinLls}"/>
					港金:<input type="text" name="pointDiffMinHkg"  id="pointDiffMinHkg" value="${brokerExtInfo.pointDiffMinHkg}"/>
					人民币公斤条:<input type="text" name="pointDiffMinLkg"  id="pointDiffMinLkg" value="${brokerExtInfo.pointDiffMinLkg}"/>
				</td>			
			</tr>
			<tr>	
				<th class="td_right"><em>*</em>单次最低交易手数：</th>
				<td style="text-align: left;" colspan="3">
					伦敦金:<input type="text" name="minTradeNumLlg"  id="minTradeNumLlg" value="${brokerExtInfo.minTradeNumLlg}"/>
					伦敦银:<input type="text" name="minTradeNumLls"  id="minTradeNumLls" value="${brokerExtInfo.minTradeNumLls}"/>
					港金:<input type="text" name="minTradeNumHkg"  id="minTradeNumHkg" value="${brokerExtInfo.minTradeNumHkg}"/>
					人民币公斤条:<input type="text" name="minTradeNumLkg"  id="minTradeNumLkg" value="${brokerExtInfo.minTradeNumLkg}"/>
				</td>			
			</tr>
			<tr>	
				<th class="td_right"><em>*</em>单次最高交易手数：</th>
				<td style="text-align: left;" colspan="3">
					伦敦金:<input type="text" name="maxTradeNumLlg"  id="maxTradeNumLlg" value="${brokerExtInfo.maxTradeNumLlg}"/>
					伦敦银:<input type="text" name="maxTradeNumLls"  id="maxTradeNumLls" value="${brokerExtInfo.maxTradeNumLls}"/>
					港金:<input type="text" name="maxTradeNumHkg"  id="maxTradeNumHkg" value="${brokerExtInfo.maxTradeNumHkg}"/>
					人民币公斤条:<input type="text" name="maxTradeNumLkg"  id="maxTradeNumLkg" value="${brokerExtInfo.maxTradeNumLkg}"/>
				</td>			
			</tr>

			<tr>
				<th class="td_right"><em>*</em>持仓手数上线：</th>
				<td style="text-align: left;">
					<input type="text" name="maxHoldNum" id="maxHoldNum"  value="${brokerExtInfo.maxHoldNum }"/>
				</td>
				<th class="td_right"><em>*</em>杠杆比例：</th>
				<td style="text-align: left;">
					<input type="text" name="leverRate" id="leverRate"  value="${brokerExtInfo.leverRate }"/>
				</td>				
			</tr>			

			<tr>
				<th class="td_right"><em>*</em>客户回佣：</th>
				<td style="text-align: left;">
					<select id="isReturnCommission" name="isReturnCommission">
						<option value="">--请选择--</option>
					    <option value="0" <c:if test="${'0' == brokerExtInfo.isReturnCommission }">selected</c:if>>不提供</option>
					    <option value="1" <c:if test="${brokerExtInfo.id == null || '1' == brokerExtInfo.isReturnCommission }">selected</c:if>>提供</option>
					</select>
				</td>			
				<th class="td_right"><em>*</em>交易编码：</th>
				<td style="text-align: left;">
					<select id="isTradeCode" name="isTradeCode">
						<option value="">--请选择--</option>
					    <option value="0" <c:if test="${'0' == brokerExtInfo.isTradeCode }">selected</c:if>>不提供</option>
					    <option value="1" <c:if test="${brokerExtInfo.id == null || '1' == brokerExtInfo.isTradeCode }">selected</c:if>>提供</option>
					</select>
				</td>			
			</tr>
			
			<tr>	
				<th class="td_right"><em>*</em>返佣金额：</th>
				<td style="text-align: left;" colspan="3">
					欧美:<input type="text" name="commissionEurope"  id="commissionEurope" value="${brokerExtInfo.commissionEurope}"/>
					黄金:<input type="text" name="commissionGold"  id="commissionGold" value="${brokerExtInfo.commissionGold}"/>
					白银:<input type="text" name="commissionSilver"  id="commissionSilver" value="${brokerExtInfo.commissionSilver}"/>
					原油:<input type="text" name="commissionOil"  id="commissionOil" value="${brokerExtInfo.commissionOil}"/>
				</td>			
			</tr>
			
			<tr>
				<th class="td_right"><em>*</em>建仓手续费：</th>
				<td style="text-align: left;">
					<select id="isOpenFee" name="isOpenFee">
						<option value="">--请选择--</option>
					    <option value="0" <c:if test="${'0' == brokerExtInfo.isOpenFee }">selected</c:if>>不收取</option>
					    <option value="1" <c:if test="${brokerExtInfo.id == null || '1' == brokerExtInfo.isOpenFee }">selected</c:if>>收取</option>
					</select>
				</td>			
				<th class="td_right"><em>*</em>平仓手续费：</th>
				<td style="text-align: left;">
					<select id="isCloseFee" name="isCloseFee">
						<option value="">--请选择--</option>
					    <option value="0" <c:if test="${'0' == brokerExtInfo.isCloseFee }">selected</c:if>>不收取</option>
					    <option value="1" <c:if test="${brokerExtInfo.id == null || '1' == brokerExtInfo.isCloseFee }">selected</c:if>>收取</option>
					</select>
				</td>			
			</tr>
			
			<tr>
				<th class="td_right"><em>*</em>多仓利息：</th>
				<td style="text-align: left;">
					<input type="text" name="longRate" id="longRate" value="${brokerExtInfo.longRate }"/>
				</td>
				<th class="td_right"><em>*</em>空仓利息：</th>
				<td style="text-align: left;">
					<input type="text" name="shortRate" id="shortRate" value="${brokerExtInfo.shortRate }"/>
				</td>
			</tr>
			
			<tr>	
				<th class="td_right"><em>*</em>开仓保证金：</th>
				<td style="text-align: left;" colspan="3">
					伦敦金:<input type="text" name="openMoneyLlg"  id="openMoneyLlg" value="${brokerExtInfo.openMoneyLlg}"/>
					伦敦银:<input type="text" name="openMoneyLls"  id="openMoneyLls" value="${brokerExtInfo.openMoneyLls}"/>
					港金:<input type="text" name="openMoneyHkg"  id="openMoneyHkg" value="${brokerExtInfo.openMoneyHkg}"/>
					人民币公斤条:<input type="text" name="openMoneyLkg"  id="openMoneyLkg" value="${brokerExtInfo.openMoneyLkg}"/>
				</td>			
			</tr>
			
			<tr>
				<th class="td_right"><em>*</em>强平百分比（平日）：</th>
				<td style="text-align: left;">
					<input type="text" name="closeRate" id="closeRate" value="${brokerExtInfo.closeRate }"/>
				</td>
				<th class="td_right"><em>*</em>强平百分比（周末/假期）：</th>
				<td style="text-align: left;">
					<input type="text" name="closeRateExt" id="closeRateExt" value="${brokerExtInfo.closeRateExt }"/>
				</td>
			</tr>
			
			<tr>
				<th class="td_right"><em>*</em>EA支援：</th>
				<td style="text-align: left;">
					<select id="isEaSupport" name="isEaSupport">
						<option value="">--请选择--</option>
					    <option value="0" <c:if test="${brokerExtInfo.id == null || '0' == brokerExtInfo.isEaSupport }">selected</c:if>>不支援</option>
					    <option value="1" <c:if test="${'1' == brokerExtInfo.isEaSupport }">selected</c:if>>支援</option>
					</select>					
				</td>
				<th class="td_right"><em>*</em>公司推荐值：</th>
				<td style="text-align: left;">
					<input type="text" name="companyIndex" id="companyIndex" value="${brokerExtInfo.companyIndex }"/>
				</td>
			</tr>
			
			<tr>
		 		<th>LOGO图片</th>
				<td style="text-align: left;" colspan="3">
					<input type='file' id="image" name="file"/><br>
					宽：<input type="text" name="imageWidth" value="300"> <br/>
					高：<input type="text" name="imageHeight" value="300"> <br>
   					<img id="blah" src="${ctx}/${brokerExtInfo.imageUrl}" alt="图片预览" />						
				</td>			
			</tr>
			
			<tr >
				<td colspan="4" style="text-align: center;">
				   <c:choose>
				     <c:when test="${brokerExtInfo.id == null || brokerExtInfo.id == '' }">
				        <button name="post_button" class="btn btn-success">
							<i class="icon-ok icon-white"></i> 新增
						</button>
				     </c:when>
				     <c:otherwise>
				        <button name="post_button" class="btn btn-success" name="postData_button">
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
