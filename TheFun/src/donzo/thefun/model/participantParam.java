package donzo.thefun.model;

public class participantParam extends pageParam {

	private int projectseq_participant;
	private String fundtype;
	
	public String getFundtype() {
		return fundtype;
	}

	public void setFundtype(String fundtype) {
		this.fundtype = fundtype;
	}
	
	public int getProjectseq_participant() {
		return projectseq_participant;
	}

	public void setProjectseq_participant(int projectseq_participant) {
		this.projectseq_participant = projectseq_participant;
	}

	@Override
	public int getRecordCountPerPage() {
		return super.getRecordCountPerPage();
	}

	@Override
	public void setRecordCountPerPage(int recordCountPerPage) {
		super.setRecordCountPerPage(recordCountPerPage);
	}

	@Override
	public int getPageNumber() {
		return super.getPageNumber();
	}

	@Override
	public void setPageNumber(int pageNumber) {
		super.setPageNumber(pageNumber);
	}

	@Override
	public int getStart() {
		return super.getStart();
	}

	@Override
	public void setStart(int start) {
		super.setStart(start);
	}

	@Override
	public int getEnd() {
		return super.getEnd();
	}

	@Override
	public void setEnd(int end) {
		super.setEnd(end);
	}

	@Override
	public String getStatus() {
		return super.getStatus();
	}

	@Override
	public void setStatus(String status) {
		super.setStatus(status);
	}

	@Override
	public String toString() {
		return "participantParam [projectseq_participant=" + projectseq_participant + ", "
				+ (fundtype != null ? "fundtype=" + fundtype : "") + "]";
	}


	

}
