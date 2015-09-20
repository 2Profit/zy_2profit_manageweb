<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="../common/common.jsp"%>
<%@ include file="../common/common_html_validator.jsp"%>

</head>
<body>
	<form action="" name="form" id="form" method="post" theme="simple">
		<div>
	      	<table class="table table-bordered table-condensed">
	     		<tr>
					<th class="td_right">账号：</th>
					<td style="text-align: left;">
					  	<input type="text" name="replayer.userName" id="userName" value="${queryDto.replayer.userName }"/>
					</td>
					<th class="td_right">评论内容：</th>
					<td style="text-align: left;">
					  	<input type="text" name="replayContent" id="replayContent" value="${queryDto.replayContent }"/>
					</td>
				</tr>
				<tr><td style="text-align: right;" colspan="4">
						<button method="list" class="btn btn-primary" >
							<i class="icon-search icon-white"></i> 查询
						</button></td>
				</tr>
	      	</table>
	      	
	        <table class="table table-bordered table-hover">
				<thead>
					<tr style="background-color: #dff0d8">
						<th>交易账号</th>
						<th>会员类型</th>
						<th>评论内容</th>
						<th>评论日期</th>
						<th>评论者IP</th>
					</tr>
				</thead>
				<c:forEach items="${page.list }" var="u">
					<tr>
					   <td>&nbsp;${u.replayer.userName }</td>
					   <td>&nbsp;</td>
					   <td>&nbsp;${u.replayContent }</td>
					   <td>&nbsp;${u.createDate }</td>
					   <td>&nbsp;${u.ipAddress }</td>
				    </tr>
				</c:forEach>
				<tr><td colspan="16" style="text-align:center;"><%@ include file="../common/pager.jsp"%></td></tr>
			</table>
	      </div>
	      <div>
	      	<tr>
	      		<td style="text-align: center;">
		      	    <button type="button" class="btn btn-default" onclick="closeDialog()">关闭</button>
		        </td>
	      	</tr>
	      </div>
	</form>
</body>

<script type="text/javascript">

function closeDialog(){
	window.close();
}

</script>


</html>