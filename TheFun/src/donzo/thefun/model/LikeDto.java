package donzo.thefun.model;

public class LikeDto {

	private String id;
	private int projectseq;
	
	public LikeDto() { }	
	
	public LikeDto(String id, int projectseq) {
		super();
		this.id = id;
		this.projectseq = projectseq;
	}


	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public int getProjectseq() {
		return projectseq;
	}
	
	public void setProjectseq(int projectseq) {
		this.projectseq = projectseq;
	}


	@Override
	public String toString() {
		return "LikeDto [id=" + id + ", projectseq=" + projectseq + "]";
	}
}
