<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../../common/common.jsp"%>
<title>后台资源管理</title>
</head>

<body>
	<form action="" name="form" id="form" method="post" theme="simple">
		<table class="table table-bordered table-condensed table-hover">
			<tr>
				<td colspan="16">
					<button class="btn btn-primary" onclick="return selectList();">
						<i class="icon-search icon-white"></i> 查询
					</button>
						
					<button class="btn btn-success" onclick="return toAdd();">
						<i class="icon-plus-sign icon-white"></i> 添加
					</button>
						
					<button class="btn btn-warning" onclick="return editSelect();">
						<i class="icon-edit icon-white"></i> 编辑
					</button>
					
					<button method="catalog!deletes.action" class="btn btn-danger" onclick="return deleteSelect();">
						<i class="icon-remove-sign icon-white"></i> 删除
					</button>
					
				</td>
			</tr>
		</table>
	</form>

	<table id="treegrid" title="资源列表目录" class="easyui-treegrid" style="min-width:800px;min-height:250px"
			data-options="
				url: '${pageContext.request.contextPath}/boss/resource/ajax_list',
				method: 'get',
				rownumbers: true,
				idField: 'id',
				treeField: 'name',
				onClickRow:function(row){
					//alert(row.id);
				}
			">
		<thead>
			<tr>
				<th data-options="field:'id'" nowrap="nowrap">ID</th>
				<th data-options="field:'name'" nowrap="nowrap">名称</th>
				<th data-options="field:'type'" nowrap="nowrap">类型</th>
				<th data-options="field:'url'" nowrap="nowrap">url</th>
			</tr>
		</thead>
	</table>
	
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.4/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.4/themes/icon.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.4/demo/demo.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.4/jquery.easyui.min.js"></script>
<script type="text/javascript">

	function deleteSelect() {
		var node = $('#treegrid').treegrid('getSelected');
		if (!node) {
			alert("请选择要删除的类别！");
			return false;
		}
		try{
			if(confirm("确定删除选择的记录?")){
				$.blockUI({ message: "系统处理中，请等待...",css: { 
			        border: 'none', 
			        padding: '15px', 
			        backgroundColor: '#000', 
			        '-webkit-border-radius': '10px', 
			        '-moz-border-radius': '10px', 
			        opacity: .5, 
			        color: '#fff' 
			    }});
				var _url = "delete?id="+node.id;
				$.ajax({
				  type: 'POST',
				  url: _url,
				  data: {},
				  dataType: "json", 
				  async:false,
				  success: function(data){
					  data=eval("("+data+")");
					  jQuery.unblockUI();
					  if(data.sucess){
						  alert("操作成功！");
						  window.location.reload();
					  }else{
						  alert("操作失败！");
						  window.location.reload();
					  }
					  
				  },
				  dataType: "text",
				  error:function(){
					  	jQuery.unblockUI();
						alert("加载失败，请联系管理员。");
				  }
				});
			}
		}catch(e){
			console.log("eee="+e);
		}
		return false;
	}
	//编辑
	function editSelect(){
		var node = $('#treegrid').treegrid('getSelected');
		if (!node) {
			alert("请选择要编辑的类别！");
			return false;
		}
        var _url = "${pageContext.request.contextPath}/boss/resource/add?id="+node.id;
        var _form = $("#form");
		_form.attr("action",_url);
		_form.submit();
	}
	
	function selectList(){
		var _url = "${pageContext.request.contextPath}/boss/resource/list";
        var _form = $("#form");
		_form.attr("action",_url);
		_form.submit();
	}
	
	function toAdd(){
		var _url = "${pageContext.request.contextPath}/boss/resource/add";
        var _form = $("#form");
		_form.attr("action",_url);
		_form.submit();
	}
	
</script>
</body>
</html>
