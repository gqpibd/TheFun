package donzo.thefun.model.pageparam;

import java.io.Serializable;

public class pageParam implements Serializable{

	//private String status;
	
	private int recordCountPerPage; 	// 한 페이지에 표현할 글 수
	private int pageNumber = 0;			// 페이지 넘버
	
	private int start = 1;
	private int end;
		
	public pageParam() {
		this.recordCountPerPage = 10;
		this.end = 10;
	}

	public  pageParam(int recordCountPerPage, int end) {
		this.recordCountPerPage = recordCountPerPage;
		this.end = end;
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
		return "pageParam [recordCountPerPage=" + recordCountPerPage + ", pageNumber=" + pageNumber + ", start=" + start
				+ ", end=" + end + "]";
	}
	
	/*public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}*/
	
}
