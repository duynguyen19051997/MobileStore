package duynguyen.util;

import java.util.List;

import duynguyen.model.bean.Item;

public class ActionCart {

	public static int totalItems(List<Item> listItem) {
		int total = 0;
		if (listItem.isEmpty()) {
			return 0;
		}
		for (Item item : listItem) {
			total += item.getQuantity();
		}
		return total;
	}
	
	public static float total(List<Item> listItem) {
		float total = 0;
		if (listItem.isEmpty()) {
			return 0;
		}
		for (Item item : listItem) {
			total += item.getQuantity() * item.getProduct().getPrice() * (1 - item.getProduct().getDiscount());
		}
		return total;
	}

}
