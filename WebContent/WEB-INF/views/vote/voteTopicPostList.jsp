<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page session="false" %>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>评论列表</title>
<%@ include file="../common/common.jsp"%>
<script type="text/javascript" src="${ctx }/static/js/manage-web-common.js"/></script>
<script type="text/javascript" src="${ctx}/static/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	$(function(){
		$("#return_button").bind("click",function(event){
			event.preventDefault();
			window.location.replace("${ctx }/voteResult/list");
		});
		
		$('#editPost').bind("click",function(event){
			event.preventDefault();
			$('#postId').val($(this).children().val());
			$('#myPageModal').modal('show');
		});
		
		$("#modalConfirm").bind("click",function(){
			$('#myPageModal').modal('hide');
			$.ajax({
		        type: "POST",
		        url: "${ctx }/voteTopicPost/editPost",
		        async: false,
		        data: {id:$('#postId').val(),postContent:$('#msgPost').val()},
		        success: function (json) {
		        	if(json.success){
		        		alert('保存成功！');
		        		$('#myPageModal').modal('hidden');
		        	}else{
		        		alert('保存失败！');
		        	}
		        }
		    });
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
		
		
		$('#fresh_button').bind("click",function(){
			$("#titleContent").val("");
			$("#mobile").val("");
			$("#postContent").val("");
			$("input[name='createDateFrom']").val("");
			$("input[name='createDateTo']").val("");
		});
	});

function updateDeleteFlag(ids,deleteFlag){
	$.ajax({
		type: "POST",
       	url:"${ctx }/voteTopicPost/deleteFlag",
    	data:JSON.stringify({'ids':ids,'deleteFlag':deleteFlag}),
    	contentType: "application/json",
    	success:function(json) {
       		if(json.success){
       			alert('成功');
       			window.location.replace("${ctx }/voteTopicPost/list");
       		}else{
       			alert('失败');
       		}
       	}    
	});
}
</script>
</head>

<body>
<form action="" name="form" id="form" method="post" theme="simple">
	<table class="table table-bordered table-condensed">
		<tr>
			<th class="td_right">投票题目：</th>
			<td colspan="3">
			  	<input type="text" name="voteTopic.titleContent" id="titleContent" value="${queryDto.voteTopic.titleContent }"/>
			</td>
		</tr>
    	<tr>
			<th class="td_right">用户手机：</th>
			<td style="text-align: left;">
			  	<input type="text" name="publisher.mobile" id="mobile" value="${queryDto.publisher.mobile }"/>
			</td>
			<th class="td_right">评论内容：</th>
			<td style="text-align: left;">
			  	<input type="text" name="postContent" id="postContent" value="${queryDto.postContent }"/>
			</td>
		</tr>			
		<tr>	
			<th class="td_right">评论时间：</th>
			<td colspan="3">
				从：<input type="text" name="createDateFrom" value='${queryDto.createDateFrom}' 
						onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">到：
				<input type="text" name="createDateTo" value='${queryDto.createDateTo}' 
						onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
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
			</td>
		</tr>
	</table>
	
	<table class="table table-bordered table-hover">
		<thead>
			<tr style="background-color: #dff0d8">
				<th width="20"><input type="checkbox" id="firstCheckbox"/></th>
				<th>用户手机</th>
				<th>用户邮箱</th>
				<th>点赞详情</th>
				<th>举报详情</th>
				<th>评论内容</th>
				<th>评论日期</th>
				<th>评论者IP</th>
				<th>操作</th>
			</tr>
		</thead>
		<c:forEach items="${page.list }" var="u">
			<tr>
			   <td><input type="checkbox" name="ids" value="${u.id }"/></td>
			   <td>&nbsp;${u.publisher.mobile }</td>
			   <td>&nbsp;${u.publisher.email }</td>
			   <td>&nbsp;<a href="${ctx}/voteTopicPost/praise/list?voteTopicPost.id=${u.id }">点赞详情</a></td>
			   <td>&nbsp;<a href="${ctx}/voteTopicPost/report/list?voteTopicPost.id=${u.id }">举报详情</a></td>
			   <td>&nbsp;${u.publisher.email }</td>
			   <td>&nbsp;${u.postContent }</td>
			   <td><fmt:formatDate value='${u.createDate}' pattern='yyyy-MM-dd HH:mm:ss'/></td>
			   <td>&nbsp;${u.ipAddress }</td>
			   <td>
			      <a href="" id="editPost"><input type="hidden" value="${u.id}">修改评论</a>
			      <c:choose>
			      	<c:when test="${u.deleteFlag == 1}"><a name="revert_href"><input type="hidden" value="${u.id}"/>恢复</a>&nbsp;</c:when>
			      	<c:otherwise><a name="delete_href"><input type="hidden" value="${u.id}"/>删除</a></c:otherwise>
			      </c:choose>
			   </td>			   
		    </tr>
		</c:forEach>
		<tr>
			<td width="20"><input type="checkbox" id="checkAll"/></td>
			<td colspan="20">
				<button id="delete_button" class="btn btn-danger"><i class="icon-remove icon-white"></i>删除</button>&nbsp;
				<button id="revert_button" class="btn btn-warning"><i class="icon-repeat icon-white"></i>恢复</button>
			</td>
		</tr>		
		<tr>
			<td colspan="16" style="text-align:center;"><%@ include file="../common/pager.jsp"%></td>
		</tr>
	      <div>
	      	<tr>
	      		<td colspan="16" style="text-align: left;">
		      	    <button class="btn btn-inverse" id="return_button">
			   			 <i class="icon-arrow-left icon-white"></i> 返回
					</button>
		        </td>
	      	</tr>
	      </div>		
	</table>
	<!-- 模态框（Modal） -->
	<div class="modal fade" id="myPageModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	   <div class="modal-dialog">
	      <div class="modal-content">
	         <div class="modal-header">
	            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	            <h4 class="modal-title" id="myModalLabel">
	              	修改评论
	            </h4>
	         </div>
	         <div class="modal-body">
	           	<table class="table table-bordered table-hover">
					<tr style="background-color: #dff0d8">
						<th class="td_right">评论内容：</th>
						<td>
							<input type="hidden" name="postId" id="postId">
							<textarea id="msgPost" rows="3" cols="6"></textarea>
						</td>
					</tr>
				</table>
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	            <button type="button" id="modalConfirm" class="btn btn-primary">确认</button>
	         </div>
	      </div><!-- /.modal-content -->
	</div><!-- /.modal -->	
</form>
</body>
</html>
