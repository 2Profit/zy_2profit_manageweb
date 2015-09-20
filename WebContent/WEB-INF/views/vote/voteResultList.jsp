<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page session="false" %>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>投票结果列表</title>
<%@ include file="../common/common.jsp"%>
<script type="text/javascript" src="${ctx }/static/js/manage-web-common.js"/></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	$(function(){
		$('#fresh_button').bind("click",function(){
			$("input[name='id']").val("");
			$("input[name='titleContent']").val("");
			$("#displayPosition").val("");
			$("#isDisplay").val("");
			$("input[name='startDateBegin']").val("");
			$("input[name='startDateEnd']").val("");
		});
		
		$('#myPageModal').modal({
	        backdrop: true,
	        keyboard: true,
	        show:false
	    }).css({
	        width: 'auto',
	        'margin-left': function () {
	            return -($(this).width() / 2);
	        }
	    });
		
		$('#post_button').bind('click',function(){
			if(!confirm("是否确认进行修改操作？")){return;}
			
			var ids = [];
			$('input[name="adjustNum"]').each(function(){
				if($(this).val()!=''){
					ids.push($(this).children().val()+'~'+$(this).val());
				}
			});
			$.ajax({
				type: "POST",
	           	url:"${ctx }/voteResult/editOptionCount",
	        	data:JSON.stringify({'idsAdjust':ids}),
	        	contentType: "application/json",
	        	success:function(json) {
	           		if(json.success){
	           			alert('成功');
	           			window.location.replace("${ctx }/voteResult/list");
	           		}else{
	           			alert('失败');
	           		}
	           	}    
			});
		});
		
		$("a[name='edit_href']").bind("click",function(){
			editVoteResult(this);
		});

	});
	
	function editVoteResult(obj){
		$.ajax({
	        type: "POST",
	        url: "${ctx }/voteResult/optionCount",
	        async: false,
	        data: {'id':$(obj).children().val()},
	        success: function (json) {
	        	if(json.success){
					$("#append_table").empty();
               		$.each(json.list,function(index,element){
               			var html = "<thead>"+
										"<tr style='background-color: #dff0d8'>"+
											"<th>选项</th>"+
											"<th>真实数据</th>"+
											"<th>调整参数</th>"+
											"<th>显示结果</th>"+
										"</tr>"+
									"</thead>"+
					        		"<tr><td>"+element.optionContent+"</td>"+
										"<td>"+element.voteCount+"</td>"+
										"<td><input type='text' name='adjustNum' onblur='adjustVoteCount(this)'>"+
												"<input type='hidden' value='"+element.id+"'/>"+
											"</input></td>"+
										"<td>&nbsp;</td>"+
									"</tr>";
               			$("#append_table").append(html);	
               		});
	        	}else{
	        		alert('查询失败！');
	        	}
	        }
	    });
		$('#myPageModal').modal('show');
	}
	
	function adjustVoteCount(obj){
		var newNumb = parseInt($(obj).val());
		if($(obj).val() == ''){
			newNumb = 0;
		}
		var prevNumb = parseInt($(obj).parent().prevAll().eq(0).text());
		if(newNumb<0 && -newNumb>prevNumb){
			alert('最多减少'+prevNumb);
			$(obj).val(0);
		}
		$(obj).parent().nextAll().eq(0).text(prevNumb + newNumb);
	}

</script>
</head>

<body>
<form action="" name="form" id="form" method="post" theme="simple">
	<table class="table table-bordered table-condensed">
		<tr>
			<th class="td_right">题目内容：</th>
			<td>
				<input type="text" name="titleContent" value="${queryDto.titleContent }">
			</td>
			<th class="td_right">评论功能：</th>
			<td>
				<select id="isComment" name="isComment">
					<option value="">--请选择--</option>
					<option value="0" <c:if test="${'0' == queryDto.isComment }">selected</c:if>>开启</option>
					<option value="1" <c:if test="${'1' == queryDto.isComment }">selected</c:if>>关闭</option>
				</select>
			</td>			
		</tr>
		<tr>
			<th class="td_right">显示位置：</th>
			<td>
				<select id="displayPosition" name="displayPosition">
					<option value="">--请选择--</option>
					<option value="0" <c:if test="${'0' == queryDto.displayPosition }">selected</c:if>>用户中心</option>
					<option value="1" <c:if test="${'1' == queryDto.displayPosition }">selected</c:if>>网页</option>
					<option value="2" <c:if test="${'2' == queryDto.displayPosition }">selected</c:if>>用户中心+网页</option>
				</select>
			</td>
			<th class="td_right">显示模式：</th>
			<td>
				<select id="displayType" name="displayType">
					<option value="">--请选择--</option>
					<option value="0" <c:if test="${'0' == queryDto.displayType }">selected</c:if>>百分比</option>
					<option value="1" <c:if test="${'1' == queryDto.displayType }">selected</c:if>>实数</option>
				</select>
			</td>
		</tr>
		<tr>	
			<th class="td_right">开始时间：</th>
			<td colspan="3">
				从：<input type="text" name="startDateBegin" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
						value="<fmt:formatDate value='${queryDto.startDateBegin}' pattern='yyyy-MM-dd HH:mm:ss'/>">到：
				<input type="text" name="startDateEnd" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
						value="<fmt:formatDate value='${queryDto.startDateEnd}' pattern='yyyy-MM-dd HH:mm:ss'/>">
			</td>
		</tr>
		<tr>	
			<th class="td_right">结束时间：</th>
			<td colspan="3">
				从：<input type="text" name="toDateBegin" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
						value="<fmt:formatDate value='${queryDto.toDateBegin}' pattern='yyyy-MM-dd HH:mm:ss'/>">到：
				<input type="text" name="toDateEnd" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
						value="<fmt:formatDate value='${queryDto.toDateEnd}' pattern='yyyy-MM-dd HH:mm:ss'/>">
			</td>
		</tr>
		<tr>
			<td colspan="11">
				<button method="list" class="btn btn-primary" onclick="selectList(this)">
					<i class="icon-search icon-white"></i> 查询
				</button>
				<button class="btn btn-info" id="fresh_button">
					<i class="icon-repeat icon-white"></i> 刷新
				</button>				
				<button class="btn btn-success" onclick="return toAdd();">
					<i class="icon-plus-sign icon-white"></i> 添加
				</button>	
			</td>
		</tr>
	</table>
	
	<table class="table table-bordered table-hover">
		<thead>
			<tr style="background-color: #dff0d8">
				<th width="20"><input type="checkbox" id="firstCheckbox"/></th>
				<th>投票标题</th>
				<th>投票结果</th>
				<th>评论结果</th>
				<th>显示结果</th>
				<th>开始日期</th>
				<th>结束日期</th>
				<th>发布者</th>
				<th>举报次数</th>
				<th>点赞次数</th>
			</tr>
		</thead>
		<c:forEach items="${page.list }" var="u">
			<tr >
			   <td><input type="checkbox" name="ids" value="${u.id }"/></td>
			   <td>&nbsp;${u.titleContent }</td>
			   <td><a href="${ctx}/voteResult/detail/list?voteTopic.id=${u.id}">投票详情</td>
			   <td><a href="${ctx}/voteTopicReplay/list?voteTopic.id=${u.id}">修改评论</td>
			   <td><a name="edit_href"><input type="hidden" value="${u.id }">修改结果</a></td>
			   <td><fmt:formatDate value="${u.startDate}" type="both" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			   <td><fmt:formatDate value="${u.endDate}" type="both" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			   <td>&nbsp;${u.createName }</td>
			   <td>&nbsp;${u.reportCount }</td>
			   <td>&nbsp;${u.praiseCount }</td>
		    </tr>
		</c:forEach>
		<tr><td colspan="16" style="text-align:center;"><%@ include file="../common/pager.jsp"%></td>
		</tr>
	</table>
	<!-- 模态框（Modal） -->
	<div class="modal fade" id="myPageModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	   <div class="modal-dialog">
	      <div class="modal-content">
	         <div class="modal-header" id="append_div">
	            <h4 class="modal-title" id="myModalLabel">修改结果</h4>
	         </div>
	         <div class="modal-body">
	           	<table class="table table-bordered table-hover" id="append_table">
	           	
				</table>
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            	<button type="button" id="post_button" class="btn btn-primary">确认</button>	            
	         </div>
	      </div>
		</div>
	</div>
</form>
</body>
</html>
