package donzo.thefun.model;

import java.io.Serializable;

public class pageParam implements Serializable{

	private String status;
	
	// --------- paging
	private int recordCountPerPage = 8; 	// 한 페이지에 표현할 글 수
	private int pageNumber = 0;				// 페이지 넘버
	
	private int start = 1;
	private int end = 8;
		
	public pageParam() {}

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
	
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "pageParam [" + (status != null ? "status=" + status + ", " : "") + "recordCountPerPage="
				+ recordCountPerPage + ", pageNumber=" + pageNumber + ", start=" + start + ", end=" + end + "]";
	}
	
	
}
