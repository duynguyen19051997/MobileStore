package duynguyen.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import duynguyen.model.bean.User;
import duynguyen.model.dao.BillDao;
import duynguyen.model.dao.BookDAO;
import duynguyen.model.dao.CategoryDAO;
import duynguyen.model.dao.CommentDAO;
import duynguyen.model.dao.SlideDao;
import duynguyen.model.dao.UserDao;

@Controller
@RequestMapping("admin")
public class AdminIndexController {
	@Autowired
	private CategoryDAO catDao;

	@Autowired
	private UserDao userDao;

	@Autowired
	private BookDAO bookDao;

	@Autowired
	private SlideDao slideDao;

	@Autowired
	private CommentDAO cmtDao;

	@Autowired
	private BillDao billDao;

	@ModelAttribute
	public void commonObject(ModelMap modelMap, Principal principal) {
		User inforUser = userDao.getItemByUsername(principal.getName());
		modelMap.addAttribute("inforUser", inforUser);
	}

	@GetMapping("")
	public String index(ModelMap modelMap) {
		int totalCat = catDao.totalCat();
		int totalUser = userDao.totalUser();
		int totalBook = bookDao.totalProduct();
		int totalSlide = slideDao.totalSlide();
		int totalCmt = cmtDao.totalCmt();
		int totalBill = billDao.totalBill();
		modelMap.addAttribute("totalBill", totalBill);
		modelMap.addAttribute("totalCmt", totalCmt);
		modelMap.addAttribute("totalSlide", totalSlide);
		modelMap.addAttribute("totalBook", totalBook);
		modelMap.addAttribute("totalCat", totalCat);
		modelMap.addAttribute("totalUser", totalUser);
		return "bookstore.admin.index.index";
	}

}
