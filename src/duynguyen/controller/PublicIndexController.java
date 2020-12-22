package duynguyen.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import duynguyen.constant.Defines;
import duynguyen.model.bean.Category;
import duynguyen.model.bean.Comment;
import duynguyen.model.bean.Item;
import duynguyen.model.bean.Product;
import duynguyen.model.bean.Slide;
import duynguyen.model.bean.User;
import duynguyen.model.dao.CategoryDAO;
import duynguyen.model.dao.CommentDAO;
import duynguyen.model.dao.ProductDAO;
import duynguyen.model.dao.SlideDao;
import duynguyen.model.dao.UserDao;
import duynguyen.util.ActionCart;

@Controller
public class PublicIndexController {

	@Autowired
	private BCryptPasswordEncoder encode;

	@Autowired
	private UserDao userDao;

	@Autowired
	private CommentDAO cmtDao;

	@Autowired
	private CategoryDAO catDao;

	@Autowired
	private SlideDao slideDao;

	@Autowired
	private ProductDAO bookDao;

	@ModelAttribute
	public void commonObject(ModelMap modelMap) {
		List<Category> listParent = catDao.getItemsParent(0);
		modelMap.addAttribute("listParent", listParent);
		modelMap.addAttribute("catDao", catDao);
		modelMap.addAttribute("bookDao", bookDao);
	}

	@GetMapping("")
	public String index(ModelMap modelMap) {
		List<Slide> listSlide = slideDao.getItem();
		List<Product> listProLast = bookDao.getItemsLasted(0, Defines.ROW_COUNT_PUBLIC_INDEX);
		List<Product> listProCountView = bookDao.getItemsCountView(0, Defines.ROW_COUNT_PUBLIC_INDEX);
		modelMap.addAttribute("listProLast", listProLast);
		modelMap.addAttribute("listSlide", listSlide);
		modelMap.addAttribute("listProCountView", listProCountView);
		
		return "bookstore.public.index.index";
	}

	@GetMapping({ "{name}/{cid}/{page}.html", "product/{page}.html" })
	public String product(ModelMap modelMap, @PathVariable(name = "cid", required = false) Integer cid,
			@PathVariable(name = "page", required = false) Integer currentPage) {
		if (currentPage == null || currentPage < 1) {
			currentPage = 1;
		}
		int totalPro = 0;
		int numberOfPage = 0;
		if (cid != null) {
			Category objCat = catDao.getItemByCid(cid);
			if (objCat != null) {
				modelMap.addAttribute("objCat", objCat);
				if (objCat.getParent_id() == 0) {
					totalPro = bookDao.totalProductPublicByParent(objCat.getCid());
					int offset = (currentPage - 1) * Defines.ROW_COUNT_PUBLIC;
					List<Product> listProPublic = bookDao.getItemsPublicByParentId(objCat.getCid(), offset,
							Defines.ROW_COUNT_PUBLIC);
					modelMap.addAttribute("listProPublic", listProPublic);
					modelMap.addAttribute("totalProduct", totalPro);
				} else {
					totalPro = bookDao.totalBookByCidPublic(cid);
					int offset = (currentPage - 1) * Defines.ROW_COUNT_PUBLIC;
					List<Product> listProPublic = bookDao.getItemPublicByCid(cid, offset, Defines.ROW_COUNT_PUBLIC);
					modelMap.addAttribute("listProPublic", listProPublic);
					modelMap.addAttribute("totalProduct", totalPro);
				}
			} else {
				return "error/404";
			}
		} else {
			totalPro = bookDao.totalProductPublic();
			int offset = (currentPage - 1) * Defines.ROW_COUNT_PUBLIC;
			List<Product> listProPublic = bookDao.getItemsPublicPagination(offset, Defines.ROW_COUNT_PUBLIC);
			modelMap.addAttribute("listProPublic", listProPublic);
			modelMap.addAttribute("totalProduct", totalPro);
		}
		numberOfPage = (int) Math.ceil((double) totalPro / Defines.ROW_COUNT_PUBLIC);
		if (currentPage > numberOfPage) {
			currentPage = numberOfPage;
		}
		modelMap.addAttribute("numberOfPage", numberOfPage);
		modelMap.addAttribute("currentPage", currentPage);
		return "bookstore.public.index.product";
	}

	@GetMapping({ "search.html", "search/{page}.html" })
	public String search(ModelMap modelMap, @RequestParam("searchproduct") String search,
			@PathVariable(name = "page", required = false) Integer currentPage) {
		if (currentPage == null || currentPage < 1) {
			currentPage = 1;
		}
		int totalPro = bookDao.totalProductBySearchPublic(search);
		if (totalPro == 0) {
			return "redirect:/";
		}
		int numberOfPage = (int) Math.ceil((double) totalPro / Defines.ROW_COUNT_PUBLIC);
		if (currentPage > numberOfPage) {
			currentPage = numberOfPage;
		}
		int offset = (currentPage - 1) * Defines.ROW_COUNT_PUBLIC;
		List<Product> listSearch = bookDao.getItemsBySearchPaginationPublic(search, offset, Defines.ROW_COUNT_PUBLIC);
		modelMap.addAttribute("search", search);
		modelMap.addAttribute("currentPage", currentPage);
		modelMap.addAttribute("numberOfPage", numberOfPage);
		modelMap.addAttribute("listSearch", listSearch);
		return "bookstore.public.index.search";
	}

	@GetMapping("{cname}/{cid}/{name}/{bid}.html")
	public String productDetail(ModelMap modelMap, @PathVariable(name = "bid", required = false) Integer bid,
			@PathVariable(name = "cid", required = false) Integer cid, RedirectAttributes ra) {
		Product objPro = bookDao.getItemByBidPublic(bid);
		Category objCat = catDao.getItemByCid(cid);
		if (objCat != null) {
			Category objCatParent = catDao.getItemByCid(objCat.getParent_id());
			modelMap.addAttribute("objCatParent", objCatParent);
			modelMap.addAttribute("objCat", objCat);
		} else {
			return "error/404";
		}
		if (objPro == null) {
			return "error/404";
		} else {
			if (bookDao.countView(objPro.getBid()) > 0) {
				objPro.setCount_view(objPro.getCount_view() + 1);
			} else {
				return "error/404";
			}
			int totalCmt = cmtDao.totalCmtByBidPublic(bid);
			List<Comment> listComment = cmtDao.getItemsByBidPublic(bid);
			List<Product> listProLQ = bookDao.getItemPublicByCidLQ(objPro.getBid(), objPro.getCid(), 0, 8);
			modelMap.addAttribute("objPro", objPro);
			modelMap.addAttribute("listProLQ", listProLQ);
			modelMap.addAttribute("listComment", listComment);
			modelMap.addAttribute("totalCmt", totalCmt);
			return "bookstore.public.index.productDetail";
		}
	}

	@GetMapping("registed.html")
	public String contact() {
		return "bookstore.public.index.contact";
	}

	@PostMapping("registed.html")
	public String contact(@Valid @ModelAttribute("objUser") User objUser, BindingResult br, RedirectAttributes ra) {
		if (br.hasErrors()) {
			return "bookstore.public.index.contact";
		}

		if (userDao.getItemByUsername1(objUser.getUsername()) != null) {
			ra.addFlashAttribute("msg", Defines.MSG_USERNAME);
			return "bookstore.public.index.contact";
		} else {
			objUser.setPassword(encode.encode(objUser.getPassword()));
			objUser.setEnable(1);
			objUser.setRole_id(3);

			if (userDao.addItem(objUser) > 0) {
				return "redirect:/login.html";
			} else {
				ra.addFlashAttribute("msg", Defines.MSG_ERROR);
				return "bookstore.public.index.contact";
			}
		}
	}

	@GetMapping("login.html")
	public String login() {
		return "bookstore.public.index.login";
	}

	@PostMapping("login.html")
	public String login(@RequestParam("password") String password, @RequestParam("username") String username,
			HttpSession session, RedirectAttributes ra) {
		String newPassword = encode.encode(password);
		String pass = newPassword.substring(0, password.length());
		User objUser = userDao.checkLogin(username, pass);
		if (objUser != null) {
			session.setAttribute("user", objUser);
			return "redirect:/";
		} else {
			ra.addFlashAttribute("msg", Defines.MSG_LOGIN);
			return "bookstore.public.index.login";
		}
	}

	@GetMapping("logout.html")
	public String logout(HttpSession session, RedirectAttributes ra) {
		if (session.getAttribute("user") == null) {
			return "redirect:/login.html";
		} else {
			session.removeAttribute("user");
			return "redirect:/";
		}
	}

	@GetMapping("cart.html")
	public String cart() {
		return "bookstore.public.index.cart";
	}

	@GetMapping("check.html")
	public String check(HttpSession session, ModelMap modelMap) {
		if (session.getAttribute("user") == null) {
			return "redirect:/login.html";
		}
		if (session.getAttribute("listCart") == null) {
			return "redirect:/";
		}
		@SuppressWarnings("unchecked")
		List<Item> listCart = (ArrayList<Item>) session.getAttribute("listCart");
		float total = ActionCart.total(listCart);
		modelMap.addAttribute("total", total);
		modelMap.addAttribute("listCart", listCart);
		return "bookstore.public.index.check";
	}

	@GetMapping("favorite.html")
	public String favorite() {
		return "bookstore.public.index.favorite";
	}

	@GetMapping("blog.html")
	public String blog() {
		return "bookstore.public.index.blog";
	}
}
