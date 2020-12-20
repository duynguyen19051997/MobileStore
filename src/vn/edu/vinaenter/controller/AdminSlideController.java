package vn.edu.vinaenter.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import vn.edu.vinaenter.constant.Defines;
import vn.edu.vinaenter.model.bean.Slide;
import vn.edu.vinaenter.model.bean.User;
import vn.edu.vinaenter.model.dao.SlideDao;
import vn.edu.vinaenter.model.dao.UserDao;
import vn.edu.vinaenter.util.FileUtil;

@Controller
@RequestMapping("admin/slide")
public class AdminSlideController {

	@Autowired
	private ServletContext context;

	@Autowired
	private SlideDao slideDao;

	@Autowired
	private UserDao userDao;

	@ModelAttribute
	public void common(ModelMap modelMap, Principal principal) {
		User inforUser = userDao.getItemByUsername(principal.getName());
		modelMap.addAttribute("inforUser", inforUser);
	}

	@GetMapping({ "index", "index/{page}" })
	public String index(ModelMap modelMap, @PathVariable(name = "page", required = false) Integer currentPage,
			RedirectAttributes ra) {
		try {
			if (currentPage == null || currentPage < 1) {
				ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
				return "redirect:/admin/slide/index/1";
			}
		} catch (NumberFormatException e) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
			return "redirect:/admin/slide/index/1";
		}
		int totalSlide = slideDao.totalSlide();
		int numberOfPage = (int) Math.ceil((double) totalSlide / Defines.ROW_COUNT);
		if (currentPage > numberOfPage) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_PAGE);
			return "redirect:/admin/slide/index/" + numberOfPage;
		}
		int offset = (currentPage - 1) * Defines.ROW_COUNT;
		List<Slide> listSlide = slideDao.getItem(offset, Defines.ROW_COUNT);
		modelMap.addAttribute("currentPage", currentPage);
		modelMap.addAttribute("numberOfPage", numberOfPage);
		modelMap.addAttribute("listSlide", listSlide);
		return "bookstore.admin.slide.index";
	}

	@GetMapping("add")
	public String add() {
		return "bookstore.admin.slide.add";
	}

	@PostMapping("add")
	public String add(ModelMap modelMap, @RequestParam(name = "sort", required = false) Integer sort,
			@RequestParam("picture") CommonsMultipartFile cmf, RedirectAttributes ra) {
		String filename = FileUtil.rename(cmf.getOriginalFilename());
		Slide objSlide = new Slide(0, filename, sort);
		if (!"".equals(filename)) {
			String dirPath = context.getRealPath("") + Defines.DIR_UPLOAD;
			File dir = new File(dirPath);
			if (dir.exists()) {
				dir.mkdirs();
			}
			String filePath = dirPath + File.separator + filename;
			try {
				cmf.transferTo(new File(filePath));
			} catch (IllegalStateException | IOException e) {
				ra.addFlashAttribute("msg", Defines.MSG_ERROR);
				return "bookstore.admin.slide.add";
			}
		}
		try {
			if (slideDao.addItem(objSlide) > 0) {
				ra.addFlashAttribute("msg", Defines.MSG_ADD_SUCCESS);
				return "redirect:/admin/slide/index";
			} else {
				ra.addFlashAttribute("msg", Defines.MSG_ERROR);
				return "bookstore.admin.slide.add";
			}
		} catch (Exception e) {
			return "bookstore.admin.slide.add";
		}
	}

	@GetMapping("edit/{id}")
	public String edit(@PathVariable(name = "id", required = false) Integer id, ModelMap modelMap,
			RedirectAttributes ra) {
		Slide objSlide = slideDao.getItemById(id);
		if (objSlide == null) {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_ID);
			return "redirect:/admin/slide/index/1";
		} else {
			modelMap.addAttribute("objSlide", objSlide);
			return "bookstore.admin.slide.edit";
		}
	}

	@PostMapping("edit/{id}")
	public String edit(@PathVariable(name = "id", required = false) Integer id, RedirectAttributes ra,
			@RequestParam("picture") CommonsMultipartFile cmf,
			@RequestParam(name = "sort", required = false) Integer sort) {
		Slide objSlide = slideDao.getItemById(id);
		String filename = FileUtil.rename(cmf.getOriginalFilename());
		if (!"".equals(filename)) {
			String deleteOldFileName = context.getRealPath("") + Defines.DIR_UPLOAD + File.separator
					+ objSlide.getSlide();
			File file = new File(deleteOldFileName);
			file.delete();
			objSlide.setSlide(filename);
			String dirPath = context.getRealPath("") + Defines.DIR_UPLOAD;
			File dir = new File(dirPath);
			if (dir.exists()) {
				dir.mkdirs();
			}
			String filePath = dirPath + File.separator + filename;
			try {
				cmf.transferTo(new File(filePath));
				if (slideDao.editItem(objSlide) > 0) {
					ra.addFlashAttribute("msg", Defines.MSG_UPDATE_SUCCESS);
					return "redirect:/admin/slide/index";
				} else {
					ra.addFlashAttribute("msg", Defines.MSG_ERROR);
					return "bookstore.admin.slide.edit";
				}
			} catch (IllegalStateException | IOException e) {
				ra.addFlashAttribute("msg", Defines.MSG_ERROR);
				return "bookstore.admin.slide.edit";
			}
		} else {
			Slide oldSlide = slideDao.getItemById(id);
			objSlide.setSlide(oldSlide.getSlide());
			objSlide.setSort(sort);
			try {
				if (slideDao.editItem(objSlide) > 0) {
					ra.addFlashAttribute("msg", Defines.MSG_UPDATE_SUCCESS);
					return "redirect:/admin/slide/index";
				} else {
					ra.addFlashAttribute("msg", Defines.MSG_ERROR);
					return "bookstore.admin.slide.edit";
				}
			} catch (Exception e) {
				return "bookstore.admin.slide.edit";
			}
		}
	}

	@GetMapping("delete/{id}")
	public String delete(@PathVariable(name = "id", required = false) Integer id, RedirectAttributes ra) {
		Slide objSlide = slideDao.getItemById(id);
		if (objSlide != null) {
			String filename = objSlide.getSlide();
			if (slideDao.deleteItem(id) > 0) {
				String filePath = context.getRealPath("") + Defines.DIR_UPLOAD + File.separator + filename;
				File file = new File(filePath);
				file.delete();
				ra.addFlashAttribute("msg", Defines.MSG_DELETE_SUCCESS);
				return "redirect:/admin/slide/index";
			} else {
				ra.addFlashAttribute("msg", Defines.MSG_ERROR);
				return "redirect:/admin/slide/index";
			}
		} else {
			ra.addFlashAttribute("msg", Defines.MSG_ERROR_ID);
			return "redirect:/admin/slide/index";
		}
	}
}
