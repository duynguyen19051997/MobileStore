package vn.edu.vinaenter.model.bean;

import java.sql.Timestamp;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

public class User {

	private int id;
	private int enable;
	private int role_id;

	@NotEmpty(message = "Vui lòng nhập Username!")
	@Size(min = 2, message = "Tối thiểu 2 kí tự!")
	private String username;

	@NotEmpty(message = "Vui lòng nhập Họ tên!")
	private String fullname;
	private String password;

	@NotEmpty(message = "Vui lòng nhập Username!")
	@Email(message = "Vui lòng nhập đúng Email!")
	private String email;

	@NotEmpty(message = "Vui lòng nhập Địa chỉ!")
	private String address;

	@NotEmpty(message = "Vui lòng nhập Số điện thoại!")
	@Size(max = 10, message = "Tối thiểu 10 kí tự!")
	private String phone;

	private String name;

	private Timestamp date_create;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getEnable() {
		return enable;
	}

	public void setEnable(int enable) {
		this.enable = enable;
	}

	public int getRole_id() {
		return role_id;
	}

	public void setRole_id(int role_id) {
		this.role_id = role_id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Timestamp getDate_create() {
		return date_create;
	}

	public void setDate_create(Timestamp date_create) {
		this.date_create = date_create;
	}

	public User(int id, int enable, int role_id,
			@NotEmpty(message = "Vui lòng nhập Username!") @Size(min = 2, message = "Tối thiểu 2 kí tự!") String username,
			@NotEmpty(message = "Vui lòng nhập Họ tên!") String fullname, String password,
			@NotEmpty(message = "Vui lòng nhập Username!") @Email(message = "Vui lòng nhập đúng Email!") String email,
			@NotEmpty(message = "Vui lòng nhập Địa chỉ!") String address,
			@NotEmpty(message = "Vui lòng nhập Số điện thoại!") @Size(max = 10, message = "Tối thiểu 10 kí tự!") String phone,
			String name, Timestamp date_create) {
		super();
		this.id = id;
		this.enable = enable;
		this.role_id = role_id;
		this.username = username;
		this.fullname = fullname;
		this.password = password;
		this.email = email;
		this.address = address;
		this.phone = phone;
		this.name = name;
		this.date_create = date_create;
	}

	public User() {
		super();
	}

}
