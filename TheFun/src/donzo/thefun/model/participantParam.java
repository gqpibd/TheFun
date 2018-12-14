package donzo.thefun.model;

public class participantParam extends pageParam {

	private int projectseq_participant;
	private String fundtype;
	
	public participantParam() {
		super.setRecordCountPerPage(10);
		super.setPageNumber(0);
		super.setStart(1);
		super.setEnd(10);
	}
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
	public String toString() {
		return "participantParam [projectseq_participant=" + projectseq_participant + ", "
				+ (fundtype != null ? "fundtype=" + fundtype : "") + "]";
	}


	

}
