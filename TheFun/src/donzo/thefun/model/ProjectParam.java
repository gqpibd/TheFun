package donzo.thefun.model;

import java.io.Serializable;

public class ProjectParam implements Serializable {
	
	// --------- search
	private String s_type;		// reward, donation
	private String s_category; 	// food, it, animal, human
	private String s_keyword;	// 검색어
	private String s_summary;	// 요약설명
	private String s_sort;		// 정렬 구분 1순위 정렬은 
	
	// --------- paging
	private int recordCountPerPage = 8; 	// 한 페이지에 표현할 글 수
	private int pageNumber = 0;				// 페이지 넘버
	
	private int start;
	private int end;

	
	public ProjectParam() {	}

	

	public String getS_sort() {
		return s_sort;
	}



	public void setS_sort(String s_sort) {
		this.s_sort = s_sort;
	}



	public String getS_type() {
		return s_type;
	}


	public void setS_type(String s_type) {
		this.s_type = s_type;
	}


	public String getS_category() {
		return s_category;
	}


	public void setS_category(String s_category) {
		this.s_category = s_category;
	}


	public String getS_keyword() {
		return s_keyword;
	}


	public void setS_keyword(String s_keyword) {
		this.s_keyword = s_keyword;
	}


	public String getS_summary() {
		return s_summary;
	}


	public void setS_summary(String s_summary) {
		this.s_summary = s_summary;
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
		return "ProjectParam [" + (s_type != null ? "s_type=" + s_type + ", " : "")
				+ (s_category != null ? "s_category=" + s_category + ", " : "")
				+ (s_keyword != null ? "s_keyword=" + s_keyword + ", " : "")
				+ (s_summary != null ? "s_summary=" + s_summary + ", " : "")
				+ (s_sort != null ? "s_sort=" + s_sort + ", " : "") + "recordCountPerPage=" + recordCountPerPage
				+ ", pageNumber=" + pageNumber + ", start=" + start + ", end=" + end + "]";
	}
	
}
