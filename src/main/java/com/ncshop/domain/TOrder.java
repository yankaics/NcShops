package com.ncshop.domain;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * TOrder entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_order", catalog = "ncshop")
public class TOrder implements java.io.Serializable {

	// Fields

	private Integer orderId;
	// private TUser user;
	private Integer userId;
	private String orderNo;
	private Integer sellerId;
	// private TSeller seller;
	private Date orderTime = new Date();
	private Double orderTotalCost = 0.0;
	private String orderMsg;
	private Integer orderState = 0;// 默认0：已生成；1:已支付
	private Set<TOrderdetail> TOrderdetails = new HashSet<TOrderdetail>(0);

	// Property accessors
	@Id
	@Column(name = "orderId", unique = true, nullable = false)
	@GeneratedValue(strategy = javax.persistence.GenerationType.IDENTITY)
	public Integer getOrderId() {
		return this.orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}

	// @ManyToOne(fetch = FetchType.EAGER)
	// @JoinColumn(name = "userId")
	// public TUser getUser() {
	// return user;
	// }
	//
	// public void setUser(TUser user) {
	// this.user= user;
	// }

	@Column(name = "orderNo", length = 20)
	public String getOrderNo() {
		return this.orderNo;
	}
	@Column(name = "userId", length = 11)
	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	@Column(name = "sellerId", length = 11)
	public Integer getSellerId() {
		return sellerId;
	}

	public void setSellerId(Integer sellerId) {
		this.sellerId = sellerId;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	// @ManyToOne(fetch = FetchType.EAGER)
	// @JoinColumn(name = "sellerId")
	// public TSeller getSeller() {
	// return seller;
	// }
	//
	// public void setSeller(TSeller seller) {
	// this.seller = seller;
	// }
	// @Temporal(TemporalType.TIMESTAMP)
	@Column(name = "orderTime")
	public Date getOrderTime() {
		return this.orderTime;
	}

	public void setOrderTime(Date orderTime) {
		this.orderTime = orderTime;
	}

	@Column(name = "orderTotalCost", precision = 22, scale = 0)
	public Double getOrderTotalCost() {
		return this.orderTotalCost;
	}

	public void setOrderTotalCost(Double orderTotalCost) {
		this.orderTotalCost = orderTotalCost;
	}

	@Column(name = "orderMsg", length = 100)
	public String getOrderMsg() {
		return this.orderMsg;
	}

	public void setOrderMsg(String orderMsg) {
		this.orderMsg = orderMsg;
	}

	@Column(name = "orderState")
	public Integer getOrderState() {
		return this.orderState;
	}

	public void setOrderState(Integer orderState) {
		this.orderState = orderState;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
	@JoinColumn(name = "orderId")
	public Set<TOrderdetail> getTOrderdetails() {
		return this.TOrderdetails;
	}

	public void setTOrderdetails(Set<TOrderdetail> TOrderdetails) {
		this.TOrderdetails = TOrderdetails;
	}

	@Override
	public String toString() {
		return "TOrder [orderId=" + orderId + ", userId=" + userId
				+ ", orderNo=" + orderNo + ", sellerId=" + sellerId
				+ ", orderTime=" + orderTime + ", orderTotalCost="
				+ orderTotalCost + ", orderMsg=" + orderMsg + ", orderState="
				+ orderState + ", TOrderdetails=" + TOrderdetails + "]";
	}

}
