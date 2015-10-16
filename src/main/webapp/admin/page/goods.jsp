<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

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
<link rel="stylesheet" href="${pageContext.request.contextPath }/plugins/fonts/font-awesome.css" />

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
						<li><a href="#">商品管理</a></li>
					</ul>
					<jsp:include page="../WebPart/SearchBox.jsp"></jsp:include>
				</div>
				<div class="page-content">
					<jsp:include page="../WebPart/Skin.jsp"></jsp:include>
					<div class="row">
						<div class="col-xs-12">
							<!-- PAGE CONTENT BEGINS -->
							<h3 class="header smaller lighter blue">所有商品</h3>

							<div class="clearfix">
								<div class="pull-right tableTools-container"></div>
							</div>
							<div class="table-header">商品列表</div>
							<table id="dynamic-table"
								class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th class="center"><label class="pos-rel"> <input
												type="checkbox" class="ace" /> <span class="lbl"></span> </label>
										</th>
										<th><small>ID</small></th>
										<th><small>名称</small></th>
										<th><small>价格</small></th>
										<th><small>商户</small></th>
										<th><small>类别</small></th>
										<th><small>图片</small></th>
										<th><small>简介</small></th>
										<th><small>状态</small></th>
										<th>
											<p class="text-center">
												<a class="blue buttongoods" href="javascript:void(0)"
													id="buttonadd" oper="add"> <i
													class="fa fa-plus-square-o bigger-130"><small>添加商品</small>
												</i> </a>
											</p>
										</th>
									</tr>
								</thead>

								<tbody>
									<c:forEach items="${requestScope.goodDetail}" var="trl" varStatus="status">
									<tr>
										<td class="center"><label class="pos-rel"> <input
												type="checkbox" class="ace" /> <span class="lbl"></span> </label>
										</td>
										<td>${trl.TGoods.goodsId}</td>
										<td class="hidden-480">${trl.TGoods.goodsName}</td>
										<td class="hidden-480">${trl.TGoods.goodsPrice}</td>
										<td class="hidden-480">${trl.seller.sellerName}</td>
										<td class="hidden-480">${trl.TGoods.TGoodstype.goodsTypeName}</td>
										<td><a name="time" href="javascript:void(0);"
											data-container="body" data-toggle="popover"
											data-placement="bottom" data-content="${trl.TGoods.goodsPic}"> </a>
										</td>
										<td id="roleSeq${trl.TGoods.goodsMsg}"><span class="label label-sm "
											name="roleSeq${trl.TGoods.goodsMsg}">${trl.TGoods.goodsMsg}</span></td>
										<td class="hidden-480">${trl.TGoods.goodsMsg}</td>
										<td>
											<div class="hidden-sm hidden-xs action-buttons">
												<a class="blue buttongoods" href="javascript:void(0)"
													name="${trl.TGoods.goodsId}" oper="detaill"> <i
													class="fa fa-search-plus bigger-130"><small></small> </i> </a>
												<a class="green buttongoods" href="javascript:void(0)"
													name="${trl.TGoods.goodsId}" oper="modify"> <i
													class="fa fa-pencil bigger-130"><small></small> </i> </a> <a
													class="red buttongoods" href="javascript:void(0)"
													name="${trl.TGoods.goodsId}" oper="delete"> <i
													id="roleSeqAction${trl.TGoods.goodsId}"
													class="fa fa-toggle-off bigger-130"
													name="roleSeqAction${trl.TGoods.goodsId}"></i> </a>
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
															name="${trl.TGoods.goodsId}" onclick="GetDetail(this)"
															class="tooltip-info" data-rel="tooltip" title="View">
																<span class="blue"> <i
																	class="ace-icon fa fa-search-plus bigger-120"></i> </span> </a>
														</li>

														<li><a href="javascript:void(0)"
															name="${trl.TGoods.goodsId}" onclick="Modify(this)"
															class="tooltip-success" data-rel="tooltip" title="Edit">
																<span class="green"> <i
																	class="ace-icon fa fa-pencil-square-o bigger-120"></i>
															</span> </a>
														</li>

														<li><a href="ClassDelete?classId=${trl.TGoods.goodsId}"
															class="tooltip-error" data-rel="tooltip" title="Delete">
																<span class="red"> <i
																	class="ace-icon fa fa-trash-o bigger-120"></i> </span> </a>
														</li>
													</ul>
												</div>
											</div>
										</td>
									</tr>
									</c:forEach>
								</tbody>
							</table>
							<!-- PAGE CONTENT ENDS -->
						</div>

						<div id="dialog-message" class="hide">
							<form id="formgoodsinfo" method="post" enctype="multipart/form-data">
								<input type="hidden" name="oper" value="" id="oper"/>
								<div class="col-sm-12">
									<div class="form-group col-sm-12">
										<label class="col-sm-3 control-label no-padding-right"
											for="form-field-1">名称</label>

										<div class="col-sm-9">
											<input type="text" id="form-field-1" name="goodsName"
												placeholder="商品名称" class="col-xs-12 col-sm-12" />
										</div>
									</div>
									<div class="form-group col-sm-12">
										<label class="col-sm-3 control-label no-padding-right"
											for="form-field-1">价格</label>

										<div class="col-sm-9">
											<input onkeyup="value=value.replace(/[^0-9|.]/g,'')" type="text" id="form-field-1" name="goodsPrice"
												placeholder="商品价格" class="col-xs-12 col-sm-12" />
										</div>
									</div>
									<div class="form-group col-sm-12">
										<label for="goodsShop"
											class="col-sm-3 control-label no-padding-right">商店</label>
										<div class="col-sm-9">
											<select
												class="chosen-select form-control col-xs-12 col-sm-12"
												name="sellerId" id="goodsShop"
												data-placeholder="Choose a State...">
												<option value=""></option>
											</select>
										</div>
									</div>
									<div class="form-group col-sm-12">
										<label for="goodsType"
											class="col-sm-3 control-label no-padding-right">分类</label>
										<div class="col-sm-9">
											<select
												class="chosen-select form-control col-xs-12 col-sm-12"
												name="goodsTypeId" id="goodsType"
												data-placeholder="Choose a State...">
												<option value=""></option>
											</select>
										</div>
									</div>
									<div class="form-group col-sm-12">
										<label class="col-sm-3 control-label no-padding-right"
											for="id-input-field-2">照片</label>
										<div class="col-sm-9">
											<input type="file" name="pic" id="id-input-file-3" />
										</div>
									</div>
									<div class="form-group col-sm-12">
										<label class="col-sm-3 control-label no-padding-right"
											for="form-field-1">简介</label>

										<div class="col-sm-9">
											<textarea id="form-field-11"
												class="autosize-transition form-control" name="goodsMsg"
												maxlength="100"></textarea>
										</div>
									</div>
								</div>

								<div class="hr hr-12 hr-double"></div>

								<div style="width:100%;text-align: center" id="error"></div>
								<div>
									<button style="margin-left:10px" class="btn btn-info col-sm-5" id="goodssave"
										type="button">
										<i class="ace-icon fa fa-check bigger-110"></i>保存
									</button>
									<button style="margin-left:25px" class="btn btn-success col-sm-5" id="goodssave"
										type="reset">
										<i class="ace-icon fa fa-check bigger-110"></i>重置
									</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="../WebPart/CopyRight.jsp"></jsp:include>
	</div>
	<jsp:include page="../WebPart/Script.jsp"></jsp:include>
	<!-- page specific plugin scripts -->
	<script src="http://ace.zcdreams.com/assets/js/jquery-ui.js"></script>
	<script src="http://malsup.github.io/jquery.form.js"></script>
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
		$(document)
				.ready(
						function() {
							//获取商品类型
							$
									.ajax({
										type : "post",
										url : "${pageContext.request.contextPath }/seller/getAllGoodsType",
										dataType : "json",
										async : false,
										/*这句可用可不用，没有影响*/
										contentType : "application/json; charset=utf-8",
										success : function(data) {
											var goodstypes = JSON .stringify(data.TGoodstype);
											var obj = JSON.parse(goodstypes);
											for ( var i = 0; i < obj.length; i++) {
												$("#goodsType").append("<option value='"+obj[i].goodsTypeId+"'>"+obj[i].goodsTypeName+"</option>");
											}
										},
										error : function(XMLHttpRequest,
												textStatus, errorThrown) {
											alert(errorThrown);
										}
									});
									//获取店铺信息类型
							$
									.ajax({
										type : "post",
										url : "${pageContext.request.contextPath }/seller/getAllSeller",
										dataType : "json",
										async : false,
										/*这句可用可不用，没有影响*/
										contentType : "application/json; charset=utf-8",
										success : function(data) {
											var goodstypes = JSON .stringify(data.TSeller);
											var obj = JSON.parse(goodstypes);
											for ( var i = 0; i < obj.length; i++) {
												$("#goodsShop").append("<option value='"+obj[i].sellerId+"'>"+obj[i].shopName+"</option>");
											}
										},
										error : function(XMLHttpRequest,
												textStatus, errorThrown) {
											alert(errorThrown);
										}
									});
							//图片上传 及数据保存 
							$("#goodssave")
									.click(
											function() {
												var ext = '.jpg.jpeg.gif.bmp.png.';
												var f = $("#file").val();
												if (f == "") { //先判断是否已选择了文件 
													$("#error")
															.attr("class",
																	"error_div")
															.html(
																	"<img src='../images/error_img2.gif' style='width:15px;height:15px;'/>"
																			+ "请添加商圈logo！");
													return false;
												}
												/* f = f.substr(f.lastIndexOf('.') + 1).toLowerCase();
												if (ext.indexOf('.' + f + '.') == -1) {
													$("#error").attr("class", "error_div").html("<img src='../images/error_img2.gif' style='width:15px;height:15px;'/>" + "图片格式不正确！");
													return false;
												} */

												var options = {
													url : "${pageContext.request.contextPath }/seller/addGoods",
													dataType : 'json',
													contentType : "application/json; charset=utf-8",
													success : function(data) {
														// 'data' is an object representing the the evaluated json data 
														// 如果图片上传成功则保存表单注册数据 
														if (data == "1") {
															$("#error").html("<font color='green'>操作成功!</font>");
															//var fileName = data.fileName;
															//alert(fileName);
															/* $.ajax({
																type : "post",
																url : "${pageContext.request.contextPath }/user/findAllGoods",
																dataType : "json",
																这句可用可不用，没有影响
																contentType : "application/json; charset=utf-8",
																success : function(data) {
																	alert(data);
																	if (typeof(data)=="object") {
																		$("#error").html("<font color='green'>操作成功!</font>");
																	} else {
																		$("#error").html("<font color='red'>操作失败失败!原因是："+data+"</font>");
																	}
																},
																error : function(XMLHttpRequest,textStatus,errorThrown) {
																			alert(errorThrown);
																		}
															}); */
														} else {
															$("#error").attr("class","error_div").
																html("<img src='${ctx}/images/error_img2.gif' style='width:15px;height:15px;'/>"
																+ data.message);
														}
													}
												}
												// 提交表单 
												$('#formgoodsinfo').ajaxSubmit(
														options);
											});
							$('[data-toggle="popover"]').popover();
							//myEach();
							myEachPopover("time", 0, 10);

							//图片上传框
							$('#id-input-file-3').ace_file_input({
								style : 'well',
								btn_choose : '选择图片...',
								btn_change : null,
								no_icon : 'ace-icon fa fa-cloud-upload',
								droppable : true,
								thumbnail : 'small' //large | fit
								//,icon_remove:null//set null, to hide remove/reset button
								/**,before_change:function(files, dropped) {
									//Check an example below
									//or examples/file-upload.html
									return true;
								}*/
								/**,before_remove : function() {
									return true;
								}*/
								,
								preview_error : function(filename, error_code) {
									//name of the file that failed
									//error_code values
									//1 = 'FILE_LOAD_FAILED',
									//2 = 'IMAGE_LOAD_FAILED',
									//3 = 'THUMBNAIL_FAILED'
									//alert(error_code);
								}
							}).on('change', function() {
								console.log($(this).data('ace_input_files'));
								console.log($(this).data('ace_input_method'));

							});
							var whitelist_ext, whitelist_mime;
							var btn_choose;
							var no_icon;
							btn_choose = "选择照片...";
							no_icon = "ace-icon fa fa-picture-o";
							whitelist_ext = [ "jpeg", "jpg", "png", "gif",
									"bmp" ];
							whitelist_mime = [ "image/jpg", "image/jpeg",
									"image/png", "image/gif", "image/bmp" ];
							var file_input = $('#id-input-file-3');
							file_input.ace_file_input('update_settings', {
								'btn_choose' : btn_choose,
								'no_icon' : no_icon,
								'allowExt' : whitelist_ext,
								'allowMime' : whitelist_mime
							});
						});

		function myEach() {
			$("span[name='roleSeq1']").each(function() {
				try {
					$(this).removeClass("label-warning");
				} catch (e) {
				}
				$(this).addClass("label-success");
				$(this).text("有效角色");
			});
			$("span[name='roleSeq0']").each(function() {
				try {
					$(this).removeClass("label-success");
				} catch (e) {
				}
				$(this).addClass("label-warning");
				$(this).text("无效角色");
			});
			$("i[name='roleSeqAction1']").each(function() {
				try {
					$(this).removeClass("fa-toggle-off");
				} catch (e) {
				}
				$(this).addClass("fa-toggle-on");
				//$(this).text("刪除");
			});
			$("i[name='roleSeqAction0']").each(function() {
				try {
					$(this).removeClass("fa-toggle-on");
				} catch (e) {
				}
				$(this).addClass("fa-toggle-off");
				//$(this).text("激活");
			});
		}
		jQuery(function($) {
			$(".buttongoods")
					.click(
							function() {
								var oper = $(this).attr('oper');
								$("#oper").val(oper);
								var dialog = $("#dialog-message")
										.removeClass('hide')
										.dialog(
												{
													modal : true,
													title : (oper == 'detaill') ? "查看详细"
															: (oper == 'modify') ? "修改商品信息"
																	: (oper == 'delete') ? "确认删除商品"
																			: "添加商品",
													title_html : true,
												/* buttons: [{
													text: "关闭窗口",
													"class": "btn btn-minier",
													click: function() {
														$(this).dialog("close");
													}
												}, {
													text: "确定",
													"class": "btn btn-primary btn-minier",
													click: function() {
														var goods_type = "";
														$.ajax({
														type: "post",
														url: "../../seller/getAllGoodsType",
														enctype: 'multipart/form-data',
														data:$('#dialog-message').serialize(),//$("#dialog-message").serialize(),
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
												}] */
												});
							});
			//initiate dataTables plugin
			var oTable1 = $('#dynamic-table')
			//.wrap("<div class='dataTables_borderWrap' />")   //if you are applying horizontal scrolling (sScrollX)
			.dataTable({
				bAutoWidth : false,
				"aoColumns" : [ {
					"bSortable" : false
				}, null, null, null, null, null, null, null, null, {
					"bSortable" : false
				} ],
				"aaSorting" : [],
				//,
				//"sScrollY": "200px",
				"bPaginate" : true,
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
				"body" : "DTTT_Print",
				"info" : "tableTools-alert gritter-item-wrapper gritter-info gritter-center white",
				"message" : "tableTools-print-navbar"
			}
			//initiate TableTools extension
			var tableTools_obj = new $.fn.dataTable.TableTools(
					oTable1,
					{
						"sSwfPath" : "http://ace.zcdreams.com/assets/js/dataTables/extensions/TableTools/swf/copy_csv_xls_pdf.swf", //in Ace demo ../assets will be replaced by correct assets path
						"sRowSelector" : "td:not(:last-child)",
						"sRowSelect" : "multi",
						"fnRowSelected" : function(row) {
							//check checkbox when row is selected
							try {
								$(row).find('input[type=checkbox]').get(0).checked = true
							} catch (e) {
							}
						},
						"fnRowDeselected" : function(row) {
							//uncheck checkbox
							try {
								$(row).find('input[type=checkbox]').get(0).checked = false
							} catch (e) {
							}
						},
						"sSelectedClass" : "success",
						"aButtons" : [
								{
									"sExtends" : "copy",
									"sToolTip" : "复制到剪贴板",
									"sButtonClass" : "btn btn-white btn-primary btn-bold",
									"sButtonText" : "<i class='fa fa-copy bigger-110 pink'></i>",
									"fnComplete" : function() {
										this
												.fnInfo(
														'<h3 class="no-margin-top smaller">Table copied</h3>\<p>Copied '
																+ (oTable1
																		.fnSettings()
																		.fnRecordsTotal())
																+ 'row(s) to the clipboard.</p>',
														1500);
									}
								},
								{
									"sExtends" : "xls",
									"sToolTip" : "导出Excel",
									"sButtonClass" : "btn btn-white btn-primary  btn-bold",
									"sCharSet" : "utf8",
									"sButtonText" : "<i class='fa fa-file-excel-o bigger-110 green'></i>"
								},
								{
									"sExtends" : "pdf",
									"sToolTip" : "Export to PDF",
									"sButtonClass" : "btn btn-white btn-primary  btn-bold",
									"sButtonText" : "<i class='fa fa-file-pdf-o bigger-110 red'></i>"
								},
								{
									"sExtends" : "print",
									"sToolTip" : "Print view",
									"sButtonClass" : "btn btn-white btn-primary  btn-bold",
									"sButtonText" : "<i class='fa fa-print bigger-110 grey'></i>",
									"sMessage" : "<div class='navbar navbar-default'><div class='navbar-header pull-left'><a class='navbar-brand' href='#'><small>Optional Navbar &amp; Text</small></a></div></div>",
									"sInfo" : "<h3 class='no-margin-top'>Print view</h3>\
									  <p>Please use your browser's print function to\
									  print this table.\
									  <br />Press <b>escape</b> when finished.</p>",
								} ]
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
									container : 'body'
								});
							else
								$(this).tooltip({
									container : 'body'
								});
						});
			}, 200);
			//ColVis extension
			var colvis = new $.fn.dataTable.ColVis(oTable1, {
				"buttonText" : "<i class='fa fa-search'></i>",
				"aiExclude" : [ 0, 6 ],
				"bShowAll" : true,
				//"bRestore": true,
				"sAlign" : "right",
				"fnLabel" : function(i, title, th) {
					return $(th).text(); //remove icons, etc
				}
			});
			//style it
			$(colvis.button()).addClass('btn-group').find('button').addClass(
					'btn btn-white btn-info btn-bold')
			//and append it to our table tools btn-group, also add tooltip
			$(colvis.button()).prependTo('.tableTools-container .btn-group')
					.attr('title', '选择要导出的数据列').tooltip({
						container : 'body'
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
				placement : tooltip_placement
			});
			//tooltip placement on right or left
			function tooltip_placement(context, source) {
				var $source = $(source);
				var $parent = $source.closest('table')
				var off1 = $parent.offset();
				var w1 = $parent.width();
				var off2 = $source.offset();
				//var w2 = $source.width();
				if (parseInt(off2.left) < parseInt(off1.left)
						+ parseInt(w1 / 2))
					return 'right';
				return 'left';
			}
		});
	</script>
</body>

</html>