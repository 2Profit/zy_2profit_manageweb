<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/zTree3.1/css/zTreeStyle/zTreeStyle.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap/css/bootstrap.min.css"  type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/base.css"  type="text/css">

<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/zTree3.1/js/jquery.ztree.all-3.1.min.js"></script>

<title>添加角色</title>
</head>
<body>
	<form action="" id="form1" method="post" name="form1" theme="simple">
				<table class="table table-bordered" style="width: 500px;margin: auto;">
					<tr>
						<td colspan="2" style="background-color: #dff0d8;text-align: center;">
							<strong>角色编辑</strong>
						</td>
					</tr>
					<tr style="display: none;">
						<th>id</th>
						<td><input type="hidden" id="id" name="id" value="${id }" /></td>
					</tr>
					<tr>
						<th style="background-color: #dff0d8;text-align: center;">角色名称</th>
						<td style="text-align: left;">
							<input type="text" name="roleName"
							  value="${role.name }"
							 id="role_name"  />
						</td>
					</tr>
					<tr>
						<th style="background-color: #dff0d8;text-align: center;">角色描述</th>
						<td style="text-align: left;">
						   <input type="text" name="roleDesc" value="${role.description }" id="role_desc" />
						</td>
					</tr>
					
					<tr>
						<th style="background-color: #dff0d8;text-align: center;">状态</th>
						<td style="text-align: left;" >
						    <select id="status">
						        <option value="1" <c:if test="${role.status == 1 }">selected="true"</c:if>>启用</option>
						        <option value="0" <c:if test="${role.status == 0 }">selected="true"</c:if>>禁用</option>
						    </select>
						</td>
					</tr>
					<tr>
						<th style="background-color: #dff0d8;text-align: center;">角色权限</th>
						<td>
							<div id="optionDiv">
								[<a id="expandOrCollapseAllBtn" href="#" title="展开/折叠全部资源" onclick="return false;">展开/折叠</a>]
								[<a id="checkAllTrueOrFalse" href="#" title="全选/全不选" onclick="return false;">全选/全不选</a>]
							</div>
							<ul id="treeDemo2" class="ztree"></ul>
						</td>
					</tr>
					<tr>
						<td style="text-align: center;" colspan="2">
							<button id="saveRoleBtn" class="btn btn-success">
								<i class="icon-ok icon-white"></i> 保存
							</button>
							<button class="btn btn-inverse" onclick="history.go(-1);">
								<i class="icon-arrow-left icon-white"></i> 返回
							</button>
						</td>
					</tr>
				</table>
	</form>
	
<script type="text/javascript">
		$(function(){
			var setting = {
					check: {
						enable: true,
						dblClickExpand: false
					},view: {
						fontCss: getFontCss
					},callback: {
						onClick: onClick
					}
			};
			function onClick(e,treeId, treeNode) {
				var zTree = $.fn.zTree.getZTreeObj("treeDemo2");
				zTree.expandNode(treeNode);
			}
			
			function getFontCss(treeId, treeNode) {
				return (!!treeNode.highlight) ? {color:"#A60000", "font-weight":"bold"} : {color:"#333", "font-weight":"normal"};
			}
			
			loadMenusTree($("#id").val());
			
			//加载菜单树
			function loadMenusTree(id){
				$.ajax({
					url:"${pageContext.request.contextPath}/boss/resource/role/ajax_list",
					type:"post",
					data:{"roleId":id},
					dataType:"text",
					success:function(data, textStatus){
						var zNodes = eval('('+data+')');
						$.fn.zTree.init($("#treeDemo2"), setting, zNodes);
						
						$("#role_name").focus();
					},
					error:function(){
						alert("error");
					}
				});
			}
			
			//编辑角色
			$("#saveRoleBtn").click(function(){
				var roleName = $("#role_name").val();
				if(roleName==''){
					alert("角色名称不能为空！");
					return false;
				}
				
				$.blockUI({ message: "处理中，请稍候...",css: { 
		            border: 'none', 
		            padding: '15px', 
		            backgroundColor: '#000', 
		            '-webkit-border-radius': '10px', 
		            '-moz-border-radius': '10px', 
		            opacity: .5, 
		            color: '#fff' 
		        } }); 
				
				var ids = "";
				var treeObj = $.fn.zTree.getZTreeObj("treeDemo2");
				var nodes = treeObj.getCheckedNodes(true);
				for(var i=0;i<nodes.length;i++){
					ids+=nodes[i].id+",";
				}
				if(ids == ""){
					alert("请给这个角色添加资源！");
					jQuery.unblockUI();
					return false;
				}
				$.ajax({
					url:"${pageContext.request.contextPath}/boss/role/saveorupdate",
					type : "post",
					data : {
						privileges : ids,
						id : $("#id").val(),
						roleName : roleName,
						roleDesc : $("#role_desc").val(),
						status:$("#status").val()
					},
					dataType : "text",
					success : function(data) {
						data=eval("("+data+")");
						jQuery.unblockUI();
						if(data.sucess){
							alert("操作成功！");
							window.location.href="${pageContext.request.contextPath}/boss/role/list";
						}else{
							alert("操作失败！");
							return;
						}
					},
					error : function() {
						jQuery.unblockUI();
						alert("修改角色失败！");
					}
				
				});
				return false;
			});
			
			$("#expandOrCollapseAllBtn").bind("click", {type:"expandOrCollapse"}, expandNode);
			$("#checkAllTrueOrFalse").bind("click", {type:"checkAllTrueOrFalse"}, expandNode);
		});
		
		var expandAllFlg = true;
		var checkAllTrueOrFalseFlg = true;
		function expandNode(e) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo2"),
			type = e.data.type,
			nodes = zTree.getSelectedNodes();

			if (type == "expandAll") {
				zTree.expandAll(true);
			} else if (type == "collapseAll") {
				zTree.expandAll(false);
			} else if (type == "expandOrCollapse") {
				zTree.expandAll(expandAllFlg);
				expandAllFlg = !expandAllFlg;
			} else if (type == "checkAllTrueOrFalse") {
				zTree.checkAllNodes(checkAllTrueOrFalseFlg);
				checkAllTrueOrFalseFlg = !checkAllTrueOrFalseFlg;
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
</script>
</body>
</html>
