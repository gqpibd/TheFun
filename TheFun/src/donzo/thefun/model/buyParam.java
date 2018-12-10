package donzo.thefun.model;

import java.io.Serializable;

public class buyParam implements Serializable {

	// --------- orderlist
	private String o_id;				// 프로젝트 작성자 아이디
		
		
	// --------- paging
	private int recordCountPerPage = 5; 	// 한 페이지에 표현할 글 수
	private int pageNumber = 0;				// 페이지 넘버
	
	private int start = 1;
	private int end = 5;
	
	public buyParam() {}

	public String getO_id() {
		return o_id;
	}

	public void setO_id(String o_id) {
		this.o_id = o_id;
	}

	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}

	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}

	public int getPageNumber() {
		return pageNumber;
	}

	public void setPageNumber(int pageNumber) {
		this.pageNumber = pageNumber;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}

	@Override
	public String toString() {
		return "buyParam [ o_id=" + o_id
				+ ", recordCountPerPage=" + recordCountPerPage + ", pageNumber=" + pageNumber + ", start=" + start
				+ ", end=" + end + "]";
	}
	
		
	
}
