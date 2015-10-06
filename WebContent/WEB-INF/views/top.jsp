<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>后台管理系统头部分</title>
	    <style type="text/css">
	* { padding:0; margin:0; }
	 body { font-family: '\5FAE\8F6F\96C5\9ED1'; background-color:#fdc34b; }
	.J_header { height:70px}
	.J_header .h_logo { float:left; height:70px; }
	.J_header .h_logo a { display:inline-block; *zoom:1; *display:inline; width:130px; height:70px;  text-align: center; color:#545454; }
	.J_header .h_logo a img { text-align: center; margin-top:8px; vertical-align: top;}

	.J_header .h_type { float:left; margin-left:10px; line-height:70px; }
	.J_header .h_type  span { padding-left:20px; border-left:1px solid #ddd; font-size:20px; color:#fff;}
	.J_header .h_info { float:right; padding-right:20px; line-height:70px; }
	
    </style>
  </head>
  
  <body>


  

  	<div class="J_header">
		<div class="h_logo">
			<a href="#"><img height="48" src="${pageContext.request.contextPath}/static/images/logo_48.png" /></a>
		</div>
		<div class="h_type">
			<span>2Profit后台管理系统</span>
		</div>
		<div class="h_info">
      		<font color="orange">${sessionScope.user_session_info.realName }</font>
      		欢迎你! | <a style="color:#666;" href="#" onclick="loginOut()">注销</a></a>
		</div>

	</div>

	<!--
    <h3><span>2Profit后台管理系统</span></h3>
    <div style="float:right">
      		<font color="red">${sessionScope.user_session_info.realName }</font>
      		欢迎你! | <a href="#" onclick="loginOut()">注销</a> | <a target="_blank" href="#">门户</a>
    </div>
	-->
     <script type="text/javascript">
    	//注销
    	function loginOut(){
    		window.parent.location.href = "${pageContext.request.contextPath}/boss/loginOut";
    	}
     </script>  
  </body>
</html>
