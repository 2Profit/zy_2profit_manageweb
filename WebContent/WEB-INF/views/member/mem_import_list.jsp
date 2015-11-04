<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page session="false" %>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>批量导入</title>
<%@ include file="../common/common.jsp"%>

<script type="text/javascript" src="${ctx }/static/js/manage-web-common.js"/></script>

<link rel="stylesheet" href="${ctx }/static/css/lgl.css"  type="text/css">

<style type="text/css">
input{
  background-color: #fff;
  border: 1px solid #ccc;
  box-shadow: inset 0 1px 1px rgba(0,0,0,0.075);
  transition: border linear .2s,box-shadow linear .2s;
  border-radius: 4px;
  padding: 4px 6px;
  margin-bottom: 10px
}

input,select {
	margin-bottom: 0px;
}

</style>

<script type="text/javascript">

var categoryObj = new Object();
var typeObj = new Object();
var sexObj = new Object();
var cardTypeObj = new Object();
var nationalityObj = new Object();
var statusObj = new Object();

$(function(){
	
	$('#modTab select[data-name="accountCategory"] option').each(function(idx, obj){
		categoryObj[$(obj).text()] = $(obj).attr('value');
	});

	$('#modTab select[data-name="accountType"] option').each(function(idx, obj){
		typeObj[$(obj).text()] = $(obj).attr('value');
	});

	sexObj['男'] = 0;
	sexObj['女'] = 1;
	
	$('#modTab select[data-name="cardType"] option').each(function(idx, obj){
		if($(obj).attr('value')){
			cardTypeObj[$(obj).text()] = $(obj).attr('value');
		}
	});
	
	$('#modTab select[data-name="nationalityId"] option').each(function(idx, obj){
		if($(obj).attr('value')){
			nationalityObj[$(obj).text()] = $(obj).attr('value');
		}
	});

	$('#modTab select[data-name="status"] option').each(function(idx, obj){
		if($(obj).attr('value')){
			statusObj[$(obj).text()] = $(obj).attr('value');
		}
	});
	
	
	$('#myForm input[name="file"]').on('change', function(){
		
		if(!$(this).val()){
			return;
		}
		
		var $content = $('#content').html('');
		
		layer.load();
		$('#myForm').ajaxSubmit({
			url : '${ctx}/member/ajax/upload/import_file',
			success : function(result){
				layer.closeAll('loading');
				if(result.success){
					if(result.data){
						var len = result.data.length;
						$.each(result.data, function(idx, obj){
							var $tr = genTr(idx, obj);
							$content.append($tr);
							var closeLoading = false;
							if(idx == (len - 1)){
								closeLoading = true;
							}
							importOneData($tr, closeLoading);
													
						});
					}
				}else{
					layer.alert(result.msg);
				}
			}
		});
	});
	
});

function setMsg(){
	var size = $('#content tr').length;
	var importNum = $('#content tr[data-status="1"]').length;
	var noImportNum = $('#content tr[data-status="0"]').length;
	
	$('#msg').text('共：'+size+'条，导入成功：'+importNum+'条，导入失败：'+noImportNum+'条');
}

function genTr(idx, obj){
	
	//
	obj[1] = categoryObj[obj[1]];
	obj[2] = typeObj[obj[2]];
	obj[5] = sexObj[obj[5]];
	obj[7] = cardTypeObj[obj[7]];
	obj[9] = nationalityObj[obj[9]];
	obj[14] = statusObj[obj[14]];
	
	var $tr = $($.parseHTML($('#modTab').html(), document, true));
	
	$tr.find('input[data-name="mobile"]').val(obj[0]);
	if(obj[1]){
		$tr.find('select[data-name="accountCategory"]').val(obj[1]);
	}else{
		$tr.find('select[data-name="accountCategory"]').val('0');
	}
	
	if(obj[2]){
		$tr.find('select[data-name="accountType"]').val(obj[2]);
	}else{
		$tr.find('select[data-name="accountType"]').val('1');
	}
	
	$tr.find('input[data-name="cnName"]').val(obj[3]);
	
	$tr.find('input[data-name="nickName"]').val(obj[4]);
	
	$tr.find('input[data-name="sex"]').attr('name', idx);
	
	$tr.find('input[data-name="sex"][value="'+obj[5]+'"]').click();
	$tr.find('input[data-name="email"]').val(obj[6]);
	
	if(obj[7]){
		$tr.find('select[data-name="cardType"]').val(obj[7]);
	}
	
	$tr.find('input[data-name="card"]').val(obj[8]);
	
	if(obj[9]){
		$tr.find('select[data-name="nationalityId"]').val(obj[9]);
	}
	
	if(!obj[10]){
		obj[10] = '12345678';
	}
	$tr.find('input[data-name="pwd"]').val(obj[10]);
	
	$tr.find('input[data-name="bankAccount"]').val(obj[11]);
	$tr.find('input[data-name="bankCardNum"]').val(obj[12]);
	$tr.find('input[data-name="bankAddress"]').val(obj[13]);
	
	if(obj[14]){
		$tr.find('select[data-name="status"]').val(obj[14]);
	}else{
		$tr.find('select[data-name="status"]').val('0');
	}
	
	$tr.find('input[data-name="address"]').val(obj[15]);
	
	return $tr;
}

function myImport(){
	
	$('#myForm input[name="file"]').val('').click();
	
}

function importTr(_this){
	var $tr = $(_this).parent().parent();
	layer.load();
	importOneData($tr, true);
}

var RE_MOBILE = /^1[3-9]\d{9}$/;
var RE_PWD = /^[0-9a-zA-Z]{8,16}$/;
var RE_EMAIL = /^(?:[a-z0-9]+[_\-+.]?)*[a-z0-9]+@(?:([a-z0-9]+-?)*[a-z0-9]+\.)+([a-z]{2,})+$/i;

function importOneData($tr, closeLoading){
	
	var data = new Object();
	
	data['type'] = 'add';
	
	data['mobile'] = $tr.find('input[data-name="mobile"]').val();
	data['accountCategory'] = $tr.find('select[data-name="accountCategory"]').val();
	
	data['accountType'] = $tr.find('select[data-name="accountType"]').val();
	
	data['cnName'] = $tr.find('input[data-name="cnName"]').val();
	data['nickName'] = $tr.find('input[data-name="nickName"]').val();
	
	data['sex'] = $tr.find('input[data-name="sex"]:checked').val();
	data['email'] = $tr.find('input[data-name="email"]').val();
	data['cardType'] = $tr.find('select[data-name="cardType"]').val();
	data['card'] = $tr.find('input[data-name="card"]').val();
	data['nationalityId'] = $tr.find('select[data-name="nationalityId"]').val();
	data['pwd'] = $tr.find('input[data-name="pwd"]').val();
	
	data['bankAccount'] = $tr.find('input[data-name="bankAccount"]').val();
	data['bankCardNum'] = $tr.find('input[data-name="bankCardNum"]').val();
	data['bankAddress'] = $tr.find('input[data-name="bankAddress"]').val();
	data['status'] = $tr.find('select[data-name="status"]').val();
	data['address'] = $tr.find('input[data-name="address"]').val();
	
	for(var i in data){
		data[i] = $.trim(data[i]);
	}
	
	//判读数据合法性  手机号码和密码
	var msg = '';
	
	if(data['mobile']){
		if(!RE_MOBILE.test(data['mobile'])){
			msg += '手机号码格式不正确;';
		}
	}else{
		msg += '手机号码不能为空;';
	}
	
	if(data['pwd']){
		if(!RE_PWD.test(data['pwd'])){
			msg += '密码由8-16位数字、字母组成;';
		}
	}else{
		msg += '密码不能为空;';
	}
	
	if(data['email']){
		if(!RE_EMAIL.test(data['email'])){
			msg += '邮箱格式不正确;';
		}
	}
	
	var re = false;
	
	if(msg){
		$tr.find('td[data-name="error"]').text(msg);
		if(closeLoading){
			layer.closeAll('loading');	
		}
		return re;
	}
	
	$.ajax({
		url : '${ctx}/member/ajax/save/member/pos',
		async : false,
		type : 'post',
		data : data,
		success : function(result){
			if(result.success){
				re = true;
				$tr.find('td[data-name="do"] a[data-name="importBtn"]').remove();
				$tr.attr('data-status', 1);
				$tr.find('td[data-name="importStatus"]').html('<font color="green">已导入</font>');
				$tr.find('td[data-name="memberNo"]').text(result.data);
				$tr.find('td[data-name="error"]').text('');
			}else{
				$tr.find('td[data-name="error"]').text(result.msg);
				re = false;
			}
			if(closeLoading){
				setMsg();
				layer.closeAll('loading');	
			}
		}
	});
	
	return re;
}

function deleteTr(_this){
	$(_this).parent().parent().remove();
}

function myDelete(){
	$('#content tr').each(function(idx, obj){
		if($(obj).attr('data-status') == '1'){
			$(obj).remove();
		}
	});
}

</script>
</head>

<body>

	<div class="l_main">
		<div class="l_titlebar">
			<div class="l_text">
				批量添加会员
			</div>
		</div>
		<div class="">
			<div class="l_toolBar">
				<div class="form-inline">
					
				</div>
			</div>
			<div style="display: none;">
				<form id="myForm" method="post" enctype="multipart/form-data">
					<input type="file" name="file" style="opacity: .0;">
				</form>
			</div>
			<div class="l_toolbar">
				<a class="btn btn-success" href="javascript:void(0);" onclick="myImport()">
					<i class="icon-plus-sign icon-white"></i> 导入EXCEL
				</a>
				<a class="btn btn-success" href="javascript:void(0);" onclick="myDelete()">删除已导入记录</a>
				
				<a class="btn btn-success" href="${ctx }/member/download/template">下载模板</a>
			</div>
			<div class="l_toolbar mgt20">
				<label id="msg" style="color: red;">共：0条，导入成功：0条，导入失败：0条</label>
			</div>
		</div>
	
		<div class="l_table mgt20">
			<table class="table table-bordered table-hover" style="width: 2500px;table-layout: fixed;">
				<thead>
					<tr>
						<!-- <th>
							<input type="checkbox" name="checkAll" onclick="checkAllClick(this, 'chk')"/>
						</th> -->
						<th width="50">操作</th>
						<th width="50">导入状态</th>
						<th width="100">未导入原因</th>
						<th width="60">会员编号</th>
						<th width="100">手机号码</th>
						<th width="50">账号类别</th>
						<th width="50">账号类型</th>
						<th width="80">姓名</th>
						<th width="80">昵称</th>
						<th width="50">性别</th>
						<th width="100">邮箱</th>
						<th width="100">证件类型</th>
						<th width="120">证件编号</th>
						<th width="60">国家地区</th>
						<th width="80">密码</th>
						<th width="100">银行名称</th>
						<th width="100">银行账号</th>
						<th width="80">账户持有人</th>
						<th width="60">状态</th>
						<th width="150">联系地址</th>
					</tr>
				</thead>
				<tbody id="content">
					
				</tbody>
			</table>
		</div>
		
	</div>

	<table style="display: none;">
		<tbody id="modTab">
		<tr data-status="0">
			<td data-name="do" >
				<a href="javascript:void(0);" onclick="deleteTr(this)" data-name="delBtn">删除</a>
				<a href="javascript:void(0);" onclick="importTr(this)" data-name="importBtn">导入</a>
			</td>
			<td data-name="importStatus"><font color="red">未导入</font></td>
			<td data-name="error"></td>
			<td data-name="memberNo"></td>
			<td><input data-name="mobile" class="wd120"/></td>
			<td>
				<select data-name="accountCategory" style="width: auto;">
					<option value="0">客户</option>
					<option value="1">老师</option>
				</select>
			</td>
			<td>
				<select data-name="accountType" style="width: auto;">
					<option value="0">真实</option>
					<option value="1">测试</option>
				</select>
			</td>
			<td><input data-name="cnName" class="wd80"/></td>
			<td><input data-name="nickName" class="wd80"/></td>
			<td>
				<input type="radio" data-name="sex" value="0">男
				<input type="radio" data-name="sex" value="1">女
			</td>
			<td><input data-name="email" class="wd120"/></td>
			<td>
				<select data-name="cardType" style="width: auto;">
					<option value="">请选择</option>
					<c:forEach items="${cardTypes }" var="ct">
						<option value="${ct.key }">${ct.value }</option>
					</c:forEach>
				</select>
			</td>
			<td><input data-name="card" class="wd150"/></td>
			<td>
				<select data-name="nationalityId" style="width: auto;">
					<option value="">请选择</option>
					<c:forEach items="${nationalities }" var="n">
						<option value="${n.id }">${n.name }</option>
					</c:forEach>
				</select>
			</td>
			<td><input data-name="pwd" class="wd80"/></td>
			<td><input data-name="bankAccount" class="wd120"/></td>
			<td><input data-name="bankCardNum" class="wd120"/></td>
			<td><input data-name="bankAddress" class="wd80"/></td>
			<td>
				<select data-name="status" style="width: auto;">
					<option value="0">启用</option>
				    <option value="1">冻结</option>
				    <option value="2">黑名单</option>
				    <option value="3">销户</option>
				</select>
			</td>
			<td><input data-name="address" class="wd150"/></td>
		</tr>
		</tbody>
	</table>
</body>
</html>
