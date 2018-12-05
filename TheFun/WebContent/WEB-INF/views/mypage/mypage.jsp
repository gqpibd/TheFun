<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- myPage css -->
<link rel="stylesheet" href="CSS/mainCss/myPage.css">

<style type="text/css">
a.mpa {
   text-decoration: none;
   color: inherit;
} 

/* Layout */
.s-layout {
   display: flex;
   width: 100%;
   min-height: 100vh;
}

.s-layout__content {
   /* display: flex; */
   justify-content: center;
   align-items: center;
   flex: 1;
}

/* Sidebar */
.s-sidebar__trigger {
   z-index: 2;
   position: fixed;
   top: 0;
   left: 0;
   width: 100%;
   height: 4em;
   background: #3d2484;
}

.s-sidebar__trigger > i {
   display: inline-block;
   margin: 1.5em 0 0 1.5em;
   color: #f07ab0;
}

.s-sidebar__nav {
   position: fixed;
   top: 0;
   left: -15em;
   overflow: hidden;
   transition: all .3s ease-in;
   width: 15em;
   height: 100%;
   /* background: #3d2484; */
   background: #e5e0f7;
   color: #311388;
   z-index: 1;
   
}

.s-sidebar__nav:hover,
.s-sidebar__nav:focus,
.s-sidebar__trigger:focus + .s-sidebar__nav,
.s-sidebar__trigger:hover + .s-sidebar__nav {
   left: 0;
}

.s-sidebar__nav ul {
   position: absolute;
   top: 4em;
   left: 0;
   margin: 0;
   padding: 0;
   width: 15em;
}

.s-sidebar__nav ul li {
   width: 100%;
}

.s-sidebar__nav-link {
   position: relative;
   display: inline-block;
   width: 100%;
   height: 4em;
}

.s-sidebar__nav-link em {
   position: absolute;
   top: 50%;
   left: 4em;
   transform: translateY(-50%);
   font-style: normal;
}

.s-sidebar__nav-link:hover {
   background: #8e6af5;
   color: rgba(232,232,232);
}

.s-sidebar__nav-link > i {
   position: absolute;
   top: 0;
   left: 0;
   display: inline-block;
   width: 4em;
   height: 4em;
}

.s-sidebar__nav-link > i::before {
   position: absolute;
   top: 50%;
   left: 50%;
   transform: translate(-50%, -50%);
}

/* Mobile First */
@media (min-width: 42em) {
   .s-layout__content {
      margin-left: 4em;
   }
   
   /* Sidebar */
   .s-sidebar__trigger {
      width: 4em;
   }
   
   .s-sidebar__nav {
      width: 4em;
      left: 0;
   }
   
   .s-sidebar__nav:hover,
   .s-sidebar__nav:focus,
   .s-sidebar__trigger:hover + .s-sidebar__nav,
   .s-sidebar__trigger:focus + .s-sidebar__nav {
      width: 15em;
   }
}

@media (min-width: 68em) {
   .s-layout__content {
      margin-left: 15em;
   }
   
   /* Sidebar */
   .s-sidebar__trigger {
      display: none
   }
   
   .s-sidebar__nav {
      width: 15em;
   }
   
   .s-sidebar__nav ul {
      top: 1.3em;
   }
}

/* 프로필 사진 */
.profile_img_side{   
    float: none;
    width: 45px;
    height: 45px;
    border-radius: 100%;
    border: 3px solid #c5beda;
    margin: 10px;
    vertical-align: middle;
    object-fit: cover;
}
</style>
 
<div class="s-layout">
<!-- Sidebar -->
<div class="s-layout__sidebar">
  <a class="s-sidebar__trigger mpa" href="#0">
     <i class="fa fa-bars"></i>
  </a>

  <nav class="s-sidebar__nav">
     <ul>
        <li>
           <a class="s-sidebar__nav-link mpa" href="myPage.do">
              <i><img class="profile_img_side" src="${login.profile}"></i><em><b>${login.nickname} 님</b></em>
           </a>
        </li>
        <li>
           <a class="s-sidebar__nav-link mpa" href="myInfo.do">
              <i class="fa fa-user"></i><em>내 정보</em>
           </a>
        </li>
        <li>
           <a class="s-sidebar__nav-link mpa" href="myOrderList.do">
             <i class="far fa-credit-card"></i><em>나의 후원 내역</em>
           </a>
        </li>
        <li>
           <a class="s-sidebar__nav-link mpa" href="mySchedule.do">
              <i class="fas fa-calendar"></i></i><em>나의 프로젝트</em>
           </a>
        </li>
     </ul>
  </nav>
</div>

<!-- Content -->
<!-- <main class="s-layout__content">  		
</main>
</div> -->
 