<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<style type="text/css">
.header {
  background-color: #8152f0;
  color: white;
  font-size: 1.5em;
  padding: 0.3rem;
  text-align: center;
}

.table_img {
  border-radius: 50%;
  height: 60px;
  width: 60px;
  background: white;
}

.table-users {
  border: 1px solid #8152f0;
  border-radius: 10px;
  box-shadow: 3px 3px 0 rgba(0, 0, 0, 0.1);
  max-width: calc(100% - 2em);
  margin: 1em auto;
  overflow: hidden;
  width: 800px;   
  margin-top: 8%;
  /* margin-bottom: 10%; */
}

.mhtable {
  width: 100%;
}

.mhtable td, table th {
  color: #000;
  padding: 10px;
  text-align: center;
}

.mhtable td {
  text-align: center;
  vertical-align: middle;
}

.mhtable td:last-child {
  font-size: 0.95em;
  line-height: 1.4;
  text-align: left;
}

.mhtable th {
  background-color: #8152f0;
  font-weight: 300;
  color: #fff;
}
.mhtable tr:nth-child(2n) {
  background-color: white;
}
.mhtable tr:nth-child(2n+1) {
  background-color: #edf7f8;
}

@media screen and (max-width: 1000px) {  
  .mhtable, .mhtr, .mhtd {
    display: block;
  }

  .mhtd:first-child {
    position: absolute;
    top: 50%;
    -webkit-transform: translateY(-50%);
            transform: translateY(-50%);
    /* width: 100px; */
  }
  .mhtd:not(:first-child) {
    clear: both;
    margin-left: 100px;
    padding: 4px 20px 4px 90px;	
    position: relative;
    text-align: left;
  }
  .mhtd:not(:first-child):before {
    color: #8152f0;
    content: '';
    display: block;
    left: 0;
    position: absolute;
  }
  .mhtd:nth-child(2):before {
    content: 'Name:';
  }
  .mhtd:nth-child(3):before {
    content: 'Point:';
  }
  .mhtd:nth-child(4):before {
    content: 'Comments:';
  }
  
  .mhtr {
    padding: 20px 0;
    position: relative;
  }
  .mhtr:first-child {
    display: none;
  }
}

@media screen and (max-width: 375px) {
  .header {
    background-color: transparent;
    color: #8152f0;
    font-size: 2em;
    font-weight: 700;
    padding: 0;
    text-shadow: 2px 2px 0 rgba(0, 0, 0, 0.1);
  }
 
 
  table_img {
    border: 3px solid;
    border-color: #daeff1;
    height: 100px;
    margin: 0.5rem 0;
    width: 100px;
  }

  .mhtd:first-child {
    background-color: #8152f0;
    border-bottom: 1px solid #91ced4;
    border-radius: 10px 10px 0 0;
    position: relative;
    top: 0;
    -webkit-transform: translateY(0);
            transform: translateY(0);
    width: 100%;
  }
  .mhtd:not(:first-child) {
    margin: 0;
    padding: 5px 1em;
    width: 100%;
  }
  .mhtd:not(:first-child):before {
    font-size: .8em;
    padding-top: 0.3em;
    position: relative;
  }
  .mhtd:last-child {
    padding-bottom: 1rem !important;
  }

  .mhtr {
    background-color: white !important;
    border: 1px solid #8152f0;
    border-radius: 10px;
    box-shadow: 2px 2px 0 rgba(0, 0, 0, 0.1);
    margin: 0.5rem 0;
    padding: 0;
    
  }

  .table-users {
    border: none;
    box-shadow: none;
    overflow: visible;
  }
  
  .user_tbody{
  	display: block;
  }
}

</style>


<div class="table-users">
	<div class="header">MyPage</div>
	<table class="mhtable" border="0px">
	  <tbody class="user_tbody">
	  <tr class="mhtr" >
	        <th class="mhtd">Picture</th>
	        <th class="mhtd">Name</th>
	        <th class="mhtd">Point</th>
         	<th class="mhtd" width="230">Comments</th>
      </tr>
     
      <tr class="mhtr">
         <td class="mhtd"><img class="table_img" alt="프로필" src="${login.profile }"></td>
         <td class="mhtd">${login.nickname }</td>
         <td class="mhtd">${login.point }점</td>
         <td class="mhtd">${login.info }</td>
      </tr>
		</tbody>
	</table>				
</div>


<!-- 본문출력 묶는 태그 -->
	<jsp:include page="../common/footer.jsp"/>
	</main>
	</div> 
<!-- //본문출력 묶는 태그 -->