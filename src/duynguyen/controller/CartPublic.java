package duynguyen.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import duynguyen.model.bean.Product;
import duynguyen.model.bean.Item;
import duynguyen.model.bean.User;
import duynguyen.model.dao.BillDao;
import duynguyen.model.dao.BillDetailDao;
import duynguyen.model.dao.ProductDAO;
import duynguyen.util.ActionCart;

@Controller
public class CartPublic {

	@Autowired
	private ProductDAO bookDao;

	@Autowired
	private BillDao billDao;

	@Autowired
	private BillDetailDao billDetaiDao;

	@PostMapping("addcart")
	public @ResponseBody int addCart(@RequestParam(name = "aQuantity", required = false) Integer quantity,
			@RequestParam("aIdPro") int bid, HttpSession session) {
		if (quantity == null) {
			quantity = 1;
		}
		Product objPro = bookDao.getItemByBidPublic(bid);
		if (objPro == null) {
			return 0;
		}
		@SuppressWarnings("unchecked")
		List<Item> listCart = (ArrayList<Item>) session.getAttribute("listCart");
		if (listCart == null) {
			listCart = new ArrayList<Item>();
			listCart.add(new Item(objPro, quantity));

		} else {
			for (Item item : listCart) {
				if (item.getProduct().getBid() == bid) {
					item.setQuantity(item.getQuantity() + quantity);
					return ActionCart.totalItems(listCart);
				}
			}
			listCart.add(new Item(objPro, quantity));
		}
		return ActionCart.totalItems(listCart);
	}

	@PostMapping("addcartupper")
	public @ResponseBody int addCartUpper(@RequestParam(name = "aQuantity", required = false) Integer quantity,
			@RequestParam("aIdPro") int bid, HttpSession session) {
		if (session.getAttribute("listCart") == null) {
			return 0;
		}
		@SuppressWarnings("unchecked")
		List<Item> listCart = (ArrayList<Item>) session.getAttribute("listCart");
		for (Item item : listCart) {
			if (item.getProduct().getBid() == bid) {
				item.setQuantity(quantity);
				break;
			}
		}
		return ActionCart.totalItems(listCart);
	}

	@PostMapping("showcart")
	public @ResponseBody List<Item> showCart(HttpSession session) {
		if (session.getAttribute("listCart") == null) {
			return null;
		} else {
			@SuppressWarnings("unchecked")
			List<Item> listCart = (ArrayList<Item>) session.getAttribute("listCart");
			return listCart;
		}
	}

	@PostMapping("deletecart")
	public @ResponseBody List<Item> deleteCart(HttpSession session,
			@RequestParam(name = "aId", required = false) Integer id) {
		if (session.getAttribute("listCart") == null) {
			return null;
		}
		@SuppressWarnings("unchecked")
		List<Item> listCart = (ArrayList<Item>) session.getAttribute("listCart");
		if (listCart.size() == 0) {
			session.removeAttribute("listCart");
			return null;
		} else {
			for (Item item : listCart) {
				if (item.getProduct().getBid() == id) {
					listCart.remove(item);
					break;
				}
			}
			return listCart;
		}
	}

	@PostMapping("checkout")
	public @ResponseBody int checkOut(HttpSession session, HttpServletResponse response, HttpServletRequest request) {
		@SuppressWarnings("unchecked")
		List<Item> listCart = (ArrayList<Item>) session.getAttribute("listCart");
		if (session.getAttribute("user") == null) {
			try {
				response.sendRedirect(request.getContextPath() + "/login.html");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		User infUser = (User) session.getAttribute("user");
		if (listCart.size() > 0) {
			float total = ActionCart.total(listCart);
			int billId = billDao.addItemPublic(infUser, total);
			System.out.println(billId);
			for (Item item : listCart) {
				if (billDetaiDao.addItemPublic(item, billId) == 0) {
					System.out.println("Có lỗi");
					break;
				}
			}
		}
		session.removeAttribute("listCart");
		return 0;
	}
}
