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

<script type="text/javascript">
$(function(){
	
});

function myPass(){
	var posIds = new Array();
	posIds.push('${pmm.id}');
	
	layer.confirm('确定要提案通过吗？', function(){
		
		$.ajax({
			url : '${ctx}/mem/pos/ajax/img/pass',
			async : false,
			traditional : true,
			data : {
				posIds : posIds
			},
			success : function(result){
				if(result.success){
					layer.alert('操作成功', function(){
						window.location.href = '${ctx}/mem/pos/img/list';
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
			url : '${ctx}/mem/pos/ajax/img/cancel',
			async : false,
			traditional : true,
			data : {
				posIds : posIds
			},
			success : function(result){
				if(result.success){
					layer.alert('操作成功', function(){
						window.location.href = '${ctx}/mem/pos/img/list';
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
			<div class="l_text">审批证明资料</div>
		</div>
		
		
		
		<form id="myForm" method="post">
			<input type="hidden" id="posId" value="${pmm.id }"/>
			<div class="l_form mgt20">
					<table>
						<tbody>
							<tr>
								<td class="f_title wd200">提案号：</td>
								<td class="f_content">${pmm.proposalNo }</td>
							</tr>
							<tr>
								<td class="f_title wd200">会员编号：</td>
								<td class="f_content">${pmm.member.no }</td>
							</tr>
							<tr>
								
								<td class="f_title wd100">姓名：</td>
								<td class="f_content">${pmm.member.cnName }</td>
								
							</tr>
							<tr>
								<td class="f_title">昵称：</td>
								<td class="f_content">${pmm.member.nickName }</td>
							</tr>
							<tr>
								<td class="f_title">手机号码：</td>
								<td class="f_content">${pmm.member.mobile }</td>
								
							</tr>
							<tr>
								<td class="f_title">证件类型：</td>
								<td class="f_content">
									<c:choose>
										<c:when test="${pmm.member.cardType eq 0 }">中国居民身份证</c:when>
										<c:when test="${pmm.member.cardType eq 1 }">护照</c:when>
									</c:choose>
								</td>
								
							</tr>
							
							<tr>
								
								<td class="f_title">证件编号：</td>
								<td class="f_content">${pmm.member.card }</td>
								
							</tr>
							
							<tr>
								<td class="f_title">银行名称：</td>
								<td class="f_content">
									${pmm.member.memBankInfo.bankAccount }
								</td>
							</tr>
							<tr>
								
								<td class="f_title">银行账号：</td>
								<td class="f_content">
									${pmm.member.memBankInfo.bankCardNum }
								</td>
								
							</tr>
							<tr>
								<td class="f_title">账户持有人：</td>
								<td class="f_content">
									${pmm.member.memBankInfo.bankAddress }
								</td>
							</tr>
							
							<tr>
								<c:choose>
									<c:when test="${pmm.type eq 0 }">
										<td class="f_title">身份证明：</td>
										<td class="f_content">
											<div class="J_picBox clearfix">
						                        <div class="p_item">
						                            <div class="i_inner">
						                            	
						                                <div class="i_pic">
						                                	<img src="${ctx }${pmm.imgPath }" data-param-name="imgIDCardA">
						                                </div>
						                                
						                            </div>
						                        </div>
						                    </div>
										</td>
									</c:when>
									<c:when test="${pmm.type eq 1 }">
										<td class="f_title">银行证明：</td>
										<td class="f_content">
											<div class="J_picBox clearfix">
												<div class="p_item">
						                            <div class="i_inner">
						                                <div class="i_pic">
						                                	<img src="${ctx }${pmm.imgPath }" data-param-name="imgBankCard">
						                                </div>
						                            </div>
						                        </div>
											</div>
										</td>
									</c:when>
								</c:choose>
								
							</tr>
							
						</tbody>
					</table>
			</div>
		</form>
	
		
	
		<div class="l_btnGrounp mgt20">
			<a class="b_btn" href="javascript:myPass();">通过</a>
			<a class="b_btn orange" href="javascript:myCancel();">拒绝</a>
			
			<a class="b_btn gray" href="${ctx}/mem/pos/img/list">返回</a>
			
		</div>
		
</div>

</body>
</html>
