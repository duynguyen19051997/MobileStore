package vn.edu.vinaenter.model.bean;

public class Item {

	private Book product;
	private int quantity;

	public Book getProduct() {
		return product;
	}

	public void setProduct(Book product) {
		this.product = product;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public Item(Book product, int quantity) {
		super();
		this.product = product;
		this.quantity = quantity;
	}

	public Item() {
		super();
	}

}
