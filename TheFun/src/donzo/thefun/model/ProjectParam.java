package donzo.thefun.model;

import java.io.Serializable;

public class ProjectParam implements Serializable {
	
	// --------- search
	private String s_type;		// reward, donation
	private String s_category; 	// food, it, animal, human
	private String s_keyword;	// 검색어
	private String s_summary;	// 요약설명
	private String s_sort;		// 정렬 구분 1순위 정렬은
	private String s_asc_desc;	// 오름차순 내림차순
	private String s_complete;	// 성공여부 

	// --------- orderlist
//	private String o_regdate;		// 후원한 날짜
//	private String o_pdate;		// 결제 날짜
//	private int o_projectseq;		// 프로젝트 번호
//	private String o_ptitle;			// 프로젝트 제목
//	private String o_otitle;			// 프로젝트 옵션 제목
//	private int o_price;				// 가격
//	private int o_count;				// 구매 갯수
//	private String o_status;		// 상태
//	private String o_bcomment;	// 후기 작성
//	
//	private String o_id;				// 프로젝트 작성자 아이디
	
	
	// --------- paging
	private int recordCountPerPage = 8; 	// 한 페이지에 표현할 글 수
	private int pageNumber = 0;				// 페이지 넘버
	
	private int start = 1;
	private int end = 8;

	
	public ProjectParam() {	}


	
//	
//	public String getO_regdate() {
//		return o_regdate;
//	}
//
//
//
//
//	public void setO_regdate(String o_regdate) {
//		this.o_regdate = o_regdate;
//	}
//
//
//
//
//	public String getO_pdate() {
//		return o_pdate;
//	}
//
//
//
//
//	public void setO_pdate(String o_pdate) {
//		this.o_pdate = o_pdate;
//	}
//
//
//
//
//	public int getO_projectseq() {
//		return o_projectseq;
//	}
//
//
//
//
//	public void setO_projectseq(int o_projectseq) {
//		this.o_projectseq = o_projectseq;
//	}
//
//
//
//
//	public String getO_ptitle() {
//		return o_ptitle;
//	}
//
//
//
//
//	public void setO_ptitle(String o_ptitle) {
//		this.o_ptitle = o_ptitle;
//	}
//
//
//
//
//	public String getO_otitle() {
//		return o_otitle;
//	}
//
//
//
//
//	public void setO_otitle(String o_otitle) {
//		this.o_otitle = o_otitle;
//	}
//
//
//
//
//	public int getO_price() {
//		return o_price;
//	}
//
//
//
//
//	public void setO_price(int o_price) {
//		this.o_price = o_price;
//	}
//
//
//
//
//	public int getO_count() {
//		return o_count;
//	}
//
//
//
//
//	public void setO_count(int o_count) {
//		this.o_count = o_count;
//	}
//
//
//
//
//	public String getO_status() {
//		return o_status;
//	}
//
//
//
//
//	public void setO_status(String o_status) {
//		this.o_status = o_status;
//	}
//
//
//
//
//	public String getO_bcomment() {
//		return o_bcomment;
//	}
//
//
//
//
//	public void setO_bcomment(String o_bcomment) {
//		this.o_bcomment = o_bcomment;
//	}
//
//
//
//
//	public String getO_id() {
//		return o_id;
//	}
//
//
//
//
//	public void setO_id(String o_id) {
//		this.o_id = o_id;
//	}
//



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


	public String getS_sort() {
		return s_sort;
	}


	public void setS_sort(String s_sort) {
		this.s_sort = s_sort;
	}


	public String getS_asc_desc() {
		return s_asc_desc;
	}


	public void setS_asc_desc(String s_asc_desc) {
		this.s_asc_desc = s_asc_desc;
	}


	public String getS_complete() {
		return s_complete;
	}


	public void setS_complete(String s_complete) {
		this.s_complete = s_complete;
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
				+ (s_sort != null ? "s_sort=" + s_sort + ", " : "")
				+ (s_asc_desc != null ? "s_asc_desc=" + s_asc_desc + ", " : "")
				+ (s_complete != null ? "s_complete=" + s_complete + ", " : "")
				+ "]";
	}

/*
 + ", o_regdate=" + o_regdate + ", o_pdate=" + o_pdate + ", o_projectseq=" + o_projectseq
				+ ", o_ptitle=" + o_ptitle + ", o_otitle=" + o_otitle + ", o_price=" + o_price + ", o_count=" + o_count
				+ ", o_status=" + o_status 
				+ (o_bcomment != null ? "o_bcomment=" + o_bcomment + ", " : "")
				+ ", o_id=" + o_id + ", recordCountPerPage="+ recordCountPerPage 
				+ ", pageNumber=" + pageNumber + ", start=" + start + ", end=" + end 
 */
	

	
}
