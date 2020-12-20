package duynguyen.model.bean;

public class BillDetail {
	private int bd_id;
	private int bill_id;
	private int bid;
	private String bname;
	private int number;
	private int price;

	public String getBname() {
		return bname;
	}

	public void setBname(String bname) {
		this.bname = bname;
	}

	public int getBd_id() {
		return bd_id;
	}

	public void setBd_id(int bd_id) {
		this.bd_id = bd_id;
	}

	public int getBill_id() {
		return bill_id;
	}

	public void setBill_id(int bill_id) {
		this.bill_id = bill_id;
	}

	public int getBid() {
		return bid;
	}

	public void setBid(int bid) {
		this.bid = bid;
	}

	public int getNumber() {
		return number;
	}

	public void setNumber(int number) {
		this.number = number;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public BillDetail(int bd_id, int bill_id, int bid, String bname, int number, int price) {
		super();
		this.bd_id = bd_id;
		this.bill_id = bill_id;
		this.bid = bid;
		this.bname = bname;
		this.number = number;
		this.price = price;
	}

	public BillDetail() {
		super();
	}

}
