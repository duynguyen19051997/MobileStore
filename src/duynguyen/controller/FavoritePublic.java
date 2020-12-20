package duynguyen.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import duynguyen.model.bean.Book;
import duynguyen.model.bean.Item;
import duynguyen.model.dao.BookDAO;
import duynguyen.util.ActionCart;

@Controller
public class FavoritePublic {

	@Autowired
	private BookDAO bookDao;

	@PostMapping("addfavorite")
	public @ResponseBody int addFavorite(@RequestParam("aIdPro") int bid, HttpSession session) {
		Book objPro = bookDao.getItemByBidPublic(bid);
		if (objPro == null) {
			return 0;
		}
		@SuppressWarnings("unchecked")
		List<Item> listFavorite = (ArrayList<Item>) session.getAttribute("listFavorite");
		if (listFavorite == null) {
			listFavorite = new ArrayList<Item>();
			listFavorite.add(new Item(objPro, 1));

		} else {
			for (Item item : listFavorite) {
				if (item.getProduct().getBid() == bid) {
					return ActionCart.totalItems(listFavorite);
				}
			}
			listFavorite.add(new Item(objPro, 1));
		}
		return ActionCart.totalItems(listFavorite);
	}

	@PostMapping("deletefavorite")
	public @ResponseBody List<Item> deleteFavorite(HttpSession session,
			@RequestParam(name = "aId", required = false) Integer id) {
		if (session.getAttribute("listFavorite") == null) {
			return null;
		}
		@SuppressWarnings("unchecked")
		List<Item> listFavorite = (ArrayList<Item>) session.getAttribute("listFavorite");
		for (Item item : listFavorite) {
			if (item.getProduct().getBid() == id) {
				listFavorite.remove(item);
				break;
			}
		}
		return listFavorite;
	}
}
