<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>ZTREE DEMO - Standard Data </title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link href="${request.getContextPath }/static/zTree3.1/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css" />
  
    <script type="text/javascript">
		var setting = {
		    view: {
		        selectedMulti: false        //禁止多点选中
	        },
		    data: {
			    simpleData: {
				    enable:true,
				    idKey: "id",
				    pIdKey: "pId",
				    rootPId: ""
			    }
		    },
		    callback: {
			    onClick: function(treeId, treeNode) {
				    var treeObj = $.fn.zTree.getZTreeObj(treeNode);
                    var selectedNode = treeObj.getSelectedNodes()[0];
                    $("#txtId").val(selectedNode.id);
                    $("#txtAddress").val(selectedNode.name);
			    }
		    }
		};
		var zNodes =[
			{id:1, pId:0, name:"广东", open:true},
		    {id:101, pId:1, name:"广州", file:"core/standardData"},
		    {id:102, pId:1, name:"深圳", file:"core/simpleData"},
		    {id:103, pId:1, name:"东莞", file:"core/noline"}
		];

		$(document).ready(function(){
			$.fn.zTree.init($("#treeDemo"), setting, zNodes);
		});
	</script>
</head>
<body>
    <div style="float:left;" >
        <ul id="treeDemo" class="ztree">
        </ul>
    </div>
    <div style="float:left;" >
        id: <input id="txtId" type="text" value="" /><br />
        地名：<input id="txtAddress" type="text" value="" />
    </div>
   <script type="text/javascript" src="${request.getContextPath }/static/js/jquery-1.4.2.min.js"></script>
   <script type="text/javascript" src="${request.getContextPath }/static/zTree3.1/js/jquery.ztree.all-3.1.min.js"></script>
</body>
</html>