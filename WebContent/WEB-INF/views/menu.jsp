<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>后台左边菜单页</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/zTree3.1/css/zTreeStyle/zTreeStyle.css" type="text/css">

<style type="text/css">
 * { padding:0; margin:0 }
 body { background-color:#56b30b; font-family: '\5FAE\8F6F\96C5\9ED1'; }

 /*font-face Icon*/
@font-face { font-family: 'icomoon'; src: url('/static/font/icomoon.eot'); /* IE9*/ src: url('/static/font/icomoon.eot?#iefix') format('embedded-opentype'), /* IE6-IE8 */ url('/static/font/icomoon.woff') format('woff'), /* chrome、firefox */ url('/static/font/icomoon.ttf') format('truetype'), /* chrome、firefox、opera、Safari, Android, iOS 4.2+*/ url('/static/font/icomoon.svg#iconfont') format('svg'); /* iOS 4.1- */ }
.icon { font-family: 'icomoon' !important; font-style: normal; -webkit-font-smoothing: antialiased; /*-webkit-text-stroke-width: 0.2px;*/ -moz-osx-font-smoothing: grayscale; }




.J_nav { }
.J_nav .n_item { height:50px; overflow: hidden; }
.J_nav .n_item .i_default { background:url(${pageContext.request.contextPath}/static/images/down_fff_bg.png) no-repeat 170px 24px; background-color:#4ba006; }
.J_nav .n_item .i_default a { padding-left:20px; display:block; height:50px; line-height:50px; text-decoration: none; color:#fff; }
.J_nav .n_item .i_default a i {margin-right:10px; font-size:18px}
.J_nav .n_item .i_default a.current { color:#fff; }
.J_nav .n_item .i_menu {}
.J_nav .n_item .i_menu .m_item a { padding-left:40px; display:block;  line-height:50px; text-decoration: none; color:#fff; }
.J_nav .n_item .i_menu .m_item a i {margin-right:10px; font-size:18px}
.J_nav .n_item .i_menu .m_item a.current { color:#fff; }

.J_nav .n_item.current { height:auto; }
.J_nav .n_item.current .i_default { }
</style>

</head>

<body>

<div id="loadImg" style="text-align: center;">
	<img style="margin-top: 20px;" alt="菜单加载中......" src="${pageContext.request.contextPath}/static/images/loader.gif">
	<br>资源加载中...
</div>

<div id="nav" class="J_nav">



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
			//var zNodes = eval('('+data+')');
			//$.fn.zTree.init($("#treeDemo"), setting, zNodes);

			setupNav(data);
			
			$("#loadImg").hide();
			//$("#loadID").show();
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
<script>
function getIcon(md5){
	switch(md5){
		case "1":return '󰄭'
		break;
		case "2":return '󰅋'
		break;
		case "3":return '󰄆'
		break;
		case "6":return '󰁑'
		break;
		case "2c9081294dc96764014dc971adaf0049":return '󰁑'
		break;
		case "2c9081294dc96764014dc971f2ae004a":return '󰃍'
		break;
		case "2c9081294dc96764014dc9724771004b":return '󰃒'
		break;
		case "8af41cd14fa37c48014fa789c729001f":return '󰄁'
		break;
		case "8af41cd14fa37c48014fa78ae1ec0020":return '󰊤'
		break;

		default:return '󰅡'
	}


}
function setupNav(json){
	var oNav = document.getElementById("nav");
	json = eval("("+json+")");
	//console.log(json);

	var sHtml = "";

	for(var i=0;i<json.length;i++){
	
		sHtml+='<div class="n_item">'
		sHtml+='<div class="i_default"><a href="'+(json[i].url?json[i].url:'javascript:;')+'" target='+json[i].target+'><i class="icon">'+getIcon(json[i].id)+'</i>'+json[i].name+'</a></div>'

		if(json[i].children){

			sHtml+='<div class="i_menu">'

			for(var j=0;j<json[i].children.length;j++){
				var cur = json[i].children[j];
				sHtml += '<div class="m_item"><a href="'+cur.url+'" target='+cur.target+'><i class="icon">'+getIcon(cur.id)+'</i>'+cur.name+'</a></div>';
			}

			sHtml+='</div>'
		}



		
		sHtml+='</div>';
	
	}
	oNav.innerHTML=sHtml;


	$(".J_nav .n_item").eq(0).addClass("current");
	$(".J_nav .n_item").click(function(){
		$(this).addClass("current").siblings().removeClass("current");
	});


	var $a = $(oNav).find("a");
	$a.click(function(){
		if($(this).parent().is(".i_default")){return}

		$a.removeClass("current");
		$(this).addClass("current")
	});



}

</script>
</body>
</html>
