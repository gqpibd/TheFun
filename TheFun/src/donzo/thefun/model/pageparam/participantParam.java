package donzo.thefun.model.pageparam;

public class participantParam extends pageParam {

	private int projectseq;
	
	public participantParam() {
		super(10,10);
	}

	public int getProjectseq() {
		return projectseq;
	}

	public void setProjectseq(int projectseq) {
		this.projectseq = projectseq;
	}

	@Override
	public String toString() {
		return "participantParam [projectseq=" + projectseq + "]";
	}
}
