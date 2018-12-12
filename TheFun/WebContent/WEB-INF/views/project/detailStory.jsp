<%@page import="donzo.thefun.util.myCal"%>
<%@page import="java.util.ArrayList"%>
<%@page import="donzo.thefun.model.ProjectDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<link rel="stylesheet" href="CSS/project/projectCalendar.css">
 
<style type="text/css">
h1 {
	font-family: "Nanum Gothic", sans-serif;
}
</style>


<%!
public String callist(int year,int month, int day){	
	String s="";
	s+=String.format("<span>", year,month,day);
	if(day < 10)s+="&nbsp;";
	s+=String.format("%d",day); //2자리
	s+="</span>";
	return s;
}

public String two(String msg){
	return msg.trim().length()<2?"0"+msg:msg.trim();
}
%>

<%
List<ProjectDto> list = new ArrayList<ProjectDto>();
Object oflist = request.getAttribute("flist");
if(oflist != null) {
	list = (List<ProjectDto>)oflist;
}
//이렇게 기나긴 과정을 요약 >> ${flist.----}
myCal jcal = (myCal)request.getAttribute("jcal");

int dayOfWeek = jcal.getDayOfWeek();	// 1 ~ 7
int lastDayOfMonth = jcal.getLastDay();

int year = jcal.getYear();
int month = jcal.getMonth();

%>

<p>${projectdto.content }</p> 

	<!-- jzdbox1, jzdasf, jzdcal : 달력 전체 박스 크기 -->
	<!-- jzdcalt : 연 월 폰트 설정 -->
	<!-- jzdb : 달력에 날짜 없는 날 -->
	<!-- circle : 일정 있는날 원으로 표시 해줌 -->
<div class="jzdbox1 jzdbasf jzdcal">
	
	<div class="jzdcalt"><%=String.format("%d년&nbsp;&nbsp;%d월", year, month) %></div>
	
	<span>일</span>
	<span>월</span>
	<span>화</span>
	<span>수</span>
	<span>목</span>
	<span>금</span>
	<span>토</span>
	
	
	<%
	for(int i = 1;i < dayOfWeek; i++){
		out.println("<span class='jzdb'>&nbsp;</span>");
	}

	for(int i = 1;i <= lastDayOfMonth; i++){

		/* 여기서 조건문 */
		//System.out.println("Callist 확인용 : " + callist(year, month, i));
			%>	
			<span><%=callist(year, month, i) %>&nbsp;</span>
			<%
	
	if((i + dayOfWeek - 1) % 7 == 0 && i != lastDayOfMonth){
		
	}
}

for(int i = 0;i < (7 - (dayOfWeek + lastDayOfMonth - 1)%7)%7; i++){
	out.println("<span class='jzdb'>&nbsp;</span>");
}

%>

</div>
<!-- 	
	<span class="jzdb">BLANK</span>
	<span class="jzdb">BLANK</span>
	<span class="jzdb">BLANK</span>
	<span class="jzdb">BLANK</span>
	<span class="jzdb">BLANK</span>
	<span class="jzdb">BLANK</span>
	<span>1</span>
	<span class="circle" data-title="My 25th birthday!">2</span>
	<span>3</span>
	<span>4</span>
	<span>5</span>
	<span>6</span>
	<span>7</span>
	<span>8</span>
	<span>9</span>
	<span>10</span>
	<span>11</span>
	<span class="circle" data-title="2 month anniversary!">12</span>
	<span>13</span>
	<span>14</span>
	<span>15</span>
	<span>16</span>
	<span>17</span>
	<span>18</span>
	<span>19</span>
	<span>20</span>
	<span>21</span>
	<span class="circle" data-title="#MusicMonday - share your favorite song!">22</span>
	<span>23</span>
	<span>24</span>
	<span>25</span>
	<span>26</span>
	<span>27</span>
	<span>28</span>
	<span>29</span>
	<span>30</span>
	<span class="jzdb">BLANK</span>
	<span class="jzdb">BLANK</span>
	<span class="jzdb">BLANK</span>
	<span class="jzdb">BLANK</span>
	<span class="jzdb">BLANK</span>
	<span class="jzdb">BLANK</span>
	
	 -->
