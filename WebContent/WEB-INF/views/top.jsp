<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>后台管理系统头部分</title>
    <style type="text/css">
	h3 {
	    padding-top: auto;
	    padding-right: auto;
	    padding-bottom: auto;
	    padding-left: auto;
	    text-transform:uppercase;
	    font-size: 1.4em;
	   }
	h3 span {
	    background-color:white;
	    color:green;
	   }
	div {
		padding:auto;
	    text-transform:uppercase;
	}   
	div span{
		background-color:white;
	    color:blue;
	}
    </style>
  </head>
  
  <body>
    <h3><span>2Profit后台管理系统</span></h3>
    <div style="float:right">
      		<font color="red">${sessionScope.user_session_info.realName }</font>
      		欢迎你! | <a href="#" onclick="loginOut()">注销</a> | <a target="_blank" href="#">门户</a>
    </div>
     <script type="text/javascript">
    	//注销
    	function loginOut(){
    		window.parent.location.href = "${pageContext.request.contextPath}/boss/loginOut";
    	}
     </script>  
  </body>
</html>
