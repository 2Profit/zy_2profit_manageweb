<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>后台左边菜单页</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/zTree3.1/css/zTreeStyle/zTreeStyle.css" type="text/css">
</head>

<body>

<div id="loadImg" style="text-align: center;">
	<img style="margin-top: 20px;" alt="菜单加载中......" src="${pageContext.request.contextPath}/static/images/loader.gif">
	<br>资源加载中...
</div>

<div id="loadID" style="display: none;">
	<div style="display: none;">
		属性( key )：<input type="radio" id="name" name="keyType" class="radio first" checked /><span>name (string)</span><br/>
		<input type="radio" id="level" name="keyType" class="radio" style="margin-left:68px;" /><span>level (number) ... 根节点 level = 0</span><br/>
		<input type="radio" id="id" name="keyType" class="radio" style="margin-left:68px;" /><span>id (number)</span><br/>
		方法：<input type="radio" id="getNodeByParam" name="funType" class="radio first" /><span>getNodeByParam</span><br/>
		<input type="radio" id="getNodesByParam" name="funType" class="radio" style="margin-left:36px;" /><span>getNodesByParam</span><br/>
		<input type="radio" id="getNodesByParamFuzzy" name="funType" class="radio" style="margin-left:36px;" checked /><span>getNodesByParamFuzzy (only string)</span><br/>
		<input type="radio" id="getNodesByFilter" name="funType" class="radio" style="margin-left:36px;" /><span>getNodesByFilter (参考本页源码中 function filter)</span><br/>
	</div>
	<ul id="treeDemo" class="ztree"></ul>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/zTree3.1/js/jquery.ztree.all-3.1.min.js"></script>
<SCRIPT type="text/javascript">
(function(){
	var setting = {
			check: {
				enable: false,
				dblClickExpand: false
			},view: {
				fontCss: getFontCss
			},callback: {
				onClick: onClick
			}
	};
	function onClick(e,treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("treeDemo");
		zTree.expandNode(treeNode);
	}
	
	$.ajax({
		url:"${pageContext.request.contextPath}/boss/resource/ajax_list?roleId=${roleId}",
		type:"post",
		dataType:"text",
		success:function(data, textStatus){
			var zNodes = eval('('+data+')');
			$.fn.zTree.init($("#treeDemo"), setting, zNodes);
			
			
			$("#loadImg").hide();
			$("#loadID").show();
		},
		error:function(){
			alert("加载菜单失败！");
		}
	});
	
	
	function focusKey(e) {key.val("");
		if (key.hasClass("empty")) {
			key.removeClass("empty");
		}
	}
	
	var lastValue = "", nodeList = [], fontCss = {};
	function clickRadio(e) {
		lastValue = "";
		searchNode(e);
	}
	
	function getFontCss(treeId, treeNode) {
		return (!!treeNode.highlight) ? {color:"#A60000", "font-weight":"bold"} : {color:"#333", "font-weight":"normal"};
	}
	function filter(node) {
		return !node.isParent && node.isFirstNode;
	}
	
	var expandAllFlg = true;
	function expandNode(e) {
		var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
		type = e.data.type,
		nodes = zTree.getSelectedNodes();

		if (type == "expandAll") {
			zTree.expandAll(true);
		} else if (type == "collapseAll") {
			zTree.expandAll(false);
		} else if (type == "expandOrCollapse") {
			zTree.expandAll(expandAllFlg);
			expandAllFlg = !expandAllFlg;
		} else {
			if (type.indexOf("All")<0 && nodes.length == 0) {
				alert("请先选择一个父节点");
			}
			var callbackFlag = $("#callbackTrigger").attr("checked");
			for (var i=0, l=nodes.length; i<l; i++) {
				zTree.setting.view.fontCss = {};
				if (type == "expand") {
					zTree.expandNode(nodes[i], true, null, null, callbackFlag);
				} else if (type == "collapse") {
					zTree.expandNode(nodes[i], false, null, null, callbackFlag);
				} else if (type == "toggle") {
					zTree.expandNode(nodes[i], null, null, null, callbackFlag);
				} else if (type == "expandSon") {
					zTree.expandNode(nodes[i], true, true, null, callbackFlag);
				} else if (type == "collapseSon") {
					zTree.expandNode(nodes[i], false, true, null, callbackFlag);
				}
			}
		}
	}
	$("#expandOrCollapseAllBtn").bind("click", {type:"expandOrCollapse"}, expandNode);
})();

</SCRIPT>
</body>
</html>
