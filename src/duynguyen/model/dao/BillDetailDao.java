package duynguyen.model.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import duynguyen.model.bean.BillDetail;
import duynguyen.model.bean.Item;

@Repository
public class BillDetailDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;

	private static final String INSERT_BILL_DETAIL = "INSERT INTO bill_detail(bill_id, bid, number, price) VALUES (?,?,?,?)";
	private static final String FIND_ALL_BY_BILL_ID = "SELECT  bd.*, products.bname FROM bill_detail AS bd INNER JOIN bills ON bills.bill_id = bd.bill_id INNER JOIN products ON products.bid = bd.bid WHERE bills.bill_id = ?";

	public int addItemPublic(Item item, int billId) {
		return jdbcTemplate.update(INSERT_BILL_DETAIL, new Object[] { billId, item.getProduct().getBid(),
				item.getQuantity(), item.getProduct().getPrice() * (1 - item.getProduct().getDiscount()) });
	}

	public List<BillDetail> getItemsByBillId(Integer billId) {
		return jdbcTemplate.query(FIND_ALL_BY_BILL_ID, new Object[] { billId },
				new BeanPropertyRowMapper<BillDetail>(BillDetail.class));
	}

}
