package duynguyen.model.bean;

import java.sql.Timestamp;

public class Bill {
	private int bill_id;
	private int user_id;
	private int status;
	private Timestamp date_create;
	private float total;
	private float deposits;
	private float rest_money;
	private String username;
	private String email;
	private String phone;
	private String address;

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public float getDeposits() {
		return deposits;
	}

	public void setDeposits(float deposits) {
		this.deposits = deposits;
	}

	public float getRest_money() {
		return rest_money;
	}

	public void setRest_money(float rest_money) {
		this.rest_money = rest_money;
	}

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

	public Bill(int bill_id, int user_id, int status, Timestamp date_create, float total, float deposits,
			float rest_money, String username) {
		super();
		this.bill_id = bill_id;
		this.user_id = user_id;
		this.status = status;
		this.date_create = date_create;
		this.total = total;
		this.deposits = deposits;
		this.rest_money = rest_money;
		this.username = username;
	}

	public Bill(int bill_id, int user_id, int status, Timestamp date_create, float total, float deposits,
			float rest_money, String username, String email, String phone, String address) {
		super();
		this.bill_id = bill_id;
		this.user_id = user_id;
		this.status = status;
		this.date_create = date_create;
		this.total = total;
		this.deposits = deposits;
		this.rest_money = rest_money;
		this.username = username;
		this.email = email;
		this.phone = phone;
		this.address = address;
	}

	public Bill() {
		super();
	}

}
