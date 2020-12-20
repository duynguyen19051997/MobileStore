package duynguyen.model.bean;

import java.sql.Timestamp;

public class Comment {
	private int cmt_id;
	private int parent_id;
	private int id;
	private int bid;
	private int active;
	private String bname;
	private String username;
	private String content;
	private Timestamp date_create;

	public String getBname() {
		return bname;
	}

	public void setBname(String bname) {
		this.bname = bname;
	}

	public Comment(int cmt_id, int parent_id, int id, int bid, int active, String bname, String username,
			String content, Timestamp date_create) {
		super();
		this.cmt_id = cmt_id;
		this.parent_id = parent_id;
		this.id = id;
		this.bid = bid;
		this.active = active;
		this.bname = bname;
		this.username = username;
		this.content = content;
		this.date_create = date_create;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getCmt_id() {
		return cmt_id;
	}

	public void setCmt_id(int cmt_id) {
		this.cmt_id = cmt_id;
	}

	public int getParent_id() {
		return parent_id;
	}

	public void setParent_id(int parent_id) {
		this.parent_id = parent_id;
	}

	public int getBid() {
		return bid;
	}

	public void setBid(int bid) {
		this.bid = bid;
	}

	public int getActive() {
		return active;
	}

	public void setActive(int active) {
		this.active = active;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Timestamp getDate_create() {
		return date_create;
	}

	public void setDate_create(Timestamp date_create) {
		this.date_create = date_create;
	}

	public Comment(int cmt_id, int parent_id, int id, int bid, int active, String username, String content,
			Timestamp date_create) {
		super();
		this.cmt_id = cmt_id;
		this.parent_id = parent_id;
		this.id = id;
		this.bid = bid;
		this.active = active;
		this.username = username;
		this.content = content;
		this.date_create = date_create;
	}

	public Comment(int cmt_id, int parent_id, int id, int bid, int active, String username, String content) {
		super();
		this.cmt_id = cmt_id;
		this.parent_id = parent_id;
		this.id = id;
		this.bid = bid;
		this.active = active;
		this.username = username;
		this.content = content;
	}

	public Comment() {
		super();
	}

}
