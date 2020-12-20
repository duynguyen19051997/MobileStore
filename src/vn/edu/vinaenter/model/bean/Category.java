package vn.edu.vinaenter.model.bean;

import javax.validation.constraints.NotEmpty;

public class Category {
	private int cid;
	@NotEmpty(message = "Vui lòng nhập Tên Danh Mục")
	private String cname;
	private String create_by;
	private int parent_id;

	public String getCreate_by() {
		return create_by;
	}

	public void setCreate_by(String create_by) {
		this.create_by = create_by;
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

	public int getParent_id() {
		return parent_id;
	}

	public void setParent_id(int parent_id) {
		this.parent_id = parent_id;
	}

	public Category(int cid, @NotEmpty(message = "Vui lòng nhập Tên Danh Mục") String cname, String create_by,
			int parent_id) {
		super();
		this.cid = cid;
		this.cname = cname;
		this.create_by = create_by;
		this.parent_id = parent_id;
	}

	public Category() {
		super();
	}

}
