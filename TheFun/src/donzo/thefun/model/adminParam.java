package donzo.thefun.model;

public class adminParam {

	private String status;
	
	private int recordCountPerPage = 10; 	// 한 페이지에 표현할 글 수
	private int pageNumber = 0;				// 페이지 넘버
	
	private int start = 1;
	private int end = 10;
	
	public adminParam() {}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
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
		return "adminParam [status=" + status + ", recordCountPerPage=" + recordCountPerPage + ", pageNumber="
				+ pageNumber + ", start=" + start + ", end=" + end + "]";
	}
	
	
}
