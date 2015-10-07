<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="../../common/common.jsp"%>
<%@ include file="../../common/common_html_validator.jsp"%>
<title>后台用户修改密码</title>
<style>
	.td_right{text-align: right;}
</style>

</head>

<body>


	<form action="" namespace="/" theme="simple" id="form">
		<table class="table table-bordered">
		
			<tr>
				<th class="td_right">原始密码</th>
				<td style="text-align: left;">
				<input type="password" name="oldPwd" id="oldPwd"  data-rule="原始密码:required;oldPwd;length[6~20];remote[checkOldPwd]"/>
				</td>
			</tr>
			
			<tr>
					<th class="td_right">密码</th>
					<td style="text-align: left;">
					<input type="password" name="password" data-rule="密码:required;password;length[6~20];" id="password" />
					</td>
			</tr>
		    <tr>
					<th class="td_right">确认密码</th>
					<td style="text-align: left;">
					<input type="password" name="newpassword2" data-rule="确认密码:required;match(password)" id="newpassword2" />
					</td>
				  </tr>
						
			<tr >
				<td colspan="2" style="text-align: center;">
				    <button method="doPwdUpdate" class="btn btn-success">
							<i class="icon-ok icon-white"></i> 修改
					</button>
					
					<button class="btn btn-inverse" onclick="history.go(-1);">
			   			 <i class="icon-arrow-left icon-white"></i> 返回
					</button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>