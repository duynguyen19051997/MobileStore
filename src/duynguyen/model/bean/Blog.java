package duynguyen.model.bean;

import java.sql.Timestamp;

public class Blog {
	private int blog_id;
	private String blog_name;
	private String image;
	private String content;
	private String create_by;
	private Timestamp create_date;
	private int status;
	private int count_view;
	private int cid;
	private String cname;

	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public int getBlog_id() {
		return blog_id;
	}

	public void setBlog_id(int blog_id) {
		this.blog_id = blog_id;
	}

	public String getBlog_name() {
		return blog_name;
	}

	public void setBlog_name(String blog_name) {
		this.blog_name = blog_name;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getCreate_by() {
		return create_by;
	}

	public void setCreate_by(String create_by) {
		this.create_by = create_by;
	}

	public Timestamp getCreate_date() {
		return create_date;
	}

	public void setCreate_date(Timestamp create_date) {
		this.create_date = create_date;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getCount_view() {
		return count_view;
	}

	public void setCount_view(int count_view) {
		this.count_view = count_view;
	}

	public int getCid() {
		return cid;
	}

	public void setCid(int cid) {
		this.cid = cid;
	}

	public Blog(String blog_name, String image, String content, String create_by, Timestamp create_date, int status,
			int count_view, int cid) {
		super();
		this.blog_name = blog_name;
		this.image = image;
		this.content = content;
		this.create_by = create_by;
		this.create_date = create_date;
		this.status = status;
		this.count_view = count_view;
		this.cid = cid;
	}

	public Blog(int blog_id, String blog_name, String image, String content, String create_by, Timestamp create_date,
			int status, int count_view, int cid, String cname) {
		super();
		this.blog_id = blog_id;
		this.blog_name = blog_name;
		this.image = image;
		this.content = content;
		this.create_by = create_by;
		this.create_date = create_date;
		this.status = status;
		this.count_view = count_view;
		this.cid = cid;
		this.cname = cname;
	}

	public Blog() {
		super();
	}

}
