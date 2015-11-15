<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>

<!DOCTYPE html>
<html>
<head>
<%@ include file="../common/common.jsp"%>
<%@ include file="../common/common_html_validator.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/My97DatePicker/WdatePicker.js"></script>

<script type="text/javascript" src="${ctx }/static/dmuploader/dmuploader.min.js"></script>

<title>审批证明资料</title>
<link rel="stylesheet" href="${ctx }/static/css/lgl.css"  type="text/css">

<style type="text/css">
	
	.l_form table input {
		height: auto;
	}
	
	
	.fl {
	  float: left !important;
	}
	
	.fr {
	  float: right !important;
	}
	
	.f_content{
		font-size: 14px;
	}
	
	.f_content label {
		display: inline;
		margin: 0 5px;
	}
	
</style>

<script type="text/javascript">
$(function(){
	
});

function checkCheckAll(){
	var brokerInfoId  = $('input[name="brokerInfoId"]:checked').val();
	var email = $('input[name="email"]:checked').val();
	var mt4Card = $('input[name="mt4Card"]:checked').val();
	var bankCard = $('input[name="bankCard"]:checked').val();
	var bankName = $('input[name="bankName"]:checked').val();
	var name = $('input[name="name"]:checked').val();
	
	var type = 'yes';
	
	if(brokerInfoId == '0'){
		type = 'no';
	}else if(brokerInfoId == '1'){
	}else{
		layer.alert('开户平台未核对');
		return '';
	}
	
	if(email == '0'){
		type = 'no';
	}else if(email == '1'){
	}else{
		layer.alert('开户邮箱未核对');
		return '';
	}
	
	if(mt4Card == '0'){
		type = 'no';
	}else if(mt4Card == '1'){
	}else{
		layer.alert('MT4账号未核对');
		return '';
	}
	
	if(bankCard == '0'){
		type = 'no';
	}else if(bankCard == '1'){
	}else{
		layer.alert('银行卡号未核对');
		return '';
	}
	
	if(bankName == '0'){
		type = 'no';
	}else if(bankName == '1'){
	}else{
		layer.alert('开户银行未核对');
		return '';
	}
	
	if(name == '0'){
		type = 'no';
	}else if(name == '1'){
	}else{
		layer.alert('开户姓名未核对');
		return '';
	}
	
	return type;
}

function myPass(){
	
	var type = checkCheckAll();
	if(!type){
		return;
	}
	
	if(type == 'no'){
		layer.alert('上述资料未全部通过');
		return;
	}
	
	var posIds = new Array();
	posIds.push('${pbd.id}');
	
	layer.confirm('确定要提案通过吗？', function(){
		
		$.ajax({
			url : '${ctx}/mem/pos/ajax/back_discount/pass',
			async : false,
			traditional : true,
			data : {
				posIds : posIds
			},
			success : function(result){
				if(result.success){
					layer.alert('操作成功', function(){
						window.location.href = '${ctx}/mem/pos/back_discount_list';
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
	
	var type = checkCheckAll();
	if(!type){
		return;
	}
	
	if(type == 'yes'){
		layer.alert('上述资料请至少选择一个审核未通过项');
		return;
	}
	
	var brokerInfoId  = $('input[name="brokerInfoId"]:checked').val();
	var email = $('input[name="email"]:checked').val();
	var mt4Card = $('input[name="mt4Card"]:checked').val();
	var bankCard = $('input[name="bankCard"]:checked').val();
	var bankName = $('input[name="bankName"]:checked').val();
	var name = $('input[name="name"]:checked').val();
	
	var msg = '';
	if(brokerInfoId == '0'){
		msg += '开户平台，'; 
	}
	if(email == '0'){
		msg += '开户邮箱，';
	}
	if(mt4Card == '0'){
		msg += 'MT4账号，';
	}
	if(bankCard == '0'){
		msg += '银行卡号，';
	}
	if(bankName == '0'){
		msg += '开户银行，';
	}
	if(name == '0'){
		msg += '开户姓名，';
	}
	msg += '核对未通过';
	
	var posIds = new Array();
	posIds.push('${pbd.id}');
	
	layer.confirm('确定要提案拒绝吗？', function(){
		
		$.ajax({
			url : '${ctx}/mem/pos/ajax/back_discount/cancel',
			async : false,
			traditional : true,
			data : {
				posIds : posIds,
				msg : msg
			},
			success : function(result){
				if(result.success){
					layer.alert('操作成功', function(){
						window.location.href = '${ctx}/mem/pos/back_discount_list';
					});
				}else{
					layer.alert(result.msg);
				}
			}
		});
		
	}, function(){
		
	});
	
}


</script>
</head>

<body>

	<div class="l_main">
		<div class="l_titlebar">
			<div class="l_text">审批返佣申请</div>
		</div>
		
		
		
		<form id="myForm" method="post">
			<input type="hidden" id="posId" value="${pbd.id }"/>
			<div class="l_form mgt20">
					<table>
						<tbody>
							<tr>
								<td class="f_title wd200">提案号：</td>
								<td class="f_content wd300">${pbd.proposalNo }</td>
								<td class="f_content">
									
								</td>
							</tr>
							<tr>
								<td class="f_title wd200">开户平台：</td>
								<td class="f_content wd300">${pbd.brokerInfo.cnName }</td>
								<td class="f_content">
									<label>
										<input type="radio" name="brokerInfoId" value="1"/>正确
									</label>
									<label>
										<input type="radio" name="brokerInfoId" value="0"/>错误
									</label>
								</td>
							</tr>
							<tr>								
								<td class="f_title wd200">开户邮箱：</td>
								<td class="f_content wd300">${pbd.email }</td>
								<td class="f_content">
									<label>
										<input type="radio" name="email" value="1"/>正确
									</label>
									<label>
										<input type="radio" name="email" value="0"/>错误
									</label>
								</td>
							</tr>
							<tr>
								<td class="f_title">MT4账号：</td>
								<td class="f_content">${pbd.mt4Card }</td>
								<td class="f_content">
									<label>
										<input type="radio" name="mt4Card" value="1"/>正确
									</label>
									<label>
										<input type="radio" name="mt4Card" value="0"/>错误
									</label>
								</td>
							</tr>
							<tr>
								<td class="f_title">银行卡号：</td>
								<td class="f_content">${pbd.bankCard }</td>
								<td class="f_content">
									<label>
										<input type="radio" name="bankCard" value="1"/>正确
									</label>
									<label>
										<input type="radio" name="bankCard" value="0"/>错误
									</label>
								</td>
								
							</tr>
							<tr>
								<td class="f_title">开户银行：</td>
								<td class="f_content">${pbd.bankName }</td>
								<td class="f_content">
									<label>
										<input type="radio" name="bankName" value="1"/>正确
									</label>
									<label>
										<input type="radio" name="bankName" value="0"/>错误
									</label>
								</td>
								
							</tr>
							
							<tr>
								
								<td class="f_title">开户姓名：</td>
								<td class="f_content">${pbd.name }</td>
								<td class="f_content">
									<label>
										<input type="radio" name="name" value="1"/>正确
									</label>
									<label>
										<input type="radio" name="name" value="0"/>错误
									</label>
								</td>
								
							</tr>
							
						</tbody>
					</table>
			</div>
		</form>
	
		
	
		<div class="l_btnGrounp mgt20">
			<a class="b_btn" href="javascript:myPass();">通过</a>
			<a class="b_btn orange" href="javascript:myCancel();">拒绝</a>
			
			<a class="b_btn gray" href="${ctx}/mem/pos/back_discount_list">返回</a>
			
		</div>
		
</div>

</body>
</html>
