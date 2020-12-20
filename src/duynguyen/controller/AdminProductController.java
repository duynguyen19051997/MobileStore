package duynguyen.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.List;

import javax.servlet.ServletContext;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import duynguyen.constant.Defines;
import duynguyen.model.bean.Product;
import duynguyen.model.bean.Category;
import duynguyen.model.bean.User;
import duynguyen.model.dao.ProductDAO;
import duynguyen.model.dao.CategoryDAO;
import duynguyen.model.dao.UserDao;
import duynguyen.util.FileUtil;

@Controller
@RequestMapping("admin/product")
public class AdminProductController {

	@Autowired
	private ServletContext context;

	@Autowired
	private ProductDAO bookDao;

	@Autowired
	private CategoryDAO catDao;

	@Autowired
	private UserDao userDao;

	@ModelAttribute
	public void commonObject(ModelMap modelMap, Principal principal) {
		User inforUser = userDao.getItemByUsername(principal.getName());
		modelMap.addAttribute("inforUser", inforUser);
		List<Category> listCatChil = catDao.getItemsChil();
		modelMap.addAttribute("listCatChil", listCatChil);
	}

	@GetMapping({ "index/{i}", "index", "{cid}/index/{i}" })
	public String index(ModelMap modelMap, @PathVariable(name = "i", required = false) Integer currentPage,
			@PathVariable(name = "cid", required = false) Integer cid, RedirectAttributes ra) {
		try {
			if (currentPage == null || currentPage < 1) {
				ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
				return "redirect:/admin/product/index/1";
			}
		} catch (NumberFormatException e) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
			return "redirect:/admin/product/index/1";
		}
		if (cid == null) {
			int totalProduct = bookDao.totalProduct();
			if (totalProduct == 0) {
				return "redirect:/admin";
			}
			int numberOfPage = (int) Math.ceil((double) totalProduct / Defines.ROW_COUNT);
			if (currentPage > numberOfPage) {
				ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
				return "redirect:/admin/product/index/" + numberOfPage;
			}
			int offset = (currentPage - 1) * Defines.ROW_COUNT;
			List<Product> listProduct = bookDao.getItems(offset, Defines.ROW_COUNT);
			modelMap.addAttribute("numberOfPage", numberOfPage);
			modelMap.addAttribute("currentPage", currentPage);
			modelMap.addAttribute("listProduct", listProduct);
			return "bookstore.admin.book.index";
		} else {
			Category objCat = catDao.getItemByCid(cid);
			int totalBookByCid = bookDao.totalBookByCid(cid);
			if (totalBookByCid == 0) {
				return "redirect:/admin";
			}
			int numberOfPage = (int) Math.ceil((double) totalBookByCid / Defines.ROW_COUNT);
			if (currentPage > numberOfPage) {
				ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
				return "redirect:/admin/product/" + cid + "/index/" + numberOfPage;
			}
			int offset = (currentPage - 1) * Defines.ROW_COUNT;
			List<Product> listProduct = bookDao.getItemsByCid(cid, offset, Defines.ROW_COUNT);
			modelMap.addAttribute("numberOfPage", numberOfPage);
			modelMap.addAttribute("currentPage", currentPage);
			modelMap.addAttribute("listProduct", listProduct);
			modelMap.addAttribute("objCat", objCat);
			return "bookstore.admin.book.index";
		}

	}

	@GetMapping("add")
	public String add(ModelMap modelMap) {
		return "bookstore.admin.book.add";
	}

	@PostMapping("add")
	public String add(@Valid @ModelAttribute("objPro") Product objPro, BindingResult br,
			@RequestParam("avatar") CommonsMultipartFile cmf, RedirectAttributes ra, Principal principal) {
		if (br.hasErrors()) {
			return "bookstore.admin.book.add";
		}
		String filename = FileUtil.rename(cmf.getOriginalFilename());
		objPro.setPicture(filename);
		objPro.setCreate_by(principal.getName());
		objPro.setEnable(1);
		objPro.setCount_view(0);
		objPro.setDiscount(0);
		if (!"".equals(filename)) {
			String dirPath = context.getRealPath("") + Defines.DIR_UPLOAD;
			File dir = new File(dirPath);
			if (dir.exists()) {
				dir.mkdirs();
			}
			String filePath = dirPath + File.separator + filename;
			try {
				cmf.transferTo(new File(filePath));
				System.out.println(filePath);
			} catch (IllegalStateException | IOException e) {
				ra.addFlashAttribute("msg", Defines.MSG_ERROR);
				return "redirect:/admin/product/add";
			}
		}
		if (bookDao.addItem(objPro) > 0) {
			ra.addFlashAttribute("msg", Defines.MSG_ADD_SUCCESS);
			return "redirect:/admin/product/index/1";
		} else {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR);
			return "redirect:/admin/product/add";
		}
	}

	@GetMapping("edit/{bid}/{page}")
	public String edit(@PathVariable("bid") int bid, ModelMap modelMap,
			@PathVariable(name = "page", required = false) Integer page, RedirectAttributes ra) {
		Product objPro = bookDao.getItemByBid(bid);
		if (objPro == null) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_ID);
			return "redirect:/admin/product/index/1";
		}
		int totalPro = bookDao.totalProduct();
		int numberOfPage = (int) Math.ceil((double) totalPro / Defines.ROW_COUNT);
		try {
			if (page == null || page < 1) {
				ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
				return "redirect:/admin/product/index/1";
			}
		} catch (NumberFormatException e) {
			page = 1;
		}
		if (page > numberOfPage) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
			return "redirect:/admin/product/index/" + numberOfPage;
		}
		List<Category> listCatChil = catDao.getItemsChil();
		modelMap.addAttribute("listCatChil", listCatChil);
		modelMap.addAttribute("objPro", objPro);
		return "bookstore.admin.book.edit";
	}

	@PostMapping("edit/{bid}/{page}")
	public String edit(@PathVariable("bid") int bid, @Valid @ModelAttribute("objPro") Product objPro, BindingResult br,
			@PathVariable(name = "page", required = false) Integer page,
			@RequestParam("avatar") CommonsMultipartFile cmf, RedirectAttributes ra, Principal principal) {
		if (br.hasErrors()) {
			return "bookstore.admin.book.edit";
		}
		Product objOldPro = bookDao.getItemByBid(bid);
		String fileName = FileUtil.rename(cmf.getOriginalFilename());
		objPro.setCreate_by(principal.getName());
		if (!"".equals(fileName)) {
			File file = new File(
					context.getRealPath("") + Defines.DIR_UPLOAD + File.separator + objOldPro.getPicture());
			file.delete();
			objPro.setPicture(fileName);
			String dirPath = context.getRealPath("") + Defines.DIR_UPLOAD;
			File dir = new File(dirPath);
			if (dir.exists()) {
				dir.mkdirs();
			}
			String filePath = dirPath + File.separator + fileName;
			try {
				cmf.transferTo(new File(filePath));
			} catch (IllegalStateException | IOException e) {
				ra.addFlashAttribute("msg", Defines.MSG_ERROR);
				return "redirect:/admin/product/index";
			}
		} else {
			objPro.setPicture(objOldPro.getPicture());
		}
		try {
			if (bookDao.editItem(objPro) > 0) {
				ra.addFlashAttribute("msg", Defines.MSG_UPDATE_SUCCESS);
				return "redirect:/admin/product/index/" + page;
			} else {
				ra.addFlashAttribute("msg", Defines.MSG_ERROR);
				return "bookstore.admin.book.edit";
			}
		} catch (Exception e) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR);
			return "bookstore.admin.book.edit";
		}
	}

	@GetMapping("delete/{bid}/{page}")
	public String delete(@PathVariable(name = "bid", required = false) Integer bid,
			@PathVariable(name = "page", required = false) Integer page, RedirectAttributes ra) {
		Product objPro = bookDao.getItemByBid(bid);
		if (objPro == null) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_ID);
			return "redirect:/admin/product/index/" + page;
		}
		int totalPro = bookDao.totalProduct();
		int numberOfPage = (int) Math.ceil((double) totalPro / Defines.ROW_COUNT);
		if (page == null || page < 1) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
			return "redirect:/admin/product/index/1";
		}
		if (page > numberOfPage) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
			return "redirect:/admin/product/index/" + numberOfPage;
		}
		if (bookDao.deleteItem(bid) > 0) {
			String dirPath = context.getRealPath("") + Defines.DIR_UPLOAD;
			String fileName = objPro.getPicture();
			String filePath = dirPath + File.separator + fileName;
			File file = new File(filePath);
			file.delete();
			ra.addFlashAttribute("msg", Defines.MSG_DELETE_SUCCESS);
			return "redirect:/admin/product/index/" + page;
		} else {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR);
			return "redirect:/admin/product/index/" + page;
		}
	}

	@GetMapping({ "search", "search/{page}" })
	public String search(@RequestParam("search") String search, ModelMap modelMap,
			@PathVariable(name = "page", required = false) Integer currentPage, RedirectAttributes ra) {
		if (currentPage == null || currentPage < 1) {
			currentPage = 1;
		}
		int totalProSearch = bookDao.totalItemsBySearch(search);
		int numberOfPage = (int) Math.ceil((double) totalProSearch / Defines.ROW_COUNT);
		if (currentPage > numberOfPage) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
			return "redirect:/admin/product/search/" + numberOfPage + "?search=" + search;
		}
		int offset = (currentPage - 1) * Defines.ROW_COUNT;
		List<Product> listPro = bookDao.getItemsBySearch(search, offset, Defines.ROW_COUNT);
		modelMap.addAttribute("numberOfPage", numberOfPage);
		modelMap.addAttribute("currentPage", currentPage);
		modelMap.addAttribute("listPro", listPro);
		modelMap.addAttribute("search", search);
		return "bookstore.admin.book.search";
	}

	@GetMapping("detail/{bid}")
	public String detail(@PathVariable("bid") int bid, ModelMap modelMap, RedirectAttributes ra) {
		Product objPro = bookDao.getItemByBid(bid);
		try {
			if (objPro == null) {
				ra.addFlashAttribute("msg", Defines.MSG_ERROR_ID);
				return "redirect:/admin/product/index/1";
			}
		} catch (Exception e) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_ID);
			return "redirect:/admin/product/index/1";
		}
		modelMap.addAttribute("objPro", objPro);
		return "bookstore.admin.book.detail";
	}
}
