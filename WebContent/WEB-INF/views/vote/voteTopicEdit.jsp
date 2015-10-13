<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="../common/common.jsp"%>
<%@ include file="../common/common_html_validator.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/My97DatePicker/WdatePicker.js"></script>
<title>添加投票主题</title>
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
			window.location.replace("${ctx }/voteTopic/list");
		});
		
		$('#add_option').bind("click",function(event){
			event.preventDefault();
			var html =	"<div><input type='text' name='optionContent'>&nbsp;<a href='' onclick='event.preventDefault();deleteOption(this)'>删除</a></div>";
			$('#append_td').append(html);
		});
		
		$('#startDate').blur
		
		$("button[name='postData_button']").bind("click",function(event){
 			event.preventDefault();
 			
 			if($('#startDate').val()==''){
 				$('#startDate').focus();return false;
 			}
 			if($('#endDate').val()==''){
 				$('#endDate').focus();return false;
 			}
 			if($('#titleContent').val()==''){
 				$('#titleContent').focus();return false;
 			}
 			if($('#displayPosition').val()==''){
 				$('#displayPosition').focus();return false;
 			}
 			if($('#displayType').val()==''){
 				$('#displayType').focus();return false;
 			}
 			if($('#isComment').val()==''){
 				$('#isComment').focus();return false;
 			}
 			if($('#schedule').val()==''){
 				$('#schedule').focus();return false;
 			}
 			var flagReturn = false;
			$('input[name="optionContent"]').each(function(){
				if($(this).val()==''){
					$(this).focus();
					flagReturn = true;
				}
			});
			if(flagReturn){
				return false;
			}
			
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
 		        		window.location.replace("${ctx }/voteTopic/list");
 		        	}else{
 		        		alert('保存失败！','');
 		        	}
 		        }
 		    });
 		});
	});
	
	//删除选项
	function deleteOption(obj){
		$(obj).closest('div').remove();
	}

	
</script>
</head>

<body>
	<form action="post" namespace="/" theme="simple" id="form" method="post" enctype="multipart/form-data">
		<table class="table table-bordered">
			<tr>
				<td colspan="4" style="background-color: #dff0d8;text-align: center;">
					<c:choose>
					  <c:when test="${voteTopic.id == null || voteTopic.id == '' }">
					    <strong>投票主题新增</strong>
					  </c:when>
					  <c:otherwise>
					    <strong>投票主题编辑</strong>
					  </c:otherwise>
					</c:choose>
					
				</td>
			</tr>
			<tr style="display:none;">
				<td><input type="hidden" name="id" value="${voteTopic.id }" /></td>
				<td><input type="hidden" name="deleteFlag" value="${voteTopic.deleteFlag }" /></td>
				<td><input type="hidden" name="createId" value="${voteTopic.createId }" /></td>
				<td><input type="hidden" name="createName" value="${voteTopic.createName }" /></td>
				<td><input type="hidden" name="imageUrl" value="${voteTopic.imageUrl }" /></td>
				<td><input type="hidden" name="voteCount" value="${voteTopic.voteCount }" /></td>
			</tr>
			<tr>
				<th class="td_right">开始日期：</th>
				<td style="text-align: left;">
		  			<input type="text" name="startDate" data-rule="开始日期:required;startDate;"  id="startDate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
		  					value="<fmt:formatDate value='${voteTopic.startDate}' type='both' pattern='yyyy-MM-dd HH:mm:ss'/>"/>
				</td>
				<th class="td_right">结束日期：</th>
				<td style="text-align: left;">
		  			<input type="text" name="endDate" data-rule="结束日期:required;endDate;"  id="endDate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
		  					value="<fmt:formatDate value='${voteTopic.endDate}' type='both' pattern='yyyy-MM-dd HH:mm:ss'/>"/>
				</td>
		 	</tr>
			<tr>
				<th class="td_right">显示位置：</th>
				<td>
			        <select id="displayPosition" name="displayPosition" data-rule="显示位置:required;displayPosition;">
						<option value="">--请选择--</option>
						<option value="0" <c:if test="${'0' == voteTopic.displayPosition }">selected</c:if>>用户中心</option>
						<option value="1" <c:if test="${'1' == voteTopic.displayPosition }">selected</c:if>>网页</option>
						<option value="2" <c:if test="${'2' == voteTopic.displayPosition }">selected</c:if>>用户中心+网页</option>
					</select>
				</td>
				<th class="td_right">评论功能：</th>
				<td>
					<select id="isComment" name="isComment" data-rule="评论功能:required;isComment;">
						<option value="">--请选择--</option>
						<option value="0" <c:if test="${!voteTopic.isComment }">selected</c:if>>关闭</option>
						<option value="1" <c:if test="${voteTopic.isComment }">selected</c:if>>开启</option>
					</select>
				</td>
			</tr>
		 	<tr>
		 		<th>显示模式：</th>
		 		<td>
					<select id="displayType" name="displayType" data-rule="显示模式:required;displayType;">
						<option value="">--请选择--</option>
						<option value="0" <c:if test="${'0' == voteTopic.displayType }">selected</c:if>>百分比</option>
						<option value="1" <c:if test="${'1' == voteTopic.displayType }">selected</c:if>>实数</option>
					</select>
		 		</td>
		 		<th>主题排期：</th>
		 		<td>
					<select id="schedule" name="schedule" data-rule="主题排期:required;schedule;">
						<option value="">--请选择--</option>
						<option value="1" <c:if test="${'1' == voteTopic.schedule }">selected</c:if>>当前期</option>
						<option value="2" <c:if test="${'2' == voteTopic.schedule }">selected</c:if>>下期</option>
					</select>
		 		</td>

		 	</tr>
			<tr>
				<th>题目内容：</th>
				<td>
		  			<input type="text" name="titleContent" data-rule="题目内容:required;titleContent;"  
		  				id="titleContent" value="${voteTopic.titleContent}"/>
				</td>
		 		<th>主题图片</th>
				<td style="text-align: left;">
					<input type='file' id="image" name="file"/><br>
					宽：<input type="text" name="imageWidth" value="230"> <br/>
					高：<input type="text" name="imageHeight" value="130"> <br>
   					<img id="blah" src="${ctx}/${voteTopic.imageUrl}" alt="图片预览" />						
				</td>				
		 	</tr>		 	
		 	<tr>
				<th class="td_right">选项：<a href="" id="add_option">增加选项</a></th>
				<td id="append_td" colspan="3">
					<c:forEach items="${voteTopic.options }" var="option">
						<div><input type="text" name="optionContent" value="${option.optionContent}"/>
								<a href='' onclik="event.preventDefault();deleteOption(this)">删除</a></br></div>
					</c:forEach>
				</td>
		 	</tr>
			
			<tr>
				<td colspan="4" style="text-align: center;">
				   <c:choose>
				     <c:when test="${voteTopic.id == null || voteTopic.id == '' }">
				        <button name="postData_button" class="btn btn-success">
							<i class="icon-ok icon-white"></i> 新增
						</button>
				     </c:when>
				     <c:otherwise>
				        <button name="postData_button" class="btn btn-success">
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
