package vn.edu.vinaenter.model.bean;

import java.sql.Timestamp;

public class Bill {
	private int bill_id;
	private int user_id;
	private int status;
	private Timestamp date_create;
	private float total;
	private String username;

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public int getBill_id() {
		return bill_id;
	}

	public void setBill_id(int bill_id) {
		this.bill_id = bill_id;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Timestamp getDate_create() {
		return date_create;
	}

	public void setDate_create(Timestamp date_create) {
		this.date_create = date_create;
	}

	public float getTotal() {
		return total;
	}

	public void setTotal(float total) {
		this.total = total;
	}

	public Bill(int bill_id, int user_id, int status, Timestamp date_create, float total, String username) {
		super();
		this.bill_id = bill_id;
		this.user_id = user_id;
		this.status = status;
		this.date_create = date_create;
		this.total = total;
		this.username = username;
	}

	public Bill() {
		super();
	}

}
