package duynguyen.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import duynguyen.model.dao.ProductDAO;
import duynguyen.model.dao.CommentDAO;
import duynguyen.model.dao.UserDao;

@Controller
public class Active {
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private ProductDAO bookDao;
	
	@Autowired
	private CommentDAO cmtDao;
	
	@PostMapping("/user/active")
	public @ResponseBody String activeUser(@RequestParam("aId") Integer id, @RequestParam("aSrc") String src){
		String status = src.substring(src.lastIndexOf("/") + 1, src.lastIndexOf("."));
		String oldSrc = src.substring(0, src.lastIndexOf("/") + 1);
		if ("active".equals(status)) {
			if (userDao.updateActive(id, 0) > 0) {
				src = oldSrc + "unactive.png";
			}
		} else {
			if (userDao.updateActive(id, 1) > 0) {
				src = oldSrc + "active.png";
			}
		}
		return src;
	}
	
	@PostMapping("/product/active")
	public @ResponseBody String activeBook(@RequestParam("aId") Integer id, @RequestParam("aSrc") String src){
		String status = src.substring(src.lastIndexOf("/") + 1, src.lastIndexOf("."));
		String oldSrc = src.substring(0, src.lastIndexOf("/") + 1);
		if ("active".equals(status)) {
			if (bookDao.updateActive(id, 0) > 0) {
				src = oldSrc + "unactive.png";
			}
		} else {
			if (bookDao.updateActive(id, 1) > 0) {
				src = oldSrc + "active.png";
			}
		}
		return src;
	}
	
	@PostMapping("/comment/active")
	public @ResponseBody String activeComment(@RequestParam("aId") Integer id, @RequestParam("aSrc") String src){
		String status = src.substring(src.lastIndexOf("/") + 1, src.lastIndexOf("."));
		String oldSrc = src.substring(0, src.lastIndexOf("/") + 1);
		if ("active".equals(status)) {
			if (cmtDao.updateActive(id, 0) > 0) {
				src = oldSrc + "unactive.png";
			}
		} else {
			if (cmtDao.updateActive(id, 1) > 0) {
				src = oldSrc + "active.png";
			}
		}
		return src;
	}
	
}
