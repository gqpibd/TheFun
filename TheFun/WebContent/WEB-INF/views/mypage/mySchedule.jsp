<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<!-- 스케쥴 css -->
<link rel="stylesheet" href="CSS/Calendar/calendar.css">

<header id="cal_header">
  <div class="container text-center">
    <h1 class="head_title">My Scheduler</h1>
    <p>후원 내역</p>
  </div>
</header>

<section class="timeline" id="cal_timeline">
  <div class="container">
    <div class="timeline-item">
      <div class="timeline-img"></div>

      <div class="timeline-content js--fadeInLeft">
        <h2><%-- ${schedule.title } --%></h2>
        <div class="date"><%-- ${schedule.sdate } --%></div>
        <p><%-- ${schedule.summary } --%></p>
        <a class="bnt-more" href="javascript:void(0)">More</a>
      </div>
    </div>

    <div class="timeline-item">

      <div class="timeline-img"></div>

      <div class="timeline-content timeline-card js--fadeInRight">
        <div class="timeline-img-header">
          <h2>Card Title</h2>
        </div>
        <div class="date">25 MAY 2016</div>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.</p>
        <a class="bnt-more" href="javascript:void(0)">More</a>
      </div>

    </div>

    <div class="timeline-item">

      <div class="timeline-img"></div>

      <div class="timeline-content js--fadeInLeft">
        <div class="date">3 JUN 2016</div>
        <h2>Quote</h2>
        <blockquote>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dicta explicabo debitis omnis dolor iste fugit totam quasi inventore!</blockquote>
      </div>
    </div>

    <div class="timeline-item">

      <div class="timeline-img"></div>

      <div class="timeline-content js--fadeInRight">
        <h2>Title</h2>
        <div class="date">22 JUN 2016</div>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.</p>
        <a class="bnt-more" href="javascript:void(0)">More</a>
      </div>
    </div>

    <div class="timeline-item">

      <div class="timeline-img"></div>

      <div class="timeline-content timeline-card js--fadeInLeft">
        <div class="timeline-img-header">
          <h2>Card Title</h2>
        </div>
        <div class="date">10 JULY 2016</div>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.</p>
        <a class="bnt-more" href="javascript:void(0)">More</a>
      </div>
    </div>

    <div class="timeline-item">

      <div class="timeline-img"></div>

      <div class="timeline-content timeline-card js--fadeInRight">
        <div class="timeline-img-header">
          <h2>Card Title</h2>
        </div>
        <div class="date">30 JULY 2016</div>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.</p>
        <a class="bnt-more" href="javascript:void(0)">More</a>
      </div>
    </div>

    <div class="timeline-item">

      <div class="timeline-img"></div>

      <div class="timeline-content js--fadeInLeft">
        <div class="date">5 AUG 2016</div>
        <h2>Quote</h2>
        <blockquote>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dicta explicabo debitis omnis dolor iste fugit totam quasi inventore!</blockquote>
      </div>
    </div>

    <div class="timeline-item">

      <div class="timeline-img"></div>

      <div class="timeline-content timeline-card js--fadeInRight">
        <div class="timeline-img-header">
          <h2>Card Title</h2>
        </div>
        <div class="date">19 AUG 2016</div>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.</p>
        <a class="bnt-more" href="javascript:void(0)">More</a>
      </div>
    </div>

    <div class="timeline-item">

      <div class="timeline-img"></div>

      <div class="timeline-content js--fadeInLeft">
        <div class="date">1 SEP 2016</div>
        <h2>Title</h2>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.</p>
        <a class="bnt-more" href="javascript:void(0)">More</a>
      </div>
    </div>

  </div>
</section>

<script>
$(function(){

	  window.sr = ScrollReveal();

	  if ($(window).width() < 768) {
	  	if ($('.timeline-content').hasClass('js--fadeInLeft')) {
	  		$('.timeline-content').removeClass('js--fadeInLeft').addClass('js--fadeInRight');
	  	}
	  	sr.reveal('.js--fadeInRight', {
		    origin: 'right',
		    distance: '300px',
		    easing: 'ease-in-out',
		    duration: 800,
		  });
	  } else {	  	
	  	sr.reveal('.js--fadeInLeft', {
		    origin: 'left',
		    distance: '300px',
			  easing: 'ease-in-out',
		    duration: 800,
		  });

		  sr.reveal('.js--fadeInRight', {
		    origin: 'right',
		    distance: '300px',
		    easing: 'ease-in-out',
		    duration: 800,
		  });
	  }
	  
	  sr.reveal('.js--fadeInLeft', {
		    origin: 'left',
		    distance: '300px',
			  easing: 'ease-in-out',
		    duration: 800,
		  });

		  sr.reveal('.js--fadeInRight', {
		    origin: 'right',
		    distance: '300px',
		    easing: 'ease-in-out',
		    duration: 800,
		  });
	});
</script>