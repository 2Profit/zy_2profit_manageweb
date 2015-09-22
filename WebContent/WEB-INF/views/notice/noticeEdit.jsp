<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="../common/common.jsp"%>
<%@ include file="../common/common_html_validator.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/My97DatePicker/WdatePicker.js"></script>
<title>公告编辑</title>
<style>
	.td_right{text-align: right;}
	em {font-style: normal;color:red;}
	textarea {
	   height: auto;
	   width:80%;
	}	
</style>
<script type="text/javascript">
	$(function(){
		$("#return_button").bind("click",function(event){
			event.preventDefault();
			window.location.replace("${ctx }/notice/list");
		});
		
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
		
		$("button[name='postData_button']").bind("click",function(event){
 			event.preventDefault();
 			
 			if($('#startDate').val()==''){
 				$('#startDate').focus();return false;
 			}
 			if($('#endDate').val()==''){
 				$('#endDate').focus();return false;
 			}
 			if($('#title').val()==''){
 				$('#title').focus();return false;
 			}
 			if($('#content').val()==''){
 				$('#content').focus();return false;
 			}
 			
 			if($('#displayType').val()==''){
 				$('#displayType').focus();return false;
 			}
 			if($('#applyType').val()==''){
 				$('#applyType').focus();return false;
 			}
 			if($('#noticeType').val()==''){
 				$('#noticeType').focus();return false;
 			}
 			
 			var formData = new FormData($('#form')[0]);
 			$.ajax({
 		        type: "POST",
 		        url: "${ctx }/notice/save",
 		        cache: false,
 		        async: false,
 		        contentType: false,
 		        processData: false,
 		        data:formData,
 		        success: function (json) {
 		        	if(json.success){
 		        		alert('保存成功！');
 		        		window.location.replace("${ctx }/notice/list");
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
	<form action="post" namespace="/" theme="simple" id="form" method="post" enctype="multipart/form-data">
		<table class="table table-bordered">
			<tr>
				<td colspan="4" style="background-color: #dff0d8;text-align: center;">
					<c:choose>
					  <c:when test="${notice.id == null || notice.id == '' }">
					    <strong>公告新增</strong>
					  </c:when>
					  <c:otherwise>
					    <strong>公告编辑</strong>
					  </c:otherwise>
					</c:choose>
					
				</td>
			</tr>
			<tr style="display:none;">
				<td><input type="hidden" name="id" value="${notice.id }" /></td>
				<td><input type="hidden" name="deleteFlag" value="${notice.deleteFlag }" /></td>
				<td><input type="hidden" name="photoUrl" value="${notice.photoUrl }" /></td>
				<td><input type="hidden" name="createId" value="${notice.createId }" /></td>
				<td><input type="hidden" name="createName" value="${notice.createName }" /></td>
			</tr>
			
			<tr>
				<th>公告标题：</th>
				<td>
		  			<input type="text" name="title" data-rule="公告标题:required;title;" id="title" value="${notice.title}"/>
				</td>
				<th class="td_right">是否有效：</th>
				<td>
					<select id="status" name="status">
						<option value="">--请选择--</option>
						<option value="0" <c:if test="${'0' == notice.status }">selected</c:if>>无效</option>
						<option value="1" <c:if test="${'1' == notice.status }">selected</c:if>>有效</option>
					</select>
				</td>				
		 	</tr>
			<tr>
				<th>公告内容：</th>
				<td>
		  			<textarea rows="5" cols="10" name="content" id="content" 
							data-rule="公告内容:required;content;">${notice.content }</textarea>
				</td>
				<th>公告图片：</th>
				<td style="text-align: left;">
					<input type='file' id="image" name="file"/><br>
					宽：<input type="text" name="imageWidth" value="465"> <br/>
					高：<input type="text" name="imageHeight" value="260"> <br>
   					<img id="blah" src="${ctx}/${notice.photoUrl}" alt="图片预览" />						
				</td>					
				</td>				
		 	</tr>
			
			<tr>
				<th class="td_right">有效期开始日期：</th>
				<td style="text-align: left;">
		  			<input type="text" name="startDate" data-rule="有效期开始日期:required;startDate;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" 
		  					id="startDate" value="<fmt:formatDate value='${notice.startDate}' type='both' pattern='yyyy-MM-dd HH:mm:ss'/>"/>
				</td>
				<th class="td_right">有效期截止日期：</th>
				<td style="text-align: left;">
		  			<input type="text" name="endDate" data-rule="有效期截止日期:required;endDate;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
		  				id="endDate" value="<fmt:formatDate value='${notice.endDate}' type='both' pattern='yyyy-MM-dd HH:mm:ss'/>"/>
				</td>
		 	</tr>
			<tr>
				<th class="td_right">应用平台：</th>
				<td>
			        <select id="applyType" name="applyType" data-rule="应用平台:required;applyType;">
						<option value="">--请选择--</option>
						<option value="0" <c:if test="${'0' == notice.applyType }">selected</c:if>>交易平台</option>
						<option value="1" <c:if test="${'1' == notice.applyType }">selected</c:if>>前台系统</option>
						<option value="2" <c:if test="${'2' == notice.applyType }">selected</c:if>>通用</option>
					</select>
				</td>
				<th class="td_right">显示类型：</th>
				<td>
					<select id="displayType" name="displayType" data-rule="显示类型:required;displayType;">
						<option value="">--请选择--</option>
						<option value="0" <c:if test="${'0' == notice.displayType }">selected</c:if>>弹窗</option>
						<option value="1" <c:if test="${'1' == notice.displayType }">selected</c:if>>通知栏</option>
						<option value="2" <c:if test="${'2' == notice.displayType }">selected</c:if>>通用</option>
					</select>
				</td>
			</tr>
			<tr>
				<th class="td_right">公告类型：</th>
				<td>
					<select id="noticeType" name="noticeType" data-rule="公告类型:required;noticeType;">
						<option value="">--请选择--</option>
						<option value="0" <c:if test="${'0' == notice.noticeType }">selected</c:if>>重要公告</option>
						<option value="1" <c:if test="${'1' == notice.noticeType }">selected</c:if>>休市安排</option>
						<option value="2" <c:if test="${'2' == notice.noticeType }">selected</c:if>>维护通知</option>
					</select>
				</td>
				<th></th>
				<td></td>
			</tr>
			
			<tr>
				<td colspan="4" style="text-align: center;">
				   <c:choose>
				     <c:when test="${notice.id == null || notice.id == '' }">
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
