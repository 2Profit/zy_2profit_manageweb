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
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	$(function(){
		
		$('#fresh_button').bind("click",function(){
			$("#mobile").val("");
			$("#email").val("");
			$("input[name='createDateFrom']").val("");
			$("input[name='createDateTo']").val("");
		});
		
		$('#return_button').click(function(event){
			event.preventDefault();
			window.location.replace("${ctx }/voteTopicPost/list");
		});
	});
</script>
</head>

<body>
<form action="" name="form" id="form" method="post" theme="simple">
	<table class="table table-bordered table-condensed">
    	<tr>
			<th class="td_right">用户手机：</th>
			<td style="text-align: left;">
			  	<input type="text" name="member.mobile" id="mobile" value="${queryDto.member.mobile }"/>
			</td>
			<th class="td_right">用户邮箱：</th>
			<td style="text-align: left;">
			  	<input type="text" name="member.email" id="email" value="${queryDto.member.email }"/>
			</td>
		</tr>			
		<tr>	
			<th class="td_right">点赞时间：</th>
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
				<th>点赞内容</th>
				<th>点赞日期</th>
				<th>点赞IP</th>
			</tr>
		</thead>
		<c:forEach items="${page.list }" var="u">
			<tr>
			   <td><input type="checkbox" name="ids" value="${u.id }"/></td>
			   <td>&nbsp;${u.member.mobile }</td>
			   <td>&nbsp;${u.member.email }</td>
			   <td>&nbsp;${u.voteTopicPost.postContent }</td>
			   <td><fmt:formatDate value='${u.createDate}' pattern='yyyy-MM-dd HH:mm:ss'/></td>
			   <td>&nbsp;${u.ipAddress }</td>
		    </tr>
		</c:forEach>
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

</form>
</body>
</html>
