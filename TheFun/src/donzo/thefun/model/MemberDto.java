package donzo.thefun.model;

import java.io.Serializable;

public class MemberDto implements Serializable {

	String id;
	String pwd;
	String nickname;
	String phone;
	String email;
	String address;
	String info;
	int point;
	int auth;
	
	public MemberDto() {}

	public MemberDto(String id, String pwd, String nickname, String phone, String email, String address, String info,
			int point, int auth) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.nickname = nickname;
		this.phone = phone;
		this.email = email;
		this.address = address;
		this.info = info;
		this.point = point;
		this.auth = auth;
	}

	public MemberDto(String id, String pwd, String nickname, String phone, String email, String address, String info) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.nickname = nickname;
		this.phone = phone;
		this.email = email;
		this.address = address;
		this.info = info;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public int getAuth() {
		return auth;
	}

	public void setAuth(int auth) {
		this.auth = auth;
	}

	@Override
	public String toString() {
		return "MemberDto [id=" + id + ", pwd=" + pwd + ", nickname=" + nickname + ", phone=" + phone + ", email="
				+ email + ", address=" + address + ", info=" + info + ", point=" + point + ", auth=" + auth + "]";
	}
}
