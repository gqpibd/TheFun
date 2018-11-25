package donzo.thefun.model;

import java.io.Serializable;
/*-- 멤버 테이블

DROP TABLE FUN_MEMBER
CASCADE CONSTRAINTS; -- S추가
 
CREATE TABLE FUN_MEMBER(
   ID VARCHAR2(50) PRIMARY KEY,
   PWD VARCHAR2(50),
   NICKNAME VARCHAR2(50) NOT NULL,
   PHONE VARCHAR2(50),
   EMAIL VARCHAR2(50),
   PROFILE VARCHAR2(100),
   INFO VARCHAR2(2000), -- 소개글 (NOT NULL 삭제)
   POINT NUMBER(15),
   AUTH NUMBER(1) NOT NULL -- 1: 일반회원 3: 관리자
   POSTCODE VARCHAR2(10),
   ROADADDRESS VARCHAR2(100),
   DETAILADDRESS VARCHAR2(100)
);*/
public class MemberDto implements Serializable {

	public static final int MEMBER = 1;
	public static final int MANAGER = 3;
	
	public static final String DEFAULTIMGPATH = "image/profile/default.jpg";
	
	String id;
	String pwd;
	String nickname;
	String phone;
	String email;
	String profile;
	String info; // 소개글
	int point;
	int auth; // 1: 일반회원 3: 관리자
	String postcode; // 우편번호
	String roadaddress; // 도로명 주소
	String detailaddress; // 상세 주소
	
	
	public MemberDto() {
		point = 0;
		nickname = "";
		phone = "";
		info = "";
		email = "";
		postcode = "";
		roadaddress = "";
		detailaddress = "";
		auth = MEMBER;
		profile = DEFAULTIMGPATH;
	}

	public MemberDto(String id, String pwd, String nickname, String phone, String email, String profile, String info,
			int point, int auth, String postcode, String roadaddress, String detailaddress) {
		this.id = id;
		this.pwd = pwd;
		this.nickname = nickname;
		this.phone = phone;
		this.email = email;
		this.profile = profile;
		this.info = info;
		this.point = point;
		this.auth = auth;
		this.postcode = postcode;
		this.roadaddress = roadaddress;
		this.detailaddress = detailaddress;
	}
	
	public MemberDto(String id, String pwd, String nickname, String phone, String email, String profile, String info) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.nickname = nickname;
		this.phone = phone;
		this.email = email;
		this.profile = profile;
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

	public String getprofile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
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
	
	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getRoadaddress() {
		return roadaddress;
	}

	public void setRoadaddress(String roadaddress) {
		this.roadaddress = roadaddress;
	}

	public String getDetailaddress() {
		return detailaddress;
	}

	public void setDetailaddress(String detailaddress) {
		this.detailaddress = detailaddress;
	}

	public boolean isManager() {
		if(auth == MANAGER) return true;
		else return false;
	}
	
	public String getFullAddress() {
		return postcode + " " + roadaddress + " " + detailaddress;
	}

	@Override
	public String toString() {
		return "MemberDto [id=" + id + ", pwd=" + pwd + ", nickname=" + nickname + ", phone=" + phone + ", email="
				+ email + ", profile=" + profile + ", info=" + info + ", point=" + point + ", auth=" + auth
				+ ", postcode=" + postcode + ", roadaddress=" + roadaddress + ", detailaddress=" + detailaddress + "]";
	}
}
