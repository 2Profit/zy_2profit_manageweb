<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="../common/common.jsp"%>
<%@ include file="../common/common_html_validator.jsp"%>
<title>添加投票主题</title>
<style>
	.td_right{text-align: right;}
	em {font-style: normal;color:red;}
</style>
<script type="text/javascript">
	$(function(){
		$("#return_button").bind("click",function(event){
			event.preventDefault();
			window.location.replace("${ctx }/voteTopic/list");
		});
		
		$('#displayPosition').change(function(){
			if($(this).val()=='1'){
				$('#remove_td').remove();
				var html =	"<td id='remove_td' colspan='3'>"+
							"<input type='text' name='optionContent' value='是'/></br>"+
							"<input type='text' name='optionContent' value='否'/></br>"+
				 			"<input type='text' name='optionContent' value='其他'/></br>"+
				 			"</td>";
				$('#append_tr').append(html);
			}else if($(this).val()=='0'){
				$('#remove_td').remove();
		 		var html =	"<td id='remove_td' colspan='3'>"+
		 					"<input type='text' name='optionContent'/></br>"+
				 			"<input type='text' name='optionContent'/></br>"+
				 			"<input type='text' name='optionContent'/></br>"+
				 			"<input type='text' name='optionContent'/></br></td>";
	 			$('#append_tr').append(html);
			}
		});
		
		$("input[name='startDate']").datepicker({
		  	format: 'yyyy-mm-dd',
	        weekStart: 1,
	        autoclose: true,
	        todayBtn: 'linked',
	        language: 'cn'
		});
		
		$("button[name='postData_button']").bind("click",function(event){
 			event.preventDefault();
 			
 			if($('#startDate').val()==''){
 				$('#startDate').focus();return false;
 			}
 			if($('#lastDays').val()==''){
 				$('#lastDays').focus();return false;
 			}
 			if($('#titleContent').val()==''){
 				$('#titleContent').focus();return false;
 			}
 			if($('#displayPosition').val()==''){
 				$('#displayPosition').focus();return false;
 			}
 			if($('#isDisplay').val()==''){
 				$('#isDisplay').focus();return false;
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
			</tr>
			<tr>
				<th class="td_right">开始日期：</th>
				<td style="text-align: left;">
		  			<input type="text" name="startDate" data-rule="开始日期:required;startDate;"  id="startDate" 
		  					value="<fmt:formatDate value='${voteTopic.startDate}' type='both' pattern='yyyy-MM-dd'/>"/>
				</td>
				<th class="td_right">投票天数：</th>
				<td style="text-align: left;">
		  			<input type="text" name="lastDays" data-rule="投票天数:required;lastDays;"  id="lastDays" value="${voteTopic.lastDays}"/>
				</td>
		 	</tr>
			<tr>
				<th class="td_right">显示位置：</th>
				<td>
					<%-- <input type="hidden" name="displayPosition" /> --%>
			        <select id="displayPosition" name="displayPosition" data-rule="显示位置:required;displayPosition;">
						<option value="">--请选择--</option>
						<option value="0" <c:if test="${'0' == voteTopic.displayPosition }">selected</c:if>>副</option>
						<option value="1" <c:if test="${'1' == voteTopic.displayPosition }">selected</c:if>>主</option>
					</select>
				</td>
				<th class="td_right">显示功能：</th>
				<td>
					<select id="isDisplay" name="isDisplay" data-rule="显示功能:required;isDisplay;">
						<option value="">--请选择--</option>
						<option value="0" <c:if test="${'0' == voteTopic.isDisplay }">selected</c:if>>关</option>
						<option value="1" <c:if test="${'1' == voteTopic.isDisplay }">selected</c:if>>开</option>
					</select>
				</td>
			</tr>
			
			<tr>
				<th>题目内容：</th>
				<td colspan="3">
		  			<input type="text" name="titleContent" data-rule="题目内容:required;titleContent;"  id="titleContent" value="${voteTopic.titleContent}"/>
		   			<br>
				</td>
		 	</tr>
		 	<tr id="append_tr">
				<th class="td_right">选项：</th>
				<td id="remove_td" colspan="3">
					<c:forEach items="${voteTopic.options }" var="option">
						<input type="text" name="optionContent" value="${option.optionContent}"/></br>
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
