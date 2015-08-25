<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="common/common.jsp"%>
<title>2Profit后台系统</title>
</head>
<body>
	<div class="container">
		<div class="row">
		
			<div class="span5">
				<div style="margin-top: 100px;text-align: right;margin-right: 10px;">
				    <img alt="2Profit后台管理系统" width="160" height="160" src="${pageContext.request.contextPath}/static/images/logo2.png">
				</div>
			</div>
			
			<div class="span7" style="border-left: 1px solid #ccc;margin-left: -2px;">
				<table class="table table-bordered" style="width: 95%;margin-top: 100px;float: right;">
					<caption>
					    <c:if test="${sessionScope.login_error_info != null && sessionScope.login_error_info != '' }">
						    <div class="alert alert-warning alert-dismissable" style="margin-bottom:0px;">
							  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
								${sessionScope.login_error_info }
							</div>
							<%request.getSession().setAttribute("login_error_info",null); %>
					    </c:if>
					</caption>
					<tr>
						<td colspan="2"
							style="background-color: #dff0d8; text-align: center;"><strong>&nbsp;2Profit后台系统</strong>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<form action="${pageContext.request.contextPath}/boss/doLogin" theme="simple" type="post" cssClass="form-horizontal">
								<div class="control-group">
									<label class="control-label" for="inputEmail">帐号</label>
									<div class="controls">
										<div class="input-prepend">
											<span class="add-on"><i class="icon-user"></i></span>
											<input type="text" name="userName" cssClass="len" id="username" />
										</div>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="inputPassword">密码</label>
									<div class="controls">
										<div class="input-prepend">
											<span class="add-on"><i class="icon-lock"></i></span>
											<input type="password" name="pwd" cssClass="len" label="密码" />
										</div>
									</div>
								</div>
								<div class="control-group">
									<div class="controls">
										<div class="input-prepend">
											<span class="add-on"><i class="icon-hand-right"></i></span>
											<button type="submit" class="btn">
												登陆
											</button>
										</div>
									</div>
								</div>
							</form>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(function() {
			$("#username").focus();
	
			if (top.location != self.location) {
				top.location = self.location;
			}
		});
	</script>
</body>
</html>
