package duynguyen.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import duynguyen.model.bean.Item;

@Controller
public class TestPassword {

	@Autowired
	BCryptPasswordEncoder encoder;

	@GetMapping("/test-password")
	public @ResponseBody String index() {
		return encoder.encode("123456");
	}

	@GetMapping("test-json")
	public @ResponseBody List<Item> pro(HttpSession session) {
		@SuppressWarnings("unchecked")
		List<Item> listCart = (ArrayList<Item>) session.getAttribute("listCart");
		return listCart;
	}
}
