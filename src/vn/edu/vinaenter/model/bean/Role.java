package vn.edu.vinaenter.model.bean;

public class Role {
	private int role_id;
	private String name;

	public int getRole_id() {
		return role_id;
	}

	public void setRole_id(int role_id) {
		this.role_id = role_id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Role() {
		super();
	}

	public Role(int role_id, String name) {
		super();
		this.role_id = role_id;
		this.name = name;
	}

}
