<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="../common/common.jsp"%>
<%@ include file="../common/common_html_validator.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/My97DatePicker/WdatePicker.js"></script>

<script type="text/javascript">
	$(function(){
		$("#return_button").bind("click",function(event){
			event.preventDefault();
			window.location.replace("${ctx }/voteResult/list");
		});
	});
	
</script>

</head>
<body>
	<form action="" name="form" id="form" method="post" theme="simple">
		<div>
	      	<table class="table table-bordered table-condensed">
	     		<tr>
					<th class="td_right">账号：</th>
					<td style="text-align: left;">
					  	<input type="text" name="member.userName" id="userName" value="${queryDto.member.userName }"/>
					</td>
					<th class="td_right">投票时间：</th>
					<td colspan="3">
						从：<input type="text" name="createDateFrom" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
								value="<fmt:formatDate value='${queryDto.createDateFrom}' pattern='yyyy-MM-dd HH:mm:ss'/>">到：
						<input type="text" name="createDateTo" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
								value="<fmt:formatDate value='${queryDto.createDateTo}' pattern='yyyy-MM-dd HH:mm:ss'/>">
					</td>
				</tr>	
				<tr>
					<td colspan="11">
						<button method="list" class="btn btn-primary" >
							<i class="icon-search icon-white"></i> 查询
						</button>
					</td>				
				</tr>			
	      	</table>
	      	
	        <table class="table table-bordered table-hover">
				<thead>
					<tr style="background-color: #dff0d8">
						<th>投票日期</th>
						<th>交易账号</th>
						<th>会员类型</th>
						<th>投票结果</th>
						<th>投票IP</th>
					</tr>
				</thead>
				<c:forEach items="${page.list }" var="u">
					<tr>
					   <td><fmt:formatDate value="${u.createDate}" type="both" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					   <td>&nbsp;${u.member.userName }</td>
					   <td>
					   		<c:choose>
					   			<c:when test="${u.member!=null && u.member.id!='' }">会员</c:when>
					   			<c:when test="${u.member==null || u.member.id==null || u.member.id=='' }">游客</c:when>
					   			<c:otherwise>&nbsp;</c:otherwise>
					   		</c:choose>
					   </td>
					   <td>&nbsp;${u.voteTopicOption.optionContent }</td>
					   <td>&nbsp;${u.ipAddress }</td>
				    </tr>
				</c:forEach>
				<tr><td colspan="16" style="text-align:center;"><%@ include file="../common/pager.jsp"%></td></tr>
			</table>
	      </div>
	      <div>
	      	<tr>
	      		<td style="text-align: center;">
		      	    <button class="btn btn-inverse" id="return_button">
			   			 <i class="icon-arrow-left icon-white"></i> 返回
					</button>
		        </td>
	      	</tr>
	      </div>
	</form>
</body>


</html>