package com.ncshop.controlls;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import me.chanjar.weixin.mp.api.WxMpInMemoryConfigStorage;
import me.chanjar.weixin.mp.api.WxMpMessageRouter;
import me.chanjar.weixin.mp.api.WxMpService;
import me.chanjar.weixin.mp.api.WxMpServiceImpl;
import me.chanjar.weixin.mp.bean.WxMpTemplateData;
import me.chanjar.weixin.mp.bean.WxMpTemplateMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;

import sun.rmi.runtime.Log;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.ncshop.domain.OrderItemArr;
import com.ncshop.domain.TAddress;
import com.ncshop.domain.TGoods;
import com.ncshop.domain.TGoodstype;
import com.ncshop.domain.TOrder;
import com.ncshop.domain.TOrderdetail;
import com.ncshop.domain.TSeller;
import com.ncshop.domain.TSellergoods;
import com.ncshop.domain.TUser;
import com.ncshop.domain.TempOrder;
import com.ncshop.service.UserService;
import com.ncshop.util.ConfigDao;
import com.ncshop.util.ConfigInfo;
import com.ncshop.util.LogBuilder;
import com.ncshop.util.TargetStrategy;

@Controller
@RequestMapping("user")
public class UserController {

	@Autowired
	private UserService userService;
	private WxMpInMemoryConfigStorage wxMpConfigStorage;
	private WxMpService wxMpService;
	private WxMpMessageRouter wxMpMessageRouter;

	/**
	 * 查找所有店铺信息
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/findAllShops")
	public void findAllShops(HttpServletResponse response) throws Exception {
		// 调用service查找 数据库
		try {
			List<TSeller> sellerList = userService.findAllSellers();
			String json = toJson(new TSeller(), sellerList, null);
			// 设置response的传输格式为json
			response.setContentType("application/json");
			response.getWriter().write(json);
		} catch (Exception e) {
			LogBuilder.writeToLog(e.getMessage());
		}
	}

	/**
	 * 查找店铺所有的商品
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/findSellergoods")
	public void findSellergoods(String sellerId, HttpServletResponse response) {
		try {
			TSeller seller = new TSeller();
			seller.setSellerId(Integer.parseInt(sellerId));
			// 调用service查找 数据库
			List<TSellergoods> sellerGoodsList = userService
					.findSellergoods(seller);
			String json = toJson(new TSellergoods(), sellerGoodsList, null);
			// 设置response的传输格式为json
			response.setContentType("application/json");
			response.getWriter().write(json);
		} catch (Exception e) {
			LogBuilder.writeToLog(e.getMessage());
		}

	}

	/**
	 * 查找店铺所有的商品
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/findGoodsdetail")
	public void findGoodsdetail(HttpServletRequest request,
			HttpServletResponse response) {

		try {
			// 调用service查找 数据库
			List<TSellergoods> sellerGoodsList = userService.findGoodsdetail();
			String json = toJson(new TSellergoods(), sellerGoodsList, null);
			request.setAttribute("goodDetail", sellerGoodsList);
			request.getRequestDispatcher("/admin/page/goods.jsp").forward(
					request, response);
			return;
		} catch (Exception e) {
			LogBuilder.writeToLog(e.getMessage());
		}

	}

	/**
	 * 查看商家单个商品
	 * 
	 * @param sellergoods
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/findSellergood")
	public void findSellergoods(TSellergoods sellergoods,
			HttpServletResponse response) {

		try {
			// 调用service查找 数据库
			List<TSellergoods> sellerGoodsList = userService
					.findSellergood(sellergoods);
			String json = toJson(new TSellergoods(), sellerGoodsList, null);
			// 设置response的传输格式为json
			response.setContentType("application/json");
			response.getWriter().write(json);
		} catch (Exception e) {
			LogBuilder.writeToLog(e.getMessage());
		}

	}

	/**
	 * 按商品类型获取商品数据
	 * 
	 * @param goodstype
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/findgoods")
	public void findSellergoods(TGoodstype goodstype,
			HttpServletResponse response, HttpServletRequest request)
			throws Exception {
		try {

			String page = request.getParameter("page");
			int pageCount;
			List<TGoods> goodsList = null;
			// 分页查找
			if (page != null) {
				pageCount = Integer.parseInt(page);
				// 调用service查找 数据库
				goodsList = userService.findgoods(goodstype,
						(pageCount - 1) * 10, 10);
			}
			String json = toJson(new TGoods(), goodsList, null);
			// 设置response的传输格式为json
			response.setContentType("application/json");
			response.getWriter().write(json);
		} catch (Exception e) {
			LogBuilder.writeToLog(e.getMessage());
		}

	}

	/**
	 * 查看商品
	 * 
	 * @param goods
	 * @return
	 */
	@RequestMapping("/findAllGoods")
	public void findGoods(HttpServletResponse response,
			HttpServletRequest request) {
		try {
			String page = request.getParameter("page");
			System.out.println(page);
			int pageCount;
			List<TGoods> goodsList = null;
			// 分页查找
			if (page != null) {
				pageCount = Integer.parseInt(page);
				goodsList = userService.findAllGoods((pageCount - 1) * 10, 10);
			}
			String json = toJson(new TGoods(), goodsList, null);
			// 设置response的传输格式为json
			response.setContentType("application/json");
			response.getWriter().write(json);
		} catch (Exception e) {
			LogBuilder.writeToLog(e.getMessage());
		}
	}

	/**
	 * 加入购物车
	 */
	@RequestMapping("/addOrders")
	public String addOrders(HttpServletRequest request,
			HttpServletResponse response) {
		TGoods goods;
		TOrderdetail orderdetail;
		String goodId;
		String num;
		try {

			String json = request.getParameter("jsonString");
			System.out.println(json);
			Set<TOrderdetail> orderdetails = new HashSet<TOrderdetail>();
			Gson gson = new Gson();
			OrderItemArr fromJson = gson.fromJson(json, OrderItemArr.class);

			double allCost = 0;
			double cost = 0;
			for (TempOrder item : fromJson.getArray()) {
				goodId = item.getGoodsId();
				num = item.getBuyMount();
				goods = userService.findgoodsById(goodId);
				orderdetail = new TOrderdetail();
				orderdetail.setTGoods(goods);
				orderdetail.setBuyMount(Integer.parseInt(num));
				cost = Integer.parseInt(num) * goods.getGoodsPrice();
				orderdetail.setBuyCost(cost);
				allCost += cost;
				orderdetails.add(orderdetail);
			}
			request.getSession().setAttribute("odersdetails", orderdetails);

			request.getSession().setAttribute("allCost", allCost);
			TUser user = (TUser) request.getSession().getAttribute("user");
			List<TAddress> address = null;
			if (user != null) {

				if (user.getUserId()!=null) {
					address = userService.findAddress(user.getUserId());
				}
			}
			request.setAttribute("address", address);
			request.getRequestDispatcher("/custom/MyOrder.jsp").forward(
					request, response);
			return null;

		} catch (Exception e) {
			LogBuilder.writeToLog(e.getMessage());
		}
		return null;
	}

	/**
	 * 下订单
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/buy")
	public void buy(HttpServletRequest request, HttpServletResponse response) {

		String msg = "";
		TOrderdetail tOrderdetail = null;
		try {
			Set<TOrderdetail> odersdetails = (Set<TOrderdetail>) request
					.getSession().getAttribute("odersdetails");
			double orderTotalCost = 0.0;
			TUser user = (TUser) request.getSession().getAttribute("user");

			initMessageContext();
			WxMpTemplateMessage templateMessage = new WxMpTemplateMessage();
			// templateMessage.setToUser(user.getOpenId());
			templateMessage.setToUser(user.getOpenId());
			// 发送给下单人的消息
			templateMessage
					.setTemplateId("IGEJWO5GBj7GOeIKIZJLVYwweZyPqTcfY0uhFu0NHog");
			templateMessage.setUrl("www.baidu.com");
			templateMessage.setTopColor("#ff0000");
			// 计算总金额

			for (Iterator iterator = odersdetails.iterator(); iterator
					.hasNext();) {
				tOrderdetail = (TOrderdetail) iterator.next();
				orderTotalCost += tOrderdetail.getBuyCost()
						* tOrderdetail.getBuyMount();
				msg += "                 "
						+ tOrderdetail.getTGoods().getGoodsName() + "  x"
						+ tOrderdetail.getBuyMount() + "\n";
			}

			TOrder order = new TOrder();
			order.setOrderNo(new Date().getTime() + "");
			order.setOrderState(0);
			order.setOrderTotalCost(orderTotalCost);
			if (user == null) {
				order.setUserId(1);
			} else {
				order.setUserId(user.getUserId());
			}
			TSellergoods sellergoods = userService
					.findSellergoodsByGoodsID(tOrderdetail.getTGoods()
							.getGoodsId());
			order.setSellerId(sellergoods.getSeller().getSellerId());
			order.setOrderTime(new Date());
			if (userService.order(order, odersdetails)) {
				// 给用户发送消息
				templateMessage.getDatas().add(
						new WxMpTemplateData("orderId", order.getOrderNo(),
								"#173177"));
				templateMessage.getDatas()
						.add(new WxMpTemplateData("goodsInfo", "\n" + msg,
								"#173177"));
				templateMessage.getDatas().add(
						new WxMpTemplateData("totalCost", orderTotalCost
								+ " RMB", "#173177"));
				templateMessage.getDatas().add(
						new WxMpTemplateData("sellerPonhe", userService
								.findSellerByID(
										sellergoods.getSeller().getSellerId())
								.getSellerPhone(), "#173177"));
				wxMpService.templateSend(templateMessage);

				// 通知商家有新的订单

				WxMpTemplateMessage toBoss = new WxMpTemplateMessage();
				toBoss.setToUser("okbTSvpMmbJxwyVbK1_zlhrOXRbM");
				toBoss.setTemplateId("Y1tnm_eiApm6kia7trtGGIywhQJiDpmOAxuOCgeiHaY");
				toBoss.setUrl("www.baidu.com");
				toBoss.setTopColor("#ff0000");
				TAddress address = userService.findAddress(user.getUserId())
						.get(0);

				// TAddress address =new TAddress();
				// address.setAdsContent("sadas");
				// address.setAdsPhone("2312412");
				toBoss.getDatas().add(
						new WxMpTemplateData("address",
								address.getAdsContent(), "#173177"));
				toBoss.getDatas().add(
						new WxMpTemplateData("orderId", order.getOrderNo(),
								"#173177"));
				toBoss.getDatas().add(
						new WxMpTemplateData("userName", address
								.getReceiverName(), "#173177"));
				toBoss.getDatas().add(
						new WxMpTemplateData("phone", address.getAdsPhone(),
								"#ff0000"));
				toBoss.getDatas().add(
						new WxMpTemplateData("totalCost", orderTotalCost
								+ " RMB", "#173177"));
				System.out.println(toBoss.toJson());
				toBoss.getDatas()
						.add(new WxMpTemplateData("orderInfo", "\n" + msg,
								"#173177"));
				System.out.println(toBoss.toJson());
				wxMpService.templateSend(toBoss);
			}
			if (request.getSession().getAttribute("allCost") != null) {
				request.getSession().removeAttribute("allCost");
			}
			if (request.getSession().getAttribute("odersdetails") != null) {
				request.getSession().removeAttribute("odersdetails");
			}
			response.getWriter().write("1");
		} catch (Exception e) {
			LogBuilder.writeToLog(e.getMessage());
			try {
				response.getWriter().write(e.getMessage());
			} catch (Exception e1) {
				LogBuilder.writeToLog(e.getMessage());
				e1.printStackTrace();
			}
		}
	}

	/**
	 * 用户完善个人信息
	 * 
	 * @param user
	 * @param request
	 * @param response
	 */
	@RequestMapping("/addAddress")
	public void bindInfo(TAddress address, HttpServletRequest request,
			HttpServletResponse response) {
		try {
			TUser user = (TUser) request.getSession().getAttribute("user");
			if (user != null) {
				if (user.getUserId() != null) {// 老用户添加新的默认地址
					address.setUserId(user.getUserId());
					if (userService.updateAddress(user.getUserId(), address)) {
						List<TAddress> findAddress = userService
								.findAddress(user.getUserId());
						request.setAttribute("address", findAddress);
					}
				} else {// 新用户
					address.setIsDefault(true);
					userService.bind(user, address);
					List<TAddress> firstAdr = new ArrayList<TAddress>();
					firstAdr.add(address);
					request.setAttribute("address", firstAdr);
				}
			} else {
				// 本地测试进入
				address.setIsDefault(true);
				userService.bind(new TUser(), address);
				List<TAddress> addresses = new ArrayList<TAddress>();
				addresses.add(address);
				request.setAttribute("address", addresses);
			}
			request.getRequestDispatcher("/custom/MyOrder.jsp").forward(
					request, response);
		} catch (Exception e) {
			LogBuilder.writeToLog(e.getMessage());
		}
	}

	/**
	 * 审核订单
	 * 
	 * @param orderId
	 */
	@RequestMapping("/verifyOrder")
	public void verifyOrder(String orderId) {

		try {

			TOrder order = userService.findOrderById(orderId);
			TUser user = userService.findUserById(order.getOrderId());
			//

			if (userService.upadateOrder(orderId)) {
				initMessageContext();
				WxMpTemplateMessage message = new WxMpTemplateMessage();

				message.setTemplateId("u9BtTXrmJlAYHbNF4YOzDNHootsjqkwljm-Krn-NzA0");
				message.setTopColor("#ff000");
				message.setToUser(user.getOpenId());
				message.getDatas()
						.add(new WxMpTemplateData("info", "订单号为"
								+ order.getOrderNo() + "的订单已受理，正在配送", "#173177"));
				wxMpService.templateSend(message);
			}
		} catch (Exception e) {
			LogBuilder.writeToLog(e.getMessage());
		}

	}

	/**
	 * 将集合转换成json
	 * 
	 * @param t
	 * @param list
	 * @param fieldNames
	 * @param flag
	 * @return
	 */
	private <T> String toJson(T t, List<T> list, String[] fieldNames) {

		try {
			Gson gson = null;
			Map<String, List<T>> map = new HashMap<String, List<T>>();
			map.put(t.getClass().getName().replace("com.ncshop.domain.", ""),
					list);
			if (fieldNames != null) {
				TargetStrategy ts = null;
				ts = new TargetStrategy(t.getClass());
				ts.setReverse(true);
				ts.setFields(fieldNames);
				gson = new GsonBuilder().setExclusionStrategies(ts).create();
			} else {
				gson = new Gson();
			}
			String json = gson.toJson(map);
			System.out.println(json);
			return json;
		} catch (Exception e) {
			LogBuilder.writeToLog(e.getMessage());
			return null;
		}

	}

	private void initMessageContext() {
		ConfigDao configDao = new ConfigDao();
		ConfigInfo configInfo = configDao.GetConfig();
		wxMpConfigStorage = new WxMpInMemoryConfigStorage();
		wxMpConfigStorage.setAppId(configInfo.getWeChatAppID()); // 设置微信公众号的appid
		wxMpConfigStorage.setSecret(configInfo.getWeChatAppSecret()); // 设置微信公众号的app
		wxMpConfigStorage.setToken(configInfo.getWeChatToken()); // 设置微信公众号的token
		wxMpConfigStorage.setAesKey(configInfo.getWeChatAESKey()); // 设置微信公众号的EncodingAESKey
		wxMpService = new WxMpServiceImpl();
		wxMpService.setWxMpConfigStorage(wxMpConfigStorage);

	}
	
	@RequestMapping("/findOrdersByUser")
	public void findOrdersByUser(String userId,HttpServletRequest request,HttpServletResponse response){
		
		try {
			List<TOrder> orders = userService.findOrderByeUser(userId);
			request.setAttribute("orderList", orders);
			request.getRequestDispatcher("/custom/OrderList.jsp").forward(request, response);
			return;
		} catch (Exception e) {
			LogBuilder.writeToLog(e.getMessage());
			e.printStackTrace();
		}
	}

}
