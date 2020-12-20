package vn.edu.vinaenter.model.dao;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.Statement;

import vn.edu.vinaenter.model.bean.Bill;
import vn.edu.vinaenter.model.bean.User;

@Repository
public class BillDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;

	private static final String INSSERT_BILL = "INSERT INTO bills(user_id, status, total) VALUES (?,?,?)";
	private static final String FIND_ALL_BY_PAGINATION = "SELECT b.bill_id, b.user_id, b.status, b.date_create, b.total, u.username FROM bills AS b INNER JOIN users AS u ON b.user_id = u.id ORDER BY b.bill_id DESC LIMIT ?,?";
	private static final String TOTAL_BILL = "SELECT COUNT(*) FROM bills";
	private static final String FIND_ALL_BY_SEARCH_PAGINATION = "SELECT b.bill_id, b.user_id, b.status, b.date_create, b.total, u.username FROM bills AS b INNER JOIN users AS u ON b.user_id = u.id WHERE u.username LIKE ? ORDER BY b.bill_id DESC LIMIT ?,?";
	private static final String TOTAL_BILL_BY_SEARCH = "SELECT COUNT(*) FROM bills AS b INNER JOIN users AS u ON b.user_id = u.id WHERE u.username LIKE ?";
	private static final String FIND_ONE_BY_BILL_ID = "SELECT b.bill_id, b.user_id, b.status, b.date_create, b.total, u.username FROM bills AS b INNER JOIN users AS u ON b.user_id = u.id WHERE b.bill_id = ?";
	private static final String TOTAL_INCOME = "SELECT SUM(total) FROM bills";
	
	public float totalIncome() {
		return jdbcTemplate.queryForObject(TOTAL_INCOME, Integer.class);
	}
	
	public Bill getItemByBillId(Integer billId) {
		try {
			return jdbcTemplate.queryForObject(FIND_ONE_BY_BILL_ID, new Object[] { billId },
					new BeanPropertyRowMapper<Bill>(Bill.class));
		} catch (Exception e) {
			return null;
		}
	}

	public int totalBillBySearch(String search) {
		return jdbcTemplate.queryForObject(TOTAL_BILL_BY_SEARCH, new Object[] { "%" + search + "%" }, Integer.class);
	}

	public List<Bill> getItemsBySearchPagnation(String search, int offset, int rowCount) {
		return jdbcTemplate.query(FIND_ALL_BY_SEARCH_PAGINATION, new Object[] { "%" + search + "%", offset, rowCount },
				new BeanPropertyRowMapper<Bill>(Bill.class));
	}

	public int totalBill() {
		return jdbcTemplate.queryForObject(TOTAL_BILL, Integer.class);
	}

	public List<Bill> getItemsByPagination(int offset, int rowCount) {
		return jdbcTemplate.query(FIND_ALL_BY_PAGINATION, new Object[] { offset, rowCount },
				new BeanPropertyRowMapper<Bill>(Bill.class));
	}

	public int addItemPublic(User infUser, float total) {
		PreparedStatementCreator psc = new PreparedStatementCreator() {
			@Override
			public java.sql.PreparedStatement createPreparedStatement(java.sql.Connection connection)
					throws SQLException {
				PreparedStatement ps = (PreparedStatement) connection.prepareStatement(INSSERT_BILL,
						Statement.RETURN_GENERATED_KEYS);
				ps.setInt(1, infUser.getId());
				ps.setInt(2, 1);
				ps.setFloat(3, total);

				return ps;
			}
		};
		KeyHolder keyHolder = new GeneratedKeyHolder();
		jdbcTemplate.update(psc, keyHolder);

		return keyHolder.getKey().intValue();
	}
}
