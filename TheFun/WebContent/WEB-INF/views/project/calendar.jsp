<%@page import="java.util.Calendar"%>
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
	s+=String.format("", year,month,day);
	if(day < 10)s+="&nbsp;";
	s+=String.format("%d",day); //2자리
	s+="";
	return s;
}

public String two(String msg){
	return msg.trim().length()<2?"0"+msg:msg.trim();
}

public String Dday(int year, int month, int day, List<ProjectDto> mylist){
	Calendar cal = Calendar.getInstance();
	 
	//현재 년도, 월, 일
	int toyear = cal.get ( cal.YEAR );
	int tomonth = cal.get ( cal.MONTH ) + 1 ;
	int todate = cal.get ( cal.DATE ) ;
	
    String today =(toyear + "-") + two(tomonth + "-") + two(todate + "");
    //System.out.println("현재날짜 : "+ today);
    
	String s="";
	String dates=(year + "-") + two(month + "-") + two(day + "");//년월일 8글자 만드는거
	
	//System.out.println("dates 확인 : " + dates);
	
	
	if(mylist != null){
		for(ProjectDto lcd:mylist){	
			//System.out.println("내가찾아온놈들 : "+ mylist);
			if(lcd.getSdate().substring(0,10).equals(dates)){
				s="sday";
			}
			else if(lcd.getEdate().substring(0,10).equals(dates)){
				s="eday";			
			}
			else if(lcd.getPdate().substring(0,10).equals(dates)){
				s="pday";			
			}
			else if(lcd.getShipdate() != null && !lcd.getShipdate().equals("")) {
				if( lcd.getShipdate().substring(0,10).equals(dates)){
					s="shipday";
					//System.out.println("배송일 출력 확인" + lcd.getShipdate().substring(0,10));
				}
			}else {
				s="";
			}
				/* if(today.equals(dates)){
					s="today";
				} */
		}
	}
	
	return s;
}
%>

<%
List<ProjectDto> list = new ArrayList<ProjectDto>();
Object oflist = request.getAttribute("flist");
if(oflist != null) {
	list = (List<ProjectDto>)oflist;
}

myCal jcal = (myCal)request.getAttribute("jcal");

int dayOfWeek = jcal.getDayOfWeek();	// 1 ~ 7
int lastDayOfMonth = jcal.getLastDay();

int year = jcal.getYear();
int month = jcal.getMonth();

%>

<div align="center" style="font-weight: bold; font-size: 18px;">프로젝트 진행 일정을 확인해 보세요</div>
<div class="jzdbox1 jzdbasf jzdcal" style="background: #a78af2 !important;">
	
	<div class="jzdcalt"><%=String.format("%d년&nbsp;&nbsp;%d월", year, month) %></div>
	
	<span>일</span>
	<span>월</span>
	<span>화</span>
	<span>수</span>
	<span>목</span>
	<span>금</span>
	<span>토</span>
	<!-- jzdbox1, jzdasf, jzdcal : 달력 전체 박스 크기 -->
	<!-- jzdcalt : 연 월 폰트 설정 -->
	<!-- jzdb : 달력에 날짜 없는 날 -->
	<!-- circle : 일정 있는날 원으로 표시 해줌 -->
	
<%
	for(int i = 1;i < dayOfWeek; i++){
		out.println("<span class='jzdb'>&nbsp;</span>");
	}
	for(int i = 1;i <= lastDayOfMonth; i++){
		/* 여기서 조건문 */
		//System.out.println("Callist 확인용 : " + callist(year, month, i));
		/* if(Dday(year, month, i, list).equals("today")){ */
		%>
		<%-- <span class="circle_today" data-title="현재"><%=callist(year,month,i) %></span> --%>
		<%
		/* }
		else */ 
		if(Dday(year, month, i, list).equals("sday")){
		%>
		<span class="circle" data-title="프로젝트 시작"><%=callist(year,month,i) %></span>
		<%			
		} else if(Dday(year, month, i, list).equals("eday")){
			%>
			<span class="circle" data-title="프로젝트 끝"><%=callist(year,month,i) %></span>
			<%
		} else if(Dday(year, month, i, list).equals("pday")){
			%>
			<span class="circle" data-title="결제일"><%=callist(year,month,i) %></span>
			<%
		} else if(Dday(year, month, i, list) != null && !Dday(year, month, i, list).equals("") 
					&& Dday(year, month, i, list).equals("shipday")){
			%>			
			<span class="circle" data-title="배송일"><%=callist(year,month,i) %></span>			
			<%
		} else {
			%>
			<span><%=callist(year,month,i) %></span>
			<%
		}
		
		
		if((i + dayOfWeek - 1) % 7 == 0 && i != lastDayOfMonth){
			
		}
		
	}
	
	for(int i = 0;i < (7 - (dayOfWeek + lastDayOfMonth - 1)%7)%7; i++){
		out.println("<span class='jzdb'>&nbsp;</span>");
}

%>

</div>