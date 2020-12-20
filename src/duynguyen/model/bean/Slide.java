package duynguyen.model.bean;

import javax.validation.constraints.NotEmpty;

public class Slide {
	private int id;

	@NotEmpty(message = "Not empty, please!")
	private String slide;

	private int sort;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getSlide() {
		return slide;
	}

	public void setSlide(String slide) {
		this.slide = slide;
	}

	public int getSort() {
		return sort;
	}

	public void setSort(int sort) {
		this.sort = sort;
	}

	public Slide() {
		super();
	}

	public Slide(int id, @NotEmpty(message = "Vui lòng không để trống") String slide, int sort) {
		super();
		this.id = id;
		this.slide = slide;
		this.sort = sort;
	}

}
