package vn.edu.vinaenter.model.dao;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import vn.edu.vinaenter.model.bean.User;

@Repository
public class UserDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;

	private static final String FIND_ONE_BY_USERNAME = "SELECT u.*, r.name FROM users AS u INNER JOIN roles AS r ON r.role_id = u.role_id WHERE username = ? AND enable = 1";
	private static final String FIND_ONE_BY_USERNAME1 = "SELECT u.*, r.name FROM users AS u INNER JOIN roles AS r ON r.role_id = u.role_id WHERE username = ?";
	private static final String TOTAL_USER = "SELECT COUNT(*) FROM users";
	private static final String FIND_ALL = "SELECT u.*, r.name FROM users AS u INNER JOIN roles AS r ON r.role_id = u.role_id ORDER BY id DESC LIMIT ?,?";
	private static final String FIND_ONE_BY_ID = "SELECT u.*, r.name FROM users AS u INNER JOIN roles AS r ON r.role_id = u.role_id WHERE u.id = ?";
	private static final String FIND_ALL_BY_SEARCH = "SELECT u.*, r.name FROM users AS u INNER JOIN roles AS r ON r.role_id = u.role_id WHERE username LIKE ?";
	private static final String EDIT_USER = "UPDATE users SET fullname = ?, password = ?, email = ?, address = ?, phone = ?, enable = ?, role_id = ? WHERE id = ?";
	private static final String ADD_USER = "INSERT INTO users(username, password, fullname, email, address, phone, enable, role_id) VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String DELETE_USER = "DELETE FROM users WHERE id = ?";
	private static final String FIND_ALL_BY_SEARCH_PAGINATION = "SELECT u.*, r.name FROM users AS u INNER JOIN roles AS r ON r.role_id = u.role_id WHERE username LIKE ? LIMIT ?, ?";
	private static final String TOTAL_USER_BY_SEARCH = "SELECT COUNT(*) FROM users WHERE username LIKE ?";
	private static final String UPDATE_ACTIVE = "UPDATE users SET enable = ? WHERE id = ?";
	private static final String LOGIN = "SELECT u.*, r.name FROM users AS u INNER JOIN roles AS r ON r.role_id = u.role_id WHERE username = ? AND password LIKE ? AND enable = 1";

	public User checkLogin(String username, String pass) {
		try {
			return jdbcTemplate.queryForObject(LOGIN, new Object[] { username, pass + "%" },
					new BeanPropertyRowMapper<User>(User.class));
		} catch (Exception e) {
			return null;
		}
	}

	public int updateActive(Integer id, int i) {
		return jdbcTemplate.update(UPDATE_ACTIVE, new Object[] { i, id });
	}

	public int addItem(@Valid User objUser) {
		return jdbcTemplate.update(ADD_USER,
				new Object[] { objUser.getUsername(), objUser.getPassword(), objUser.getFullname(), objUser.getEmail(),
						objUser.getAddress(), objUser.getPhone(), objUser.getEnable(), objUser.getRole_id() });
	}

	public List<User> getItemBySearch(String search, int offset, int rowCount) {
		return jdbcTemplate.query(FIND_ALL_BY_SEARCH_PAGINATION, new Object[] { "%" + search + "%", offset, rowCount },
				new BeanPropertyRowMapper<User>(User.class));
	}

	public int totalUserBySearch(String search) {
		return jdbcTemplate.queryForObject(TOTAL_USER_BY_SEARCH, new Object[] { search }, Integer.class);
	}

	public int delete(Integer id) {
		return jdbcTemplate.update(DELETE_USER, new Object[] { id });
	}

	public User getItemByUsername1(String username) {
		try {
			return jdbcTemplate.queryForObject(FIND_ONE_BY_USERNAME1, new Object[] { username },
					new BeanPropertyRowMapper<User>(User.class));
		} catch (Exception e) {
			return null;
		}
	}

	public User getItemByUsername(String username) {
		try {
			return jdbcTemplate.queryForObject(FIND_ONE_BY_USERNAME, new Object[] { username },
					new BeanPropertyRowMapper<User>(User.class));
		} catch (Exception e) {
			return null;
		}
	}

	public int totalUser() {
		return jdbcTemplate.queryForObject(TOTAL_USER, Integer.class);
	}

	public List<User> getItems(int offset, int rowCount) {
		return jdbcTemplate.query(FIND_ALL, new Object[] { offset, rowCount },
				new BeanPropertyRowMapper<User>(User.class));
	}

	public User getItemById(Integer id) {
		try {
			return jdbcTemplate.queryForObject(FIND_ONE_BY_ID, new Object[] { id },
					new BeanPropertyRowMapper<User>(User.class));
		} catch (Exception e) {
			return null;
		}
	}

	public List<User> getItemBySearch(String search) {
		return jdbcTemplate.query(FIND_ALL_BY_SEARCH, new Object[] { "%" + search + "%" },
				new BeanPropertyRowMapper<User>(User.class));
	}

	public int editItem(User objUser) {
		return jdbcTemplate.update(EDIT_USER,
				new Object[] { objUser.getFullname(), objUser.getPassword(), objUser.getEmail(), objUser.getAddress(),
						objUser.getPhone(), objUser.getEnable(), objUser.getRole_id(), objUser.getId() });
	}

}
