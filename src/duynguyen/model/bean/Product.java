package duynguyen.model.bean;

import java.sql.Timestamp;

import javax.validation.constraints.NotEmpty;

public class Product {
	private int bid;
	private int count_view;
	private int cid;
	private int enable;
	
	private double price;
	private double discount;

	@NotEmpty(message="Vui lòng nhập Tên sản phẩm")
	private String bname;
	
	@NotEmpty(message="Vui lòng nhập Mô tả")
	private String decription;
	
	private String picture;
	private String create_by;
	
	@NotEmpty(message="Vui lòng nhập Chi tiết")
	private String detail;
	private String cname;

	private Timestamp date_create;

	public int getEnable() {
		return enable;
	}

	public void setEnable(int enable) {
		this.enable = enable;
	}

	public int getCid() {
		return cid;
	}

	public void setCid(int cid) {
		this.cid = cid;
	}

	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public int getBid() {
		return bid;
	}

	public void setBid(int bid) {
		this.bid = bid;
	}

	public int getCount_view() {
		return count_view;
	}

	public void setCount_view(int count_view) {
		this.count_view = count_view;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public double getDiscount() {
		return discount;
	}

	public void setDiscount(double discount) {
		this.discount = discount;
	}

	public String getBname() {
		return bname;
	}

	public void setBname(String bname) {
		this.bname = bname;
	}

	public String getDecription() {
		return decription;
	}

	public void setDecription(String decription) {
		this.decription = decription;
	}

	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	public String getCreate_by() {
		return create_by;
	}

	public void setCreate_by(String create_by) {
		this.create_by = create_by;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public Timestamp getDate_create() {
		return date_create;
	}

	public void setDate_create(Timestamp date_create) {
		this.date_create = date_create;
	}

	public Product() {
		super();
	}

	public Product(int bid, int count_view, int cid, int enable, double price, double discount, String bname,
			String decription, String picture, String create_by, String detail, String cname, Timestamp date_create) {
		super();
		this.bid = bid;
		this.count_view = count_view;
		this.cid = cid;
		this.enable = enable;
		this.price = price;
		this.discount = discount;
		this.bname = bname;
		this.decription = decription;
		this.picture = picture;
		this.create_by = create_by;
		this.detail = detail;
		this.cname = cname;
		this.date_create = date_create;
	}

}
