<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="common/common.jsp"%>
<title>2Profit后台系统</title>

<style type="text/css">
	*{margin:0;padding:0;}
	body {background-color:#f5f5f5; font-family: '\5FAE\8F6F\96C5\9ED1';}
	body { background:url(${pageContext.request.contextPath}/static/images/login_bg.jpg) no-repeat center top; }

	.type { font-size:18px; color:#f60;}

	.add-on { display:none;}
	.control-group{ margin-top:20px;}
	.input-wrap{ margin-top:8px; width:280px; border:1px solid #e6e6e6; background-color:#fff;}
	.input-wrap input {margin:0;padding:12px 16px;border:none; outline:none;
  -webkit-box-shadow: none;
  -moz-box-shadow: none;
  box-shadow: none;}

	.input-wrap input:focus {  background-color: #fff;
  border: none;
  -webkit-box-shadow: none;
  -moz-box-shadow: none;
  box-shadow: none;
  -webkit-transition: border_not linear .2s,box-shadow linear .2s;
  -moz-transition: border_not linear .2s,box-shadow linear .2s;
  -o-transition: border_not linear .2s,box-shadow linear .2s;
  transition: border_not linear .2s,box-shadow linear .2s;}


  .input-wrap.active{border-color: #a1daa2; background-color: #e6fee7; }
  .input-wrap.active input { background-color: #e6fee7; }

  button.login { display:block; margin-top:16px; width:100%; height:44px; line-height:44px; border-style:none; background:#f60; color:#fff; }

  button.login:hover { background-color:#ff7549;}

</style>
</head>
<body>



	<div class="container">
		<div class="row">
		


		<!--
			<div class="span5">
				<div style="margin-top: 100px;text-align: right;margin-right: 10px;">
				    <img alt="2Profit后台管理系统" width="160" height="160" src="${pageContext.request.contextPath}/static/images/logo2.png">
				</div>
			</div>
		-->
			
			<div style="margin-top: 140px;padding:40px;float:right;background-color:#fff; border:1px solid #eee; border-top:3px solid #f60;">
				<table>
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
					<!--
						<td colspan="2"
							style="background-color: #dff0d8; text-align: center;"><strong>&nbsp;2Profit后台系统</strong>
						</td>
						-->
					</tr>
					<tr>
						<td colspan="2">
							<form action="${pageContext.request.contextPath}/boss/doLogin" theme="simple" type="post" cssClass="form-horizontal">
							<div class="type">后台登录</div>
								<div class="control-group">
								<!--
									<label class="control-label" for="inputEmail">帐号</label>
									-->
									<div class="controls">
										<div class="input-wrap">
											<span class="add-on"><i class="icon-user"></i></span>
											<input type="text" name="userName" cssClass="len" id="username" />
										</div>
									</div>
								</div>
								<div class="control-group">
								<!--
									<label class="control-label" for="inputPassword">密码</label>
									-->
									<div class="controls">
										<div class="input-wrap">
											<span class="add-on"><i class="icon-lock"></i></span>
											<input type="password" name="pwd" cssClass="len" label="密码" />
										</div>
									</div>
								</div>
								<div class="control-group">
									<div class="">
										<div class="">
											<span class="add-on"><i class="icon-hand-right"></i></span>
											<button type="submit" class="login">
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
			<script type="text/javascript">
		$(function() {
			$("#username").focus();
	
			if (top.location != self.location) {
				top.location = self.location;
			}

			$("input").focus(function(){
				var $parent = $(this).parents(".input-wrap");
					$parent.addClass("active");
			});

			$("input").blur(function(){
				var $parent = $(this).parents(".input-wrap");
					$parent.removeClass("active");
			});



		});
	</script>
</body>
</html>
