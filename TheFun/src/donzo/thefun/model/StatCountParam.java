package donzo.thefun.model;

import java.io.Serializable;

public class StatCountParam implements Serializable {

	private String id;
	private String status;
	
	public StatCountParam() {}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "StatCountParam [id=" + id + ", status=" + status + "]";
	}
	
	
}
