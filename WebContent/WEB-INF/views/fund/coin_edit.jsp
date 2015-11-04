<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../common/common.jsp" %>

<%@ include file="../common/common_html_validator.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>

<link rel="stylesheet" href="${ctx }/static/css/lgl.css"  type="text/css">

<script type="text/javascript">

$(function(){
	
	var type = '${type}';
	
	
	$('#myForm').validator({
		fields : {
			coin : 'required;integer[*]',
		},
		valid : function(form){
			var memberId = $('input[name="memberId"]').val();
			if(!memberId){
				layer.alert('请先查询出会员信息');
				return;
			}
			layer.load();
			$(form).ajaxSubmit({
				url : '${ctx }/pos/coin/ajax/save',
				async : false,
				success : function(result){
					layer.closeAll('loading');
					if(result.success){
						if(type == 'add'){
							layer.alert('添加成功', function(){
								window.location.href = '${ctx}/pos/coin/list';
							});
						}else if(type == 'update'){
							layer.alert('修改成功', function(){
								window.location.href = '${ctx}/pos/coin/list';
							});
						}
						
					}else{
						layer.alert(result.msg);
					}
				}
			});
		}
	});
	
	
});

function mySubmit(){
	$('#myForm').submit();
}

function findMember(){
	
	//var $memberId = $('input[name="memberId"]').val('');
	
	var username = $('input[name="username"]').val().trim();
	if(!username){
		layer.alert('请输入会员账号');
		return;
	}
	
	$.ajax({
		url : '${ctx}/fund/ajax/find/member',
		type : 'post',
		data : {
			username : username
		},
		success : function(result){
			if(result.success){
				var obj = result.data;
				if(obj){
					$('input[name="memberId"]').val(obj.id);
					$('input[name="memberNo"]').val(obj.no);
					$('input[name="mobile"]').val(obj.mobile);
					$('input[name="cnName"]').val(obj.cnName);
				}else{
					layer.alert('账号不存在');
				}
			}else{
				layer.alert(result.msg);
			}
		}
	});
	
}


function myPass(){
	var posIds = new Array();
	posIds.push('${p.id}');
	
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
						window.location.href = '${ctx}/pos/coin/list';
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
	var posIds = new Array();
	posIds.push('${p.id}');
	
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
						window.location.href = '${ctx}/pos/coin/list';
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
			<div class="l_text">
			<c:choose>
				<c:when test="${type eq 'add' }">
					添加额度调整提案
				</c:when>
				<c:when test="${type eq 'update' }">
					修改
				</c:when>
				<c:when test="${type eq 'pos' }">
					审批额度调整提案
				</c:when>
				<c:otherwise>
					预览
				</c:otherwise>
			</c:choose>
			</div>
		</div>
		<form id="myForm" method="post">
		<div class="l_form mgt20">
			<input type="hidden" name="type" value="${type }"/>
			<input type="hidden" name="id" value="${p.id }"/>
			<table>
				<tbody>
					<c:if test="${type ne 'add' }">
						<tr>
							<td class="f_title wd200">提案号：</td>
							<td class="f_content">
								<label>${p.proposalNo }</label>
							</td>
						</tr>
					</c:if>
					<c:if test="${type eq 'add' }">
						<tr>
							<td class="f_title wd200">会员账号：</td>
							<td class="f_content">
								<input type="text" name="username" value="" placeholder="会员编号或手机号码" onblur="findMember()"/>
								<input type="hidden" name="memberId" value=""/>
								<a class="btn" href="javascript:findMember();">查询</a>
							</td>
						</tr>
					</c:if>
					
					<tr>
						<td class="f_title">会员编号：</td>
						<td class="f_content">
							<input type="text" name="memberNo" value="${p.member.no }" readonly="readonly">
						</td>
					</tr>
					<tr>
						<td class="f_title">会员姓名：</td>
						<td class="f_content">
							<input type="text" name="cnName" value="${p.member.cnName }" readonly="readonly">
						</td>
					</tr>
					<tr>
						<td class="f_title">手机号码：</td>
						<td class="f_content">
							<input type="text" name="mobile" value="${p.member.mobile }" readonly="readonly">
						</td>
					</tr>
					
					<tr>
						<td class="f_title">调整额度：</td>
						<td class="f_content">
							<input type="text" name="coin" value="${p.coin }"/>
						</td>
					</tr>
					
				</tbody>
			</table>
		</div>
		</form>
		
		<div class="l_btnGrounp mgt20">
			<c:choose>
				<c:when test="${type eq 'add' }">
					<a class="b_btn" href="javascript:mySubmit();">保存</a>
				</c:when>
				<c:when test="${type eq 'update' }">
					<a class="b_btn" href="javascript:mySubmit();">修改</a>
				</c:when>
				<c:when test="${type eq 'pos' }">
					<a class="b_btn" href="javascript:myPass();">通过</a>
					<a class="b_btn orange" href="javascript:myCancel();">拒绝</a>
				</c:when>
			</c:choose>
			
			<a class="b_btn gray" href="${ctx }/fund/pay/list">返回</a>
		</div>
		
	</div>

</body>
</html>