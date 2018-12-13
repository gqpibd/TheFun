package donzo.thefun.model;

import java.io.Serializable;

public class buyParam extends pageParam implements Serializable {

	// --------- orderlist
	private String o_id;				// 프로젝트 작성자 아이디
		
	public buyParam() {
		super(5,5);
	}

	public String getO_id() {
		return o_id;
	}

	public void setO_id(String o_id) {
		this.o_id = o_id;
	}

	@Override
	public String toString() {
		return "buyParam [o_id=" + o_id + "]";
	}

		
		
	
}
