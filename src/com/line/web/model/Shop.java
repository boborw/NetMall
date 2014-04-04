package com.line.web.model;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="shop")
public class Shop {
	
	static public enum ShopStatus{
		AUDIT("待审核"),NORMAL("正常"),BAN("封禁");
		
		private final String name;
		
		ShopStatus(String name){
			this.name = name;
		}
		
		public String getName(){
			return name;
		}
	}
	
	private String id;

	public Shop() {
	}
	
	private String name;
	
	private int credit;
	
	private ShopStatus status;
	
	private List<Commodity> commoidities;
	
	private User shopKeeper;

	@Id
	@GeneratedValue(generator="sd")
	@GenericGenerator(name="sd",strategy="uuid")
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	@OneToOne
	@JoinColumn(name="boss")
	public User getShopKeeper() {
		return shopKeeper;
	}
	
	public void setShopKeeper(User shopKeeper) {
		this.shopKeeper = shopKeeper;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getCredit() {
		return credit;
	}

	public void setCredit(int credit) {
		this.credit = credit;
	}
	
	@OneToMany(mappedBy="enjoinShop")
	public List<Commodity> getCommoidities() {
		return commoidities;
	}

	public void setCommoidities(List<Commodity> commoidities) {
		this.commoidities = commoidities;
	}

	public ShopStatus getStatus() {
		return status;
	}

	public void setStatus(ShopStatus status) {
		this.status = status;
	}
	
	
}
