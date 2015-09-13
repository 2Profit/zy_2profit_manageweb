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
		
		$("input[name='startDateBegin']").datepicker({
		  	format: 'yyyy-mm-dd',
	        weekStart: 1,
	        autoclose: true,
	        todayBtn: 'linked',
	        language: 'cn'
		});
		$("input[name='startDateEnd']").datepicker({
		  	format: 'yyyy-mm-dd',
	        weekStart: 1,
	        autoclose: true,
	        todayBtn: 'linked',
	        language: 'cn'
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
		
		$("a[name='voteResult_href']").bind("click",function(){
			showVoteResult();
		});
		
		$("a[name='report_href']").bind("click",function(){
			showReport(this);
		});
	});
	
	
	function showReport(object){
		myShowModalDialog("${ctx }/voteResult/postReplay/list?voteTopic.id="+$(object).children().val(), 600, 650, function (v) {
			//do something
		});
 	}
 	
 	function myShowModalDialog(url, width, height, fn) {
 	    if (navigator.userAgent.indexOf("Chrome") > 0) {
 	        window.returnCallBackValue = fn;
 	        var paramsChrome = 'height=' + height + ', width=' + width + ', top=' + (((window.screen.height - height) / 2) - 50) +
 	            ',left=' + ((window.screen.width - width) / 2) + ',toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no';
 	        window.open(url, "newwindow", paramsChrome);
 	    }else {
 	        var params = 'dialogWidth:' + width + 'px;dialogHeight:' + height + 'px;status:no;dialogLeft:'
 	                    + ((window.screen.width - width) / 2) + 'px;dialogTop:' + (((window.screen.height - height) / 2) - 50) + 'px;';
 	        var tempReturnValue = window.showModalDialog(url, "", params);
 	        fn.call(window, tempReturnValue);
 	    }
 	}
	
	function showVoteResult(){
		$.ajax({
	        type: "POST",
	        url: "${ctx }/voteResult/optionCount",
	        async: false,
	        data: {id:$(this).children().val()},
	        success: function (json) {
	        	if(json.success){
					$("#append_table").empty();
					$("#append_div").empty();
					var voteTitleHtml = '';
               		$.each(json.list,function(index,element){
               			if(voteTitleHtml == ''){
               				voteTitleHtml = "<h4 class='modal-title'>"+element.voteTopic.titleContent+",投票结果:</h4>";
               			}
               			var html = "<thead>"+
										"<tr style='background-color: #dff0d8'>"+
											"<th>选项</th>"+
											"<th>投票数</th>"+
										"</tr>"+
									"</thead>"+
					        		"<tr><td>"+element.optionContent+"</td>"+
										"<td>"+element.voteCount+"</td></tr>";
               			$("#append_table").append(html);	
               		});
               		$("#append_div").append(voteTitleHtml);
	        	}else{
	        		alert('查询失败！');
	        	}
	        }
	    });
		$('#myPageModal').modal('show');
	}

</script>
</head>

<body>
<form action="" name="form" id="form" method="post" theme="simple">
	<table class="table table-bordered table-condensed">
		<tr>
			<th class="td_right">ID：</th>
			<td>
				<input type="text" name="id" value="${queryDto.id }">
			</td>
			<th class="td_right">题目内容：</th>
			<td>
				<input type="text" name="titleContent" value="${queryDto.titleContent }">
			</td>
		</tr>
		<tr>
			<th class="td_right">显示位置：</th>
			<td>
				<select id="displayPosition" name="displayPosition">
					<option value="">--请选择--</option>
					<option value="0" <c:if test="${'0' == queryDto.displayPosition }">selected</c:if>>副</option>
					<option value="1" <c:if test="${'1' == queryDto.displayPosition }">selected</c:if>>主</option>
				</select>
			</td>
			<th class="td_right">显示功能：</th>
			<td>
				<select id="isDisplay" name="isDisplay">
					<option value="">--请选择--</option>
					<option value="0" <c:if test="${'0' == queryDto.isDisplay }">selected</c:if>>关</option>
					<option value="1" <c:if test="${'1' == queryDto.isDisplay }">selected</c:if>>开</option>
				</select>
			</td>
		</tr>
		<tr>	
			<th class="td_right">开始时间：</th>
			<td colspan="3">
				从：<input type="text" name="startDateBegin" value="<fmt:formatDate value='${queryDto.startDateBegin}' pattern='yyyy-MM-dd'/>">到：
				<input type="text" name="startDateEnd" value="<fmt:formatDate value='${queryDto.startDateEnd}' pattern='yyyy-MM-dd'/>">
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
				<th>ID</th>
				<th>开始日期</th>
				<th>投票天数</th>
				<th>题目内容</th>
				<th>投票结果</th>
				<th>显示位置</th>
				<th>显示功能</th>
				<th>评论记录</th>
				<th>评论举报次数</th>
				<th>点赞次数</th>
			</tr>
		</thead>
		<c:forEach items="${page.list }" var="u">
			<tr >
			   <td><input type="checkbox" name="ids" value="${u.id }"/></td>
			   <td>&nbsp;${u.id }</td>
			   <td><fmt:formatDate value="${u.startDate}" type="both" pattern="yyyy-MM-dd"/></td>
			   <td>&nbsp;${u.lastDays }</td>
			   <td>&nbsp;${u.titleContent }</td>
			   <td><a name="voteResult_href"><input type="hidden" value="${u.id }">查看详情</a></td>
			   <td>
			   		<c:choose>
			   			<c:when test="${u.displayPosition == '1' }"><font color="green">主</font></c:when>
			   			<c:when test="${u.displayPosition == '0' }"><font color="blue">副</font></c:when>
			   			<c:otherwise>&nbsp;</c:otherwise>
			   		</c:choose>
			   </td>
			   <td>
			   		<c:choose>
			   			<c:when test="${u.isDisplay == '1' }"><font color="green">开</font></c:when>
			   			<c:when test="${u.isDisplay == '0' }"><font color="red">关</font></c:when>
			   			<c:otherwise>&nbsp;</c:otherwise>
			   		</c:choose>
			   </td>
			   <td><a name="report_href"><input type="hidden" value="${u.id }">查看详情</a></td>
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
	            <h4 class="modal-title" id="myModalLabel">投票结果</h4>
	         </div>
	         <div class="modal-body">
	           	<table class="table table-bordered table-hover" id="append_table">
					
				</table>
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	         </div>
	      </div>
		</div>
	</div>
</form>
</body>
</html>
