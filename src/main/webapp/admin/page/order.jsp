<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	response.setHeader("Access-Control-Allow-Origin", "*");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta charset="utf-8" />
<title>商城管理系统</title>

<meta name="description" content="" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

<!-- bootstrap & fontawesome -->
<link rel="stylesheet"
	href="http://ace.zcdreams.com/assets/css/bootstrap.css" />
<link rel="stylesheet"
	href="http://ace.zcdreams.com/assets/css/chosen.css" />

<link rel="stylesheet"
	href="${pageContext.request.contextPath }/plugins/fonts/font-awesome.css" />

<!-- page specific plugin styles -->
<link rel="stylesheet"
	href="http://ace.zcdreams.com/assets/css/jquery-ui.css" />
<link rel="stylesheet"
	href="http://ace.zcdreams.com/assets/css/chosen.css" />
<link rel="stylesheet"
	href="http://ace.zcdreams.com/assets/css/jquery.gritter.css" />
<!-- text fonts -->
<link rel="stylesheet"
	href="http://ace.zcdreams.com/assets/css/ace-fonts.css" />

<!-- ace styles -->
<link rel="stylesheet" href="http://ace.zcdreams.com/assets/css/ace.css"
	class="ace-main-stylesheet" id="main-ace-style" />

<!--[if lte IE 9]>
			<link rel="stylesheet" href="http://ace.zcdreams.com/assets/css/ace-part2.css" class="ace-main-stylesheet" />
		<![endif]-->

<!--[if lte IE 9]>
		  <link rel="stylesheet" href="http://ace.zcdreams.com/assets/css/ace-ie.css" />
		<![endif]-->

<!-- inline styles related to this page -->

<!-- ace settings handler -->
<script src="http://ace.zcdreams.com/assets/js/ace-extra.js"></script>

<!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->

<!--[if lte IE 8]>
		<script src="http://ace.zcdreams.com/assets/js/html5shiv.js"></script>
		<script src="http://ace.zcdreams.com/assets/js/respond.js"></script>
		<![endif]-->
</head>

<body class="no-skin">
	<jsp:include page="../WebPart/Head.jsp"></jsp:include>
	<div class="main-container" id="main-container">
		<script type="text/javascript">
			try {
				ace.settings.check('main-container', 'fixed');
			} catch (e) {
			}
		</script>
		<jsp:include page="../WebPart/Menu.jsp"></jsp:include>
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="breadcrumbs" id="breadcrumbs">
					<script type="text/javascript">
						try {
							ace.settings.check('breadcrumbs', 'fixed');
						} catch (e) {
						}
					</script>
					<ul class="breadcrumb">
						<li><i class="ace-icon fa fa-home home-icon"></i><a href="#">商城管理系统</a>
						</li>
						<li><a href="#">订单管理</a></li>
					</ul>
					<jsp:include page="../WebPart/SearchBox.jsp"></jsp:include>
				</div>
				<div class="page-content">
					<jsp:include page="../WebPart/Skin.jsp"></jsp:include>
					<div class="row">
						<div class="col-xs-12">
							<!-- PAGE CONTENT BEGINS -->
							<h3 class="header smaller lighter blue">所有订单</h3>

							<div class="clearfix">
								<div class="pull-right tableTools-container"></div>
							</div>
							<div class="table-header">订单列表</div>
							<table id="dynamic-table"
								class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th class="center"><label class="pos-rel"> <input
												type="checkbox" class="ace" /> <span class="lbl"></span> </label>
										</th>
										<th><small>订单号</small></th>
										<th><small>客户ID</small></th>
										<th><small>商户ID</small></th>
										<th><i class="fa fa-clock-o bigger-130"><small>下单时间</small>
										</i></th>
										<th><small>应付</small></th>
										<th><small>状态</small></th>
										<th><a class="blue buttongoods" href="javascript:void(0)"
											id="buttonadd" oper="add"> <i
												class="fa fa-print red bigger-130"><b class="red">点击批量打印已勾选的订单</b>
											</i> </a>
										</th>
									</tr>
								</thead>

								<tbody>
									<c:forEach items="${requestScope.orderList}" var="trl"
										varStatus="status">
										<tr>
											<td class="center"><label class="pos-rel"> <input
													type="checkbox" class="ace" /> <span class="lbl"></span> </label>
												<p id="orderdetail${trl.orderId}" class="hide">
													<c:out value="{'table':["></c:out>
													<c:forEach items="${trl.TOrderdetails}" var="detail"
														varStatus="status">
														<c:out value="{'goodsName':'${detail.TGoods.goodsName}',"></c:out>
														<c:out value="'goodsPrice':'${detail.TGoods.goodsPrice}',"></c:out>
														<c:out value="'goodsCount':'${detail.buyMount}',"></c:out>
														<c:choose>
															<c:when test="${status.isLast() }">
																<c:out value="'buyCost':'${detail.buyCost}'}"></c:out>
															</c:when>
															<c:otherwise>
																<c:out value="'buyCost':'${detail.buyCost}'},"></c:out>
															</c:otherwise>
														</c:choose>
													</c:forEach>
													<c:out value="]}"></c:out>
												</p></td>
											<td>${trl.orderNo}</td>

											<td class="hidden-480"><a class="orderUserPopover"
												href="javascript:void(0);" data-container="body"
												data-placement="bottom" name="${trl.userId}">
													${trl.userId} </a>
											</td>
											<td class="hidden-480"><a class="orderSellerPopover"
												href="javascript:void(0);" data-container="body"
												data-placement="bottom" name="${trl.sellerId }">
													${trl.sellerId }</a>
											</td>
											<td class="hidden-480">${trl.orderTime}</td>
											<td class="hidden-480">${trl.orderTotalCost}</td>
											<td id="orderState${trl.orderId}"><span class=""
												name="orderState${trl.orderState}">${trl.orderState}</span>
											</td>
											<td>
												<div class="hidden-sm hidden-xs action-buttons">
													<a class="blue orderdetaill" href="javascript:void(0)"
														name="${trl.orderId}" oper="detaill"> <i
														class="fa fa-search-plus bigger-130"><small></small> </i>
													</a>
													<%-- <a class="red buttongoods" href="javascript:void(0)"
														name="${trl.orderId}" oper="delete"> 
														<i id="goodsIsSaleAction${trl.orderId}"
														class="fa fa-toggle-off bigger-130"
														name="goodsIsSaleAction${trl.orderId}" state="${trl.orderId}"></i> 
													</a> --%>
													<div class="col-sm-6">
														<select
															class="chosen-select form-control col-xs-12 col-sm-12 orderState"
															name="${trl.orderId}" oper="${trl.orderState}"
															id="orderState${trl.orderId}" data-placeholder="选择状态">
															<c:if test="${trl.orderState==0}">
																<option name="${trl.orderId}oso${trl.orderState}0"
																	value="0"></option>
																<option name="${trl.orderId}oso${trl.orderState}1"
																	value="1">确认</option>
																<option name="${trl.orderId}oso${trl.orderState}2"
																	value="2">配送</option>
																<option name="${trl.orderId}oso${trl.orderState}3"
																	value="3">成功</option>
																<option name="${trl.orderId}oso${trl.orderState}4"
																	value="4">取消</option>
															</c:if>
															<c:if test="${trl.orderState==1}">
																<option name="${trl.orderId}oso${trl.orderState}0"
																	value="0"></option>
																<option name="${trl.orderId}oso${trl.orderState}1"
																	value="1" selected="selected">确认</option>
																<option name="${trl.orderId}oso${trl.orderState}2"
																	value="2">配送</option>
																<option name="${trl.orderId}oso${trl.orderState}3"
																	value="3">成功</option>
																<option name="${trl.orderId}oso${trl.orderState}4"
																	value="4">取消</option>
															</c:if>
															<c:if test="${trl.orderState==2}">
																<option name="${trl.orderId}oso${trl.orderState}0"
																	value="0"></option>
																<option name="${trl.orderId}oso${trl.orderState}1"
																	value="1">确认</option>
																<option name="${trl.orderId}oso${trl.orderState}2"
																	value="2" selected="selected">配送</option>
																<option name="${trl.orderId}oso${trl.orderState}3"
																	value="3">成功</option>
																<option name="${trl.orderId}oso${trl.orderState}4"
																	value="4">取消</option>
															</c:if>
															<c:if test="${trl.orderState==3}">
																<option name="${trl.orderId}oso${trl.orderState}0"
																	value="0"></option>
																<option name="${trl.orderId}oso${trl.orderState}1"
																	value="1">确认</option>
																<option name="${trl.orderId}oso${trl.orderState}2"
																	value="2">配送</option>
																<option name="${trl.orderId}oso${trl.orderState}3"
																	value="3" selected="selected">成功</option>
																<option name="${trl.orderId}oso${trl.orderState}4"
																	value="4">取消</option>
															</c:if>
															<c:if test="${trl.orderState==4}">
																<option name="${trl.orderId}oso${trl.orderState}0"
																	value="0"></option>
																<option name="${trl.orderId}oso${trl.orderState}1"
																	value="1">确认</option>
																<option name="${trl.orderId}oso${trl.orderState}2"
																	value="2">配送</option>
																<option name="${trl.orderId}oso${trl.orderState}3"
																	value="3" selected="selected">成功</option>
																<option name="${trl.orderId}oso${trl.orderState}4"
																	value="4">取消</option>
															</c:if>
														</select>
													</div>
												</div>
												<div class="hidden-md hidden-lg">
													<div class="inline pos-rel">
														<button class="btn btn-minier btn-yellow dropdown-toggle"
															data-toggle="dropdown" data-position="auto">
															<i class="ace-icon fa fa-caret-down icon-only bigger-120"></i>
														</button>

														<ul
															class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
															<li><a href="javascript:void(0)"
																name="${trl.orderId}" onclick="GetDetail(this)"
																class="tooltip-info" data-rel="tooltip" title="View">
																	<span class="blue"> <i
																		class="ace-icon fa fa-search-plus bigger-120"></i> </span> </a></li>

															<li><a href="javascript:void(0)"
																name="${trl.orderId}" onclick="Modify(this)"
																class="tooltip-success" data-rel="tooltip" title="Edit">
																	<span class="green"> <i
																		class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																</span> </a></li>

															<li><a href="ClassDelete?classId=${trl.orderId}"
																class="tooltip-error" data-rel="tooltip" title="Delete">
																	<span class="red"> <i
																		class="ace-icon fa fa-trash-o bigger-120"></i> </span> </a></li>
														</ul>
													</div>
												</div></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<!-- PAGE CONTENT ENDS -->
						</div>
						<div id="sureprint" class="hide"></div>
						<div id="dialog-message" class="hide">
							<input disabled type="hidden" name="sellerId" value="0"
								id="sellerId" />
							<div class="col-sm-12">
								<div class="col-xs-12 col-sm-12 pricing-box" style="height:100%">
									<div class="widget-box widget-color-blue" style="height:100%">
										<div class="widget-header">
											<h5 class="widget-title bigger lighter">优选商城订单详情</h5>
										</div>

										<div class="widget-body">
											<div class="widget-main">
												<ul class="list-unstyled spaced2">
													<!-- 循环遍历域里的数据 -->
													<table style="width:100%">
														<c:forEach var="orderdetail" items="${odersdetails }">
															<tr>
																<td style="width:70%"><i
																	class="ace-icon fa fa-check green"></i>
																	${orderdetail.TGoods.goodsName }</td>
																<td style="width:10%">x${orderdetail.buyMount }</td>
																<td style="width:20%;text-align:right">￥<font
																	class="buyCost">${orderdetail.buyCost }</font>
																</td>
															</tr>
														</c:forEach>
													</table>
												</ul>

												<hr />
												<div id="orderPrice" class="price">
													<strong>${sessionScope.allCost }</strong><small>元</small>
												</div>
												<p>
													<c:out value="接收人：${address.receiverName }"></c:out>
												</p>
												<p>
													<c:out value="送货地址：${address.adsContent }"></c:out>
												</p>
												<p>
													<c:out value="联系方式：${address.adsPhone }"></c:out>
												</p>

											</div>

										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="../WebPart/CopyRight.jsp"></jsp:include>
	</div>
	<jsp:include page="../WebPart/Script.jsp"></jsp:include>
	<jsp:include page="../WebPart/Script.jsp"></jsp:include>
	<!-- page specific plugin scripts -->
	<script src="http://ace.zcdreams.com/assets/js/jquery-ui.js"></script>
	<script src="http://malsup.github.io/jquery.form.js"></script>
	<script src="http://ace.zcdreams.com/assets/js/chosen.jquery.js"></script>

	<script
		src="http://ace.zcdreams.com/assets/js/jquery.ui.touch-punch.js"></script>

	<script type="text/javascript"
		src="http://ace.zcdreams.com/assets/js/jquery.gritter.js"></script>
	<script
		src="http://ace.zcdreams.com/assets/js/dataTables/jquery.dataTables.js"></script>
	<script
		src="http://ace.zcdreams.com/assets/js/dataTables/jquery.dataTables.bootstrap.js"></script>
	<script src="http://ace.zcdreams.com/assets/js/bootstrap.min.js"></script>
	<script
		src="http://ace.zcdreams.com/assets/js/dataTables/extensions/TableTools/js/dataTables.tableTools.js"></script>
	<script
		src="http://ace.zcdreams.com/assets/js/dataTables/extensions/ColVis/js/dataTables.colVis.js"></script>
	<!-- inline scripts related to this page -->
	<script type="text/javascript">
$(document).ready(function() {
	$(".orderdetaill").click(function() {
		debugger;
		var orderId = $(this).attr("name");
		var orderdetails = $("#orderdetail" + orderId).text().replace(/\s/gi,'');
		console.log(JSON.stringify(orderdetails));
		var orderdetailsobj = JSON.parse(JSON.stringify(orderdetails));
		alert(orderdetailsobj.table);
		alert(orderdetailsobj.table.length);
		var dialog = $("#dialog-message").removeClass('hide').dialog({
			modal: true,
			title: "订单详情",
			title_html: true,
			buttons: [{
				text: "关闭窗口",
				"class": "btn btn-minier",
				click: function() {
					$(this).dialog("close");
				}
			}, {
				text: "确定并打印",
				"class": "btn btn-primary btn-minier",
				click: function() {
					var goods_type = "";
					$.ajax({
						type: "post",
						url: "../../seller/getAllGoodsType",
						enctype: 'multipart/form-data',
						data: $('#dialog-message').serialize(), //$("#dialog-message").serialize(),
						async: false,
						success: function(data) {
							var goods_types = JSON.stringify(data.TGoodstype);
							var obj = JSON.parse(goods_types);
							for (var i = 0; i < obj.length; i++) {
								goods_type += obj[i].goodsTypeId + ":" + obj[i].goodsTypeName;
								if (i < obj.length - 1) {
									goods_type += ";";
								}
							}
						}
					});
				}
			}]
		});
	});
	$(".orderState").change(function() {
		var orderId = $(this).attr("name");
		var orderState = $(this).val();
		$.ajax({
			type: "post",
			url: "${pageContext.request.contextPath }/seller / changeOrderState ",
			dataType: "json",
			data: {
				"orderId ": orderId,
				"orderState ": orderState
			},
			async: false,
			success: function(data) {
				if (data == "1") {
					$("td[id = 'orderState" + orderId + "'] span ").attr("name", "orderState" + orderState);
					myEach();
				} else {

				}
			},
			error: function() {
				alert("修改失败 ");
			}
		});
	});
});
//显示商家详细信息
$(".orderSellerPopover ").popover({
	html: true,
	title: function() {
		return "商家信息详情 ";
	},
	content: function() {
		var sellerinfo;
		var sellerid = $(this).attr('name');
		$.ajax({
			type: "post",
			url: "${pageContext.request.contextPath}/seller/getSellerById",
			dataType: "json",
			data: {
				"sellerId": sellerid
			},
			async: true,
			success: function(data) {
				var orderseller = JSON.stringify(data.TSeller);
				var obj = JSON.parse(orderseller);

				sellerinfo = " <p> 商店名：" + obj[0].shopName + "</p><br>" +
								"<p>老板:" + obj[0].sellerName + "</P><br>" + 
								"<p> 地址: " + obj[0].sellerAddress + "</P><br>" + 
								"<p>电话:" + obj[0].sellerPhone + "</P><br>";
				$("#seller " + sellerid).html(sellerinfo);
			},
			error: function(XMLHttpRequest, textStatus, errorThrown) {
				sellerinfo = errorThrown;
			}
		});
		return " < div id = 'seller" + $(this).attr('name') + "'> 查询中...... </div>";
	}
});
//显示订单用户信息
$(".orderUserPopover").popover({
	html: true,
	title: function() {
		return "订单客户详情";
	},
	content: function() {
		var userinfo;
		var userid = $(this).attr('name');
		$.ajax({
			type: "post",
			url: "${pageContext.request.contextPath }/seller/getUserById",
			dataType: "json",
			data: {
				"userId": userid
			},
			async: true,
			success: function(data) {
				var orderuser = JSON.stringify(data.TUser);
				var obj = JSON.parse(orderuser);
				var address = obj[0].TAddresses;
				for (var i = 0; i < address.length; i++) {
					if (address[i].isDefault) {
						userinfo = "<p>姓名：" + address[i].receiverName + "</p><br>" + "<p>电话:" + address[i].adsPhone + "</P><br>" + "<p>地址:" + address[i].adsContent + "</P><br>";
						break;
					}
				}
				$("#user" + userid).html(userinfo);
			},
			error: function(XMLHttpRequest, textStatus, errorThrown) {
				userinfo = errorThrown;
			}
		});
		return "<div id='user" + $(this).attr('name') + "'>查询中......</div>";
	}
});
myEach();

function myEach() {
	$(".orderState").each(function() {
		var state = $(this).attr("oper");
		var orderId = $(this).attr("name");
		$("option[name='" + orderId + "oso" + state + state + "']").attr("selected", "true");
		//alert($(this).find("option[value="+state+"]").val());
	});
	$("span[name='orderState0']").each(function() {
		$(this).attr("class", "");
		$(this).attr("class", "label label-sm");
		$(this).text("刚提交");
	});
	$("span[name='orderState1']").each(function() {
		$(this).attr("class", "");
		$(this).attr("class", "label label-sm label-info");
		$(this).text("已确认");
	});
	$("span[name='orderState2']").each(function() {
		$(this).attr("class", "");
		$(this).attr("class", "label label-sm label-warning");
		$(this).text("配送...");
	});
	$("span[name='orderState3']").each(function() {
		$(this).attr("class", "");
		$(this).attr("class", "label label-sm label-success");
		$(this).text("成功");
	});
	$("span[name='orderState4']").each(function() {
		$(this).attr("class", "");
		$(this).attr("class", "label label-sm label-danger");
		$(this).text("已取消");
	});
	$("i[name='goodsIsSaleActiontrue']").each(function() {
		try {
			$(this).removeClass("fa-toggle-off");
		} catch (e) {}
		$(this).addClass("fa-toggle-on");
		$(this).text("解除合作");
	});
	$("i[name='goodsIsSaleActionfalse']").each(function() {
		try {
			$(this).removeClass("fa-toggle-on");
		} catch (e) {}
		$(this).addClass("fa-toggle-off");
		$(this).text("开始合作");
	});
}
jQuery(function($) {

	//initiate dataTables plugin
	var oTable1 = $('#dynamic-table')
		//.wrap("<div class='dataTables_borderWrap' />")   //if you are applying horizontal scrolling (sScrollX)
		.dataTable({
			bAutoWidth: false,
			"aoColumns": [{
					"bSortable": false
				},
				null, null, null, null, null, null, {
					"bSortable": false
				}
			],
			"aaSorting": [],
			//,
			//"sScrollY": "200px",
			"bPaginate": true,
			//"sScrollX": "100%",
			//"sScrollXInner": "120%",
			//"bScrollCollapse": true,
			//Note: if you are applying horizontal scrolling (sScrollX) on a ".table-bordered"
			//you may want to wrap the table inside a "div.dataTables_borderWrap" element
			//"iDisplayLength": 50
		});
	//oTable1.fnAdjustColumnSizing();
	//TableTools settings
	TableTools.classes.container = "btn-group btn-overlap";
	TableTools.classes.print = {
			"body": "DTTT_Print",
			"info": "tableTools-alert gritter-item-wrapper gritter-info gritter-center white",
			"message": "tableTools-print-navbar"
		}
		//initiate TableTools extension
	var tableTools_obj = new $.fn.dataTable.TableTools(
		oTable1, {
			"sSwfPath": "http://ace.zcdreams.com/assets/js/dataTables/extensions/TableTools/swf/copy_csv_xls_pdf.swf", //in Ace demo ../assets will be replaced by correct assets path
			"sRowSelector": "td:not(:last-child)",
			"sRowSelect": "multi",
			"fnRowSelected": function(row) {
				//check checkbox when row is selected
				try {
					$(row).find('input[type=checkbox]').get(0).checked = true
				} catch (e) {}
			},
			"fnRowDeselected": function(row) {
				//uncheck checkbox
				try {
					$(row).find('input[type=checkbox]').get(0).checked = false
				} catch (e) {}
			},
			"sSelectedClass": "success",
			"aButtons": [{
				"sExtends": "copy",
				"sToolTip": "复制到剪贴板",
				"sButtonClass": "btn btn-white btn-primary btn-bold",
				"sButtonText": "<i class='fa fa-copy bigger-110 pink'></i>",
				"fnComplete": function() {
					this
						.fnInfo(
							'<h3 class="no-margin-top smaller">Table copied</h3>\<p>Copied ' + (oTable1
								.fnSettings()
								.fnRecordsTotal()) + 'row(s) to the clipboard.</p>',
							1500);
				}
			}, {
				"sExtends": "xls",
				"sToolTip": "导出Excel",
				"sButtonClass": "btn btn-white btn-primary  btn-bold",
				"sCharSet": "utf8",
				"sButtonText": "<i class='fa fa-file-excel-o bigger-110 green'></i>"
			}, {
				"sExtends": "pdf",
				"sToolTip": "Export to PDF",
				"sButtonClass": "btn btn-white btn-primary  btn-bold",
				"sButtonText": "<i class='fa fa-file-pdf-o bigger-110 red'></i>"
			}, {
				"sExtends": "print",
				"sToolTip": "Print view",
				"sButtonClass": "btn btn-white btn-primary  btn-bold",
				"sButtonText": "<i class='fa fa-print bigger-110 grey'></i>",
				"sMessage": "<div class='navbar navbar-default'><div class='navbar-header pull-left'><a class='navbar-brand' href='#'><small>Optional Navbar &amp; Text</small></a></div></div>",
				"sInfo": "<h3 class='no-margin-top'>Print view</h3>\
									  <p>Please use your browser's print function to\
									  print this table.\
									  <br />Press <b>escape</b> when finished.</p>",
			}]
		});
	//we put a container before our table and append TableTools element to it
	$(tableTools_obj.fnContainer())
		.appendTo($('.tableTools-container'));
	//also add tooltips to table tools buttons
	//addding tooltips directly to "A" buttons results in buttons disappearing (weired! don't know why!)
	//so we add tooltips to the "DIV" child after it becomes inserted
	//flash objects inside table tools buttons are inserted with some delay (100ms) (for some reason)
	setTimeout(function() {
		$(tableTools_obj.fnContainer()).find('a.DTTT_button').each(
			function() {
				var div = $(this).find('> div');
				if (div.length > 0)
					div.tooltip({
						container: 'body'
					});
				else
					$(this).tooltip({
						container: 'body'
					});
			});
	}, 200);
	//ColVis extension
	var colvis = new $.fn.dataTable.ColVis(oTable1, {
		"buttonText": "<i class='fa fa-search'></i>",
		"aiExclude": [0, 6],
		"bShowAll": true,
		//"bRestore": true,
		"sAlign": "right",
		"fnLabel": function(i, title, th) {
			return $(th).text(); //remove icons, etc
		}
	});
	//style it
	$(colvis.button()).addClass('btn-group').find('button').addClass(
			'btn btn-white btn-info btn-bold')
		//and append it to our table tools btn-group, also add tooltip
	$(colvis.button()).prependTo('.tableTools-container .btn-group')
		.attr('title', '选择要导出的数据列').tooltip({
			container: 'body'
		});
	//and make the list, buttons and checkboxed Ace-like
	$(colvis.dom.collection)
		.addClass(
			'dropdown-menu dropdown-light dropdown-caret dropdown-caret-right')
		.find('li').wrapInner('<a href="javascript:void(0)" />') //'A' tag is required for better styling
		.find('input[type=checkbox]').addClass('ace').next()
		.addClass('lbl padding-8');
	/////////////////////////////////
	//table checkboxes
	$('th input[type=checkbox], td input[type=checkbox]').prop(
		'checked', false);
	//select/deselect all rows according to table header checkbox
	$('#dynamic-table > thead > tr > th input[type=checkbox]').eq(0)
		.on(
			'click',
			function() {
				var th_checked = this.checked; //checkbox inside "TH" table header
				$(this).closest('table').find('tbody > tr')
					.each(function() {
						var row = this;
						if (th_checked)
							tableTools_obj.fnSelect(row);
						else
							tableTools_obj.fnDeselect(row);
					});
			});
	//select/deselect a row when the checkbox is checked/unchecked
	$('#dynamic-table').on(
		'click',
		'td input[type=checkbox]',
		function() {
			var row = $(this).closest('tr').get(0);
			if (!this.checked)
				tableTools_obj.fnSelect(row);
			else
				tableTools_obj.fnDeselect($(this).closest('tr')
					.get(0));
		});
	$(document).on('click', '#dynamic-table .dropdown-toggle',
		function(e) {
			e.stopImmediatePropagation();
			e.stopPropagation();
			e.preventDefault();
		});
	//And for the first simple table, which doesn't have TableTools or dataTables
	//select/deselect all rows according to table header checkbox
	var active_class = 'active';
	$('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on(
		'click',
		function() {
			var th_checked = this.checked; //checkbox inside "TH" table header
			$(this).closest('table').find('tbody > tr').each(
				function() {
					var row = this;
					if (th_checked)
						$(row).addClass(active_class).find(
							'input[type=checkbox]').eq(0)
						.prop('checked', true);
					else
						$(row).removeClass(active_class).find(
							'input[type=checkbox]').eq(0)
						.prop('checked', false);
				});
		});
	//select/deselect a row when the checkbox is checked/unchecked
	$('#simple-table').on('click', 'td input[type=checkbox]',
		function() {
			var $row = $(this).closest('tr');
			if (this.checked)
				$row.addClass(active_class);
			else
				$row.removeClass(active_class);
		});
	/********************************/
	//add tooltip for small view action buttons in dropdown menu
	$('[data-rel="tooltip"]').tooltip({
		placement: tooltip_placement
	});
	//tooltip placement on right or left
	function tooltip_placement(context, source) {
		var $source = $(source);
		var $parent = $source.closest('table')
		var off1 = $parent.offset();
		var w1 = $parent.width();
		var off2 = $source.offset();
		//var w2 = $source.width();
		if (parseInt(off2.left) < parseInt(off1.left) + parseInt(w1 / 2))
			return 'right';
		return 'left';
	}
});
//chosen plugin inside a modal will have a zero width because the select element is originally hidden
//and its width cannot be determined.
//so we set the width after modal is show
$('#modal-form').on('shown.bs.modal', function() {
	if (!ace.vars['touch']) {
		$(this).find('.chosen-container').each(function() {
			$(this).find('a:first-child').css('width', '210px');
			$(this).find('.chosen-drop').css('width', '210px');
			$(this).find('.chosen-search input').css('width', '200px');
		});
	}
});
/**
//or you can activate the chosen plugin after modal is shown
//this way select element becomes visible with dimensions and chosen works as expected
$('#modal-form').on('shown', function () {
	$(this).find('.modal-chosen').chosen();
})
 */
if (!ace.vars['touch']) {
	$('.chosen-select').chosen({
		allow_single_deselect: true
	});
	//resize the chosen on window resize

	$(window).off('resize.chosen').on('resize.chosen', function() {
		$('.chosen-select').each(function() {
			var $this = $(this);
			$this.next().css({
				'width': $this.parent().width()
			});
		})
	}).trigger('resize.chosen');
	//resize chosen on sidebar collapse/expand
	$(document).on('settings.ace.chosen',
		function(e, event_name, event_val) {
			if (event_name != 'sidebar_collapsed')
				return;
			$('.chosen-select').each(function() {
				var $this = $(this);
				$this.next().css({
					'width': $this.parent().width()
				});
			})
		});

	$('#chosen-multiple-style .btn').on('click', function(e) {
		var target = $(this).find('input[type=radio]');
		var which = parseInt(target.val());
		if (which == 2)
			$('#form-field-select-4').addClass('tag-input-style');
		else
			$('#form-field-select-4').removeClass('tag-input-style');
	});
} 
	</script>
</body>

</html>