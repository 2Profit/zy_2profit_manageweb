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

<title>添加用户</title>
<link rel="stylesheet" href="${ctx }/static/css/lgl.css"  type="text/css">

<style type="text/css">
	
	.l_form table input {
		height: auto;
	}
	
	.J_picBox { }
    .J_picBox .p_item { float: left; width: 320px; }
        .J_picBox .p_item .i_inner { position: relative; padding: 6px; margin: 0 20px; border: 1px solid #ddd; background-color: #f9f9f9; }
            .J_picBox .p_item .i_inner .i_pic { margin-top: 6px; min-height: 166px; }
                .J_picBox .p_item .i_inner .i_pic img { width: 100%; vertical-align: top; }

            .J_picBox .p_item .i_inner .i_status { margin-top: 6px; }
                .J_picBox .p_item .i_inner .i_status i { vertical-align: middle; font-size: 16px; }
            .J_picBox .p_item .i_inner .i_mask { height: 30px; line-height: 30px; color: #333; }
                .J_picBox .p_item .i_inner .i_mask .abtn { display: inline-block; *zoom: 1; *display: inline; margin-right: 6px; padding: 0 10px; height: 22px; line-height: 22px; border-radius: 3px; color: #fff; }
	
	.fl {
	  float: left !important;
	}
	
	.fr {
	  float: right !important;
	}
	
	
</style>

<c:if test="${type eq 'pos' }">
<style type="text/css">
body {
	width: 1700px
}
</style>
</c:if>

<script type="text/javascript">
$(function(){
	
	//设置值
	$('select[name="accountCategory"]').val('${member.accountCategory}');
	$('select[name="accountType"]').val('${member.accountType}');
	$('select[name="cardType"]').val('${member.cardType}');
	$('select[name="nationalityId"]').val('${member.nationality.id}');
	$('select[name="status"]').val('${member.status}');
	
	$('input[name="sex"][value="${member.sex}"]').click();
	
	//上传文件
	$('#uploadImg').dmUploader({
		url : '${ctx}/member/ajax/upload/img',
		maxFileSize : 5*1024*1024,
		maxFiles : 1,
		extFilter : 'jpg;png;gif;bmp;tif',
		dataType : 'json',
		onBeforeUpload : function(){
			layer.load();
		},
		onComplete : function(){
			layer.closeAll('loading');
		},
		onUploadSuccess : function(id, result){
			if(result.success){
				var paramName = $('#paramName').val();
				$('img[data-param-name="'+paramName+'"]').attr('src', '${ctx}' + result.data);
				$('input[name="'+paramName+'"]').val(result.data);
			}else{
				layer.alert(result.msg);
			}
		},
		onFileSizeError : function(file){
			layer.alert('只能上传小于5M的图片');
		},
		onFileExtError : function(file){
			layer.alert('只支持上传pg\gif\bmp\png\tif格式图片');
		}
	});
	
	<c:if test="${type ne 'pos' }">
	$('#myForm').validator({
		rules : {
			mypwd : [/^[0-9a-zA-Z]{8,16}$|[#]{8}/, "密码由8-16位数字、字母组成"]
		},
		fields : {
			mobile : 'required;mobile;',
			accountCategory : 'required',
			accountType : 'required',
			cnName : 'length[~64, true]',
			nickName : 'length[~64, true]',
			email : 'email',
			card : 'length[~64, true]',
			address : 'length[~512, true]',
			bankAccount : 'length[~64, true]',
			bankCardNum : 'length[~64, true]',
			bankAddress : 'length[~512, true]',
			status : 'required',
			pwd : 'mypwd'
		},
		valid : function(form){
			layer.load();
			$(form).ajaxSubmit({
				url : '${ctx}/member/ajax/save/member/pos',
				type : 'post',
				async : false,
				success : function(result){
					layer.closeAll('loading');
					if(result.success){
						if('add' == '${type}'){
							layer.alert('保存会员提案成功', function(){
								window.location.href = '${ctx }/member/list';
							});
						}else{
							layer.alert('修改会员提案成功', function(){
								window.location.href = '${ctx }/member/list';
							});
						}
					}else{
						layer.alert(result.msg);
					}
				}
			});
		}
	});
	</c:if>
	
	if('pos' == '${type}'){
		setPosVal();
	}
	
});

function mySubmit(){
	$('#myForm').submit();
}

function uploadImg(_this, paramName){
	$('#paramName').val(paramName);
	$('#uploadImg input[type="file"]').click();
}

function myPass(){
	var posIds = new Array();
	posIds.push('${pmm.id}');
	
	layer.confirm('确定要提案通过吗？', function(){
		
		$.ajax({
			url : '${ctx}/mem/pos/ajax/pass',
			async : false,
			traditional : true,
			data : {
				posIds : posIds
			},
			success : function(result){
				if(result.success){
					layer.alert('操作成功', function(){
						window.location.href = '${ctx}/mem/pos/list';
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
	posIds.push('${pmm.id}');
	
	layer.confirm('确定要提案拒绝吗？', function(){
		
		$.ajax({
			url : '${ctx}/mem/pos/ajax/cancel',
			async : false,
			traditional : true,
			data : {
				posIds : posIds
			},
			success : function(result){
				if(result.success){
					layer.alert('操作成功', function(){
						window.location.href = '${ctx}/mem/pos/list';
					});
				}else{
					layer.alert(result.msg);
				}
			}
		});
		
	}, function(){
		
	});
	
}

/**
 * 设置提案的值
 */
function setPosVal(){
	$('input[data-pos-name="no"]').val('${pmm.no}');
	$('input[data-pos-name="mobile"]').val('${pmm.mobile}');
	$('select[data-pos-name="accountCategory"]').val('${pmm.accountCategory}');
	$('select[data-pos-name="accountType"]').val('${pmm.accountType}');
	$('input[data-pos-name="cnName"]').val('${pmm.cnName}');
	$('input[data-pos-name="nickName"]').val('${pmm.nickName}');
	$('input[data-pos-name="sex"][value="${pmm.sex}"]').click();
	$('input[data-pos-name="email"]').val('${pmm.email}');
	$('select[data-pos-name="cardType"]').val('${pmm.cardType}');
	$('input[data-pos-name="card"]').val('${pmm.card}');
	$('select[data-pos-name="nationalityId"]').val('${pmm.nationalityId}');
	$('select[data-pos-name="status"]').val('${pmm.status}');
	$('input[data-pos-name="address"]').val('${pmm.address}');
	$('input[data-pos-name="bankAccount"]').val('${pmm.bankAccount}');
	$('input[data-pos-name="bankCardNum"]').val('${pmm.bankCardNum}');
	$('input[data-pos-name="bankAddress"]').val('${pmm.bankAddress}');
	
	if('${pmm.imgIDCardA}'){
		$('img[data-pos-param-name="imgIDCardA"]').attr('src', '${ctx}${pmm.imgIDCardA}');
	}
	/* if('${pmm.imgIDCardB}'){
		$('img[data-param-name="imgIDCardB"]').attr('src', '${ctx}${pmm.imgIDCardB}');
	} */
	if('${pmm.imgBankCard}'){
		$('img[data-pos-param-name="imgBankCard"]').attr('src', '${ctx}${pmm.imgBankCard}');
	}
	
	if('${pmm.posType }' == '修改'){
		$('#myForm input, #myForm select').each(function(idx, obj){
			var pVal = $(obj).val();
			var name = $(obj).attr('name');
			if(name && name != 'sex'){
				var $mObj = $('*[data-pos-name="'+name+'"]');
				var val = $mObj.val();
				if(!pVal && !val){
				}else if(pVal != val){
					$(obj).css('border', '1px solid red');
					$mObj.css('border', '1px solid red');
				}
			}
		});
	}
		
}

</script>
</head>

<body>

	<div class="l_main">
		<div class="l_titlebar">
			<div class="l_text">
				<c:choose>
				<c:when test="${type eq 'add' }">
					添加会员
				</c:when>
				<c:when test="${type eq 'update' }">
					修改会员
				</c:when>
				<c:when test="${type eq 'pos' }">
					会员提案审批
				</c:when>
			</c:choose>
			</div>
		</div>
		
		
		
		<form id="myForm" method="post">
			<input type="hidden" name="type" value="${type }"/>
			<input type="hidden" name="memberId" value="${member.id }"/>
			<input type="hidden" id="posId" value="${pmm.id }"/>
			<div class="l_form mgt20" style="padding: 0px 5px;">
				<c:if test="${type eq 'pos' }">
				<div style="display: inline-block;border-right: 1px dashed #ddd;">
					<table>
						<tbody>
							<tr>
								<td class="f_content" style="font-size: 16px;text-align: center;" colspan="4">审批资料(类型：${pmm.posType })</td>
							</tr>
							<tr>
								<td class="f_title wd100">会员编号：</td>
								<td class="f_content wd300">
									${pmm.no }
								</td>
								<td class="f_title wd100">手机号码：</td>
								<td class="f_content wd300">
									<input data-pos-name="mobile" type="text"/>
								</td>
							</tr>
							<tr>
								
								<td class="f_title wd100">账号类别：</td>
								<td class="f_content">
									<select data-pos-name="accountCategory">
									    <option value="0">客户</option>
									    <option value="1">老师</option>
									</select>
								</td>
								
								<td class="f_title">账号类型：</td>
								<td class="f_content">
									<select data-pos-name="accountType">
									    <option value="0">真实</option>
									    <option value="1">测试</option>
									</select>
								</td>
								
							</tr>
							<tr>
								<td class="f_title">中文姓名：</td>
								<td class="f_content">
									<input type="text" data-pos-name="cnName"/>
								</td>
								<td class="f_title">昵称：</td>
								<td class="f_content">
									<input type="text" data-pos-name="nickName"/>
								</td>
							</tr>
							<tr>
								<td class="f_title">性别：</td>
								<td class="f_content">
									<div class="t_check">
										<label>
											<input type="radio" data-pos-name="sex" value="0"/>男
										</label>
										<label>
											<input type="radio" data-pos-name="sex" value="1"/>女
										</label>
									</div>
								</td>
								<td class="f_title">电子邮箱：</td>
								<td class="f_content">
									<input type="text" data-pos-name="email"/>
								</td>
								
							</tr>
							<tr>
								<td class="f_title">证件类型：</td>
								<td class="f_content">
									<select data-pos-name="cardType">
										<option value="">请选择</option>
										<option value="0">身份证</option>
										<option value="1">护照</option>
									</select>
								</td>
								
								<td class="f_title">证件编号：</td>
								<td class="f_content">
									<input type="text" data-pos-name="card"/>
								</td>
								
							</tr>
							
							<tr>
								
								<td class="f_title">国籍：</td>
								<td class="f_content">
									<select data-pos-name="nationalityId">
										<option value="">请选择</option>
										<c:forEach items="${nationalities }" var="n">
											<option value="${n.id }">${n.name }</option>
										</c:forEach>
									</select>
								</td>
								
								<td class="f_title">密码：</td>
								<td class="f_content">
									<input type="password" data-pos-name="pwd" value="########"/>
								</td>
							</tr>
							
							
							<tr>
								<td class="f_title">银行名称：</td>
								<td class="f_content">
									<input type="text" data-pos-name="bankAccount"/>
								</td>
								
								<td class="f_title">银行账号：</td>
								<td class="f_content">
									<input type="text" data-pos-name="bankCardNum"/>
								</td>
								
							</tr>
							<tr>
								<td class="f_title">账户持有人：</td>
								<td class="f_content">
									<input type="text" data-pos-name="bankAddress"/>
								</td>
								
								<td class="f_title">状态：</td>
								<td class="f_content">
									<select data-pos-name="status">
									    <option value="0">启用</option>
									    <option value="1">冻结</option>
									    <option value="2">黑名单</option>
									    <option value="3">销户</option>
									</select>
								</td>
							</tr>
							
							<tr>
								<td class="f_title">联系地址：</td>
								<td class="f_content" colspan="3">
									<input type="text" data-pos-name="address" style="width: 600px;"/>
								</td>
							</tr>
							
							
							<tr>
								<td class="f_title">身份证明：</td>
								<td class="f_content">
									<div class="J_picBox clearfix">
				                        <div class="p_item">
				                            <div class="i_inner">
				                                <div class="i_mask">
				                                    <div class="ml10 fl"></div>
			                            			<c:if test="${type ne 'pos' }">
				                                    <div class="fr">
				                                    	<a class="abtn orange" href="javascript:void(0)" onclick="uploadImg(this, 'imgIDCardA')">立即上传</a>
				                                    </div>
				                                    </c:if>				                                    
				                                </div>
				                                <div class="i_pic">
		                                			<img src="${ctx }/static/images/J_null.png" data-pos-param-name="imgIDCardA">
		                                			<input type="hidden" data-pos-name="imgIDCardA"/>
				                                </div>
				                            </div>
				                        </div>
				                    </div>
								</td>
								
								<td class="f_title">银行证明：</td>
								<td class="f_content">
									<div class="J_picBox clearfix">
										<div class="p_item">
				                            <div class="i_inner">
				                            	
				                                <div class="i_mask">
				                                    <div class="ml10 fl">
				                                    </div>
				                                    <c:if test="${type ne 'pos' }">
				                                    <div class="fr">
				                                    	<a class="abtn orange" href="javascript:void(0);" onclick="uploadImg(this, 'imgBankCard')">立即上传</a>
				                                    </div>
				                                    </c:if>				                                    
				                                </div>
				                                
				                                <div class="i_pic">
				                                	<img src="${ctx }/static/images/J_null.png" data-pos-param-name="imgBankCard">
				                                	<input type="hidden" data-pos-name="imgBankCard"/>
				                                </div>
				                            </div>
				                        </div>
									</div>
								</td>
								
							</tr>
							
						</tbody>
					</table>
				</div>
				</c:if>
				<div style="display: inline-block;">
					<table>
						<tbody>
							<c:if test="${type eq 'pos' }">
								<tr>
									<td align="center" class="f_title" style="font-size: 16px;text-align: center;" colspan="4">会员资料</td>
								</tr>
							</c:if>
							<tr>
								<td class="f_title wd100">会员编号：</td>
								<td class="f_content wd300">
									<c:choose>
										<c:when test="${type eq 'add' }">
											<input type="text" name="no" value="${no }" disabled="disabled"/>
											<input type="hidden" name="no" value="${no }"/>
										</c:when>
										<c:when test="${type eq 'update' }">
											<input type="text" name="no" value="${member.no }" disabled="disabled"/>
											<input type="hidden" name="no" value="${member.no }"/>
										</c:when>
										<c:when test="${type eq 'pos' }">
											${pmm.no }
										</c:when>
									</c:choose>
								</td>
								<td class="f_title wd100">手机号码：</td>
								<td class="f_content wd300">
									<input name="mobile" type="text" value="${member.mobile }"/>
								</td>
							</tr>
							<tr>
								
								<td class="f_title wd100">账号类别：</td>
								<td class="f_content">
									<select name="accountCategory">
									    <option value="0">客户</option>
									    <option value="1">老师</option>
									</select>
								</td>
								
								<td class="f_title">账号类型：</td>
								<td class="f_content">
									<select name="accountType">
									    <option value="0">真实</option>
									    <option value="1">测试</option>
									</select>
								</td>
								
							</tr>
							<tr>
								<td class="f_title">中文姓名：</td>
								<td class="f_content">
									<input type="text" name="cnName" value="${member.cnName }"/>
								</td>
								<td class="f_title">昵称：</td>
								<td class="f_content">
									<input type="text" name="nickName" value="${member.nickName }"/>
								</td>
							</tr>
							<tr>
								<td class="f_title">性别：</td>
								<td class="f_content">
									<div class="t_check">
										<label>
											<input type="radio" name="sex" value="0"/>男
										</label>
										<label>
											<input type="radio" name="sex" value="1"/>女
										</label>
									</div>
								</td>
								<td class="f_title">电子邮箱：</td>
								<td class="f_content">
									<input type="text" name="email" value="${member.email }"/>
								</td>
								
							</tr>
							<tr>
								<td class="f_title">证件类型：</td>
								<td class="f_content">
									<select name="cardType">
										<option value="">请选择</option>
										<option value="0">身份证</option>
										<option value="1">护照</option>
									</select>
								</td>
								
								<td class="f_title">证件编号：</td>
								<td class="f_content">
									<input type="text" name="card" value="${member.card }"/>
								</td>
								
							</tr>
							
							<tr>
								
								<td class="f_title">国籍：</td>
								<td class="f_content">
									<select name="nationalityId">
										<option value="">请选择</option>
										<c:forEach items="${nationalities }" var="n">
											<option value="${n.id }">${n.name }</option>
										</c:forEach>
									</select>
								</td>
								
								<td class="f_title">密码：</td>
								<td class="f_content">
									<c:choose>
										<c:when test="${type eq 'add' }">
											<input type="password" name="pwd" value="12345678"/>
										</c:when>
										<c:otherwise>
											<input type="password" name="pwd" value="########"/>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
							
							
							<tr>
								<td class="f_title">银行名称：</td>
								<td class="f_content">
									<input type="text" name="bankAccount" value="${member.memBankInfo.bankAccount }"/>
								</td>
								
								<td class="f_title">银行账号：</td>
								<td class="f_content">
									<input type="text" name="bankCardNum" value="${member.memBankInfo.bankCardNum }"/>
								</td>
								
							</tr>
							<tr>
								<td class="f_title">账户持有人：</td>
								<td class="f_content">
									<input type="text" name="bankAddress" value="${member.memBankInfo.bankAddress }"/>
								</td>
								
								<td class="f_title">状态：</td>
								<td class="f_content">
									<select name="status">
									    <option value="0">启用</option>
									    <option value="1">冻结</option>
									    <option value="2">黑名单</option>
									    <option value="3">销户</option>
									</select>
								</td>
							</tr>
							
							<tr>
								<td class="f_title">联系地址：</td>
								<td class="f_content" colspan="3">
									<input type="text" name="address" style="width: 600px;" value="${member.address }"/>
								</td>
							</tr>
							
							
							<tr>
								<td class="f_title">身份证明：</td>
								<td class="f_content">
									<div id="uploadImg" style="display: none;">
										<input type="hidden" id="paramName" value=""/>
										<input type="file" name="imgFile" multiple="multiple" style="opacity: .0;">
									</div>
									
									<div class="J_picBox clearfix">
				                        <div class="p_item">
				                            <div class="i_inner">
				                            	
				                                <div class="i_mask">
				                                    <div class="ml10 fl">
				                                    	<span>
				                                    		<c:if test="${not empty member }">
				                                    			<c:choose>
					                                    			<c:when test="${empty member.imgIDCardStatus or member.imgIDCardStatus eq 0 }">
					                                    				<label style="color: red;">未上传</label>
					                                    			</c:when>
					                                    			<c:when test="${member.imgIDCardStatus eq 1 }">
					                                    				<label style="color: green;">待审核</label>
					                                    			</c:when>
					                                    			<c:when test="${member.imgIDCardStatus eq 2 }">
					                                    				<label style="color: green;">有效</label>
					                                    			</c:when>
					                                    			<c:when test="${member.imgIDCardStatus eq 3 }">
					                                    				<label style="color: green;">审批未通过</label>
					                                    			</c:when>
					                                    		</c:choose>
				                                    		</c:if>
				                                    	</span>
				                                    </div>
				                                    <div class="fr">
				                                    	<c:if test="${type ne 'pos' }">
				                                    		<a class="abtn orange" href="javascript:void(0)" onclick="uploadImg(this, 'imgIDCardA')">立即上传</a>
				                                    	</c:if>
				                                    </div>
				                                </div>
				                                
				                                <div class="i_pic">
				                                	<c:choose>
				                                		<c:when test="${not empty member.imgIDCardA }">
				                                			<img src="${ctx }${member.imgIDCardA }" data-param-name="imgIDCardA">
				                                			<input type="hidden" name="imgIDCardA" value="${member.imgIDCardA }"/>
				                                		</c:when>
				                                		<c:otherwise>
				                                			<img src="${ctx }/static/images/J_null.png" data-param-name="imgIDCardA">
				                                			<input type="hidden" name="imgIDCardA"/>
				                                		</c:otherwise>
				                                	</c:choose>
				                                </div>
				                            </div>
				                        </div>
				                        <%-- <div class="p_item">
				                            <div class="i_inner">
				                                <div class="i_mask">
				                                    <div class="ml10 fl">身份证背面</div>
				                                    <div class="fr">
				                                    	<c:if test="${type ne 'pos' }">
				                                    		<a class="abtn orange" href="javascript:void(0);" onclick="uploadImg(this, 'imgIDCardB')">立即上传</a>
				                                    	</c:if>
				                                    </div>
				                                </div>
				                                <div class="i_pic">
				                                	<c:choose>
				                                		<c:when test="${not empty member.imgIDCardB }">
				                                			<img src="${ctx }${member.imgIDCardB }" data-param-name="imgIDCardB">
				                                			<input type="hidden" name="imgIDCardB" value="${member.imgIDCardB }"/>
				                                		</c:when>
				                                		<c:otherwise>
						                                	<img src="${ctx }/static/images/J_null.png" data-param-name="imgIDCardB">
						                                	<input type="hidden" name="imgIDCardB"/>
				                                		</c:otherwise>
				                                	</c:choose>
				                                </div>
				                            </div>
				                        </div> --%>
				                    </div>
								</td>
								
								<td class="f_title">银行证明：</td>
								<td class="f_content">
									<div class="J_picBox clearfix">
										<div class="p_item">
				                            <div class="i_inner">
				                            	
				                                <div class="i_mask">
				                                    <div class="ml10 fl">
				                                    	<span>
				                                    		<c:if test="${not empty member }">
				                                    			<c:choose>
					                                    			<c:when test="${empty member.imgBackCardStatus or member.imgBackCardStatus eq 0 }">
					                                    				<label style="color: red;">未上传</label>
					                                    			</c:when>
					                                    			<c:when test="${member.imgBackCardStatus eq 1 }">
					                                    				<label style="color: green;">待审核</label>
					                                    			</c:when>
					                                    			<c:when test="${member.imgBackCardStatus eq 2 }">
					                                    				<label style="color: green;">有效</label>
					                                    			</c:when>
					                                    			<c:when test="${member.imgBackCardStatus eq 3 }">
					                                    				<label style="color: green;">审批未通过</label>
					                                    			</c:when>
					                                    		</c:choose>
				                                    		</c:if>
				                                    	</span>
				                                    </div>
				                                    <div class="fr">
				                                    	<c:if test="${type ne 'pos' }">
				                                    		<a class="abtn orange" href="javascript:void(0);" onclick="uploadImg(this, 'imgBankCard')">立即上传</a>
				                                    	</c:if>
				                                    </div>
				                                </div>
				                                
				                                <div class="i_pic">
				                                	<c:choose>
				                                		<c:when test="${not empty member.imgBankCard }">
				                                			<img src="${ctx }${member.imgBankCard }" data-param-name="imgBankCard">
				                                			<input type="hidden" name="imgBankCard" value="${member.imgBankCard }"/>
				                                		</c:when>
				                                		<c:otherwise>
						                                	<img src="${ctx }/static/images/J_null.png" data-param-name="imgBankCard">
						                                	<input type="hidden" name="imgBankCard"/>
				                                		</c:otherwise>
				                                	</c:choose>
				                                </div>
				                            </div>
				                        </div>
									</div>
								</td>
								
							</tr>
							
							<%-- <tr>
								<td class="f_title">银行证明：</td>
								<td class="f_content">
									<div class="J_picBox clearfix">
										<div class="p_item">
				                            <div class="i_inner">
				                                <div class="i_mask">
				                                    <div class="ml10 fl">银行证明</div>
				                                    <div class="fr">
				                                    	<c:if test="${type ne 'pos' }">
				                                    		<a class="abtn orange" href="javascript:void(0);" onclick="uploadImg(this, 'imgBankCard')">立即上传</a>
				                                    	</c:if>
				                                    </div>
				                                </div>
				                                <div class="i_pic">
				                                	<c:choose>
				                                		<c:when test="${not empty member.imgBankCard }">
				                                			<img src="${ctx }${member.imgBankCard }" data-param-name="imgBankCard">
				                                			<input type="hidden" name="imgBankCard" value="${member.imgBankCard }"/>
				                                		</c:when>
				                                		<c:otherwise>
						                                	<img src="${ctx }/static/images/J_null.png" data-param-name="imgBankCard">
						                                	<input type="hidden" name="imgBankCard"/>
				                                		</c:otherwise>
				                                	</c:choose>
				                                </div>
				                            </div>
				                        </div>
									</div>
								</td>
							</tr> --%>
							
						</tbody>
					</table>
				</div>
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
			
			<c:choose>
				<c:when test="${type eq 'pos' }">
					<a class="b_btn gray" href="${ctx}/mem/pos/list">返回</a>
				</c:when>
				<c:otherwise>
					<a class="b_btn gray" href="${ctx }/member/list">返回</a>
				</c:otherwise>
			</c:choose>
			
		</div>
		
</div>

</body>
</html>
