<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- <%@taglib  prefix="form" uri="http://www.springframework.org/tags/form" %> --%>
<fmt:requestEncoding value="UTF-8"/>
@import 'https://code.highcharts.com/css/highcharts.css';

<!-- 차트구현 JS파일 -->
<!-- [1] 원형차트 -->
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-more.js"></script>
<script src="https://code.highcharts.com/modules/solid-gauge.js"></script>

<!-- [2] -->
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/data.js"></script>
<script src="https://code.highcharts.com/modules/drilldown.js"></script>


<!-- 상단바 -->
<header class="line_header">
  <div class="container text-center">
    <h1 class="head_title">MY FUNDING CHART</h1>
    <p>내 통계보기</p>
  </div>
</header>


<!-- 콘텐츠를 전부 중간맞춤하기 위한 가장 외부의 div -->
<div style="width: 80%; margin: 0 auto;">

<!-- 통계종료 선택하는 드랍다운 버튼 -->
<div class="dropdown" align="right" style="margin-top: 5em;">
  <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="width: 16%">
    펀딩타입 분포도
  </button>
  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
    <button type="button" id="typeBtn1" class="dropdown-item" style="background-color: gray;">펀딩타입 분포도</button>
    <button type="button" id="typeBtn2" class="dropdown-item" >카테고리 분포도</button>
    <button type="button" id="typeBtn3" class="dropdown-item" >성패율 비교</button>
  </div>
</div>

<script>
$(document).ready(function () {
	$("#container2").hide();
	
	// 통계 종류 버튼 눌렀을때
	$(".dropdown-item").on("click", function () {
		// '종류별 통계'를 선택한 종류이름으로 변경
		var typeName = $(this).html();
		$("#dropdownMenuButton").html(typeName);
		// 선택된 버튼의 배경색만 회색으로 변경
		$(".dropdown-item").css("background-color", "WHITE");
		$(this).css("background-color", "GRAY");
	});
	
	// 펀딩타입 분포도 선택시
	$("#typeBtn1").click(function () {
		$("#container").show();
		$("#container2").hide();
	});
	
	// 카테고리 분포도 선택시
	$("#typeBtn2").click(function () {
		$("#container").hide();
		$("#container2").show();
		//alert("btn2");
		var promise = $.ajax({
			type: "POST",
			url: 'myFundingCategory.do',
			/* success: function(data) {
				console.log("받은 데이터 = " + data);
			},
			error: function () {
				console.log("카테고리 분포도 결과를 DB에서 꺼내오는데 실패했습니다");
			} */
		});
		
		promise.done(successFunction);
		promise.fail(failFunction);
		
		function successFunction(data) {
			if(data != null){
				alert("결과값 " + data);
				// [2]번째 카테고리 막대그래프 보여주기
				Highcharts.chart('container2', {
				    chart: {
				        type: 'column'
				    },
				    title: {
				        text: 'Browser market shares. January, 2018'
				    },
				    subtitle: {
				        text: 'Click the columns to view versions. Source: <a href="http://statcounter.com" target="_blank">statcounter.com</a>'
				    },
				    xAxis: {
				        type: 'category'
				    },
				    yAxis: {
				        title: {
				            text: 'Total percent market share'
				        }

				    },
				    legend: {
				        enabled: false
				    },
				    plotOptions: {
				        series: {
				            borderWidth: 0,
				            dataLabels: {
				                enabled: true,
				                format: '{point.y:.1f}%'
				            }
				        }
				    },

				    tooltip: {
				        headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
				        pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y:.2f}%</b> of total<br/>'
				    },

				    "series": [
				        {
				            "name": "Browsers",
				            "colorByPoint": true,
				            "data": [
				                {
				                    "name": "음식",
				                    "y": data.food,
				                    "drilldown": "Chrome"
				                },
				                {
				                    "name": "동물(리워드)",
				                    "y": data.r_animal,
				                    "drilldown": "Firefox"
				                },
				                {
				                    "name": "IT",
				                    "y": data.it,
				                    "drilldown": "Internet Explorer"
				                },
				                {
				                    "name": "인간",
				                    "y": data.human,
				                    "drilldown": "Safari"
				                },
				                {
				                    "name": "동물(기부)",
				                    "y": data.d_animal,
				                    "drilldown": "Edge"
				                }/* ,
				                {
				                    "name": "Opera",
				                    "y": 1.92,
				                    "drilldown": "Opera"
				                },
				                {
				                    "name": "Other",
				                    "y": 7.62,
				                    "drilldown": null
				                } */
				            ]
				        }
				    ],
				    "drilldown": {
				        "series": [
				            {
				                "name": "Chrome",
				                "id": "Chrome",
				                "data": [
				                    [
				                        "v65.0",
				                        0.1
				                    ],
				                    [
				                        "v64.0",
				                        1.3
				                    ],
				                    [
				                        "v63.0",
				                        53.02
				                    ],
				                    [
				                        "v62.0",
				                        1.4
				                    ],
				                    [
				                        "v61.0",
				                        0.88
				                    ],
				                    [
				                        "v60.0",
				                        0.56
				                    ],
				                    [
				                        "v59.0",
				                        0.45
				                    ],
				                    [
				                        "v58.0",
				                        0.49
				                    ],
				                    [
				                        "v57.0",
				                        0.32
				                    ],
				                    [
				                        "v56.0",
				                        0.29
				                    ],
				                    [
				                        "v55.0",
				                        0.79
				                    ],
				                    [
				                        "v54.0",
				                        0.18
				                    ],
				                    [
				                        "v51.0",
				                        0.13
				                    ],
				                    [
				                        "v49.0",
				                        2.16
				                    ],
				                    [
				                        "v48.0",
				                        0.13
				                    ],
				                    [
				                        "v47.0",
				                        0.11
				                    ],
				                    [
				                        "v43.0",
				                        0.17
				                    ],
				                    [
				                        "v29.0",
				                        0.26
				                    ]
				                ]
				            },
				            {
				                "name": "Firefox",
				                "id": "Firefox",
				                "data": [
				                    [
				                        "v58.0",
				                        1.02
				                    ],
				                    [
				                        "v57.0",
				                        7.36
				                    ],
				                    [
				                        "v56.0",
				                        0.35
				                    ],
				                    [
				                        "v55.0",
				                        0.11
				                    ],
				                    [
				                        "v54.0",
				                        0.1
				                    ],
				                    [
				                        "v52.0",
				                        0.95
				                    ],
				                    [
				                        "v51.0",
				                        0.15
				                    ],
				                    [
				                        "v50.0",
				                        0.1
				                    ],
				                    [
				                        "v48.0",
				                        0.31
				                    ],
				                    [
				                        "v47.0",
				                        0.12
				                    ]
				                ]
				            },
				            {
				                "name": "Internet Explorer",
				                "id": "Internet Explorer",
				                "data": [
				                    [
				                        "v11.0",
				                        6.2
				                    ],
				                    [
				                        "v10.0",
				                        0.29
				                    ],
				                    [
				                        "v9.0",
				                        0.27
				                    ],
				                    [
				                        "v8.0",
				                        0.47
				                    ]
				                ]
				            },
				            {
				                "name": "Safari",
				                "id": "Safari",
				                "data": [
				                    [
				                        "v11.0",
				                        3.39
				                    ],
				                    [
				                        "v10.1",
				                        0.96
				                    ],
				                    [
				                        "v10.0",
				                        0.36
				                    ],
				                    [
				                        "v9.1",
				                        0.54
				                    ],
				                    [
				                        "v9.0",
				                        0.13
				                    ],
				                    [
				                        "v5.1",
				                        0.2
				                    ]
				                ]
				            },
				            {
				                "name": "Edge",
				                "id": "Edge",
				                "data": [
				                    [
				                        "v16",
				                        2.6
				                    ],
				                    [
				                        "v15",
				                        0.92
				                    ],
				                    [
				                        "v14",
				                        0.4
				                    ],
				                    [
				                        "v13",
				                        0.1
				                    ]
				                ]
				            }
				        ]
				    }
				});
			}
		}
	});
});
</script>



<!-- [1] 원형 통계 : 펀딩타입 분포도 -->
<c:choose>
	<c:when test="${!empty myFundtype }">
		<table class="table">
			<colgroup>
				<col width="500"><col width="500">
			</colgroup>
			<tr>
				<td rowspan="3">
					<div id="container"></div>
					<div id="container2" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
				</td>
				<td colspan="2">
					<h4>회원님은 주로 이런 펀딩을 올리셨네요?</h4>
				</td>
			</tr>
			<tr>
				<th style="font-size: 2em">
					리워드
				</th>
				<td style="font-size: 3em; color: #4B088A">
					<strong>${myFundtype.reward.substring(0,2)}%</strong>
				</td>
			</tr>
			<tr>
				<th style="font-size: 2em">
					기부
				</th>
				<td style="font-size: 3em; color: #4B088A">
					<strong>${myFundtype.donation.substring(0,2)}%</strong>
				</td>
			</tr>
		</table>
	</c:when>
	<c:otherwise>
		<div>
			<h1>니가 올린 프로젝트 아무것도 없어 돌아가.</h1>
		</div>
	</c:otherwise>
</c:choose>



</div>
<!-- 가장 외부의 div 끝 -->


<script>

// [2]



// [1] 원형 통계(펀딩타입 분포도) 구현용 함수
function renderIcons() {

    // Move icon
    if (!this.series[0].icon) {
        this.series[0].icon = this.renderer.path(['M', -8, 0, 'L', 8, 0, 'M', 0, -8, 'L', 8, 0, 0, 8])
            .attr({
                'stroke': '#303030',
                'stroke-linecap': 'round',
                'stroke-linejoin': 'round',
                'stroke-width': 2,
                'zIndex': 10
            })
            .add(this.series[2].group);
    }
    this.series[0].icon.translate(
        this.chartWidth / 2 - 10,
        this.plotHeight / 2 - this.series[0].points[0].shapeArgs.innerR -
            (this.series[0].points[0].shapeArgs.r - this.series[0].points[0].shapeArgs.innerR) / 2
    );

    // Exercise icon
    if (!this.series[1].icon) {
        this.series[1].icon = this.renderer.path(
            ['M', -8, 0, 'L', 8, 0, 'M', 0, -8, 'L', 8, 0, 0, 8,
                'M', 8, -8, 'L', 16, 0, 8, 8]
            )
            .attr({
                'stroke': '#ffffff',
                'stroke-linecap': 'round',
                'stroke-linejoin': 'round',
                'stroke-width': 2,
                'zIndex': 10
            })
            .add(this.series[2].group);
    }
    this.series[1].icon.translate(
        this.chartWidth / 2 - 10,
        this.plotHeight / 2 - this.series[1].points[0].shapeArgs.innerR -
            (this.series[1].points[0].shapeArgs.r - this.series[1].points[0].shapeArgs.innerR) / 2
    );

    // Stand icon
    if (!this.series[2].icon) {
        this.series[2].icon = this.renderer.path(['M', 0, 8, 'L', 0, -8, 'M', -8, 0, 'L', 0, -8, 8, 0])
            .attr({
                'stroke': '#303030',
                'stroke-linecap': 'round',
                'stroke-linejoin': 'round',
                'stroke-width': 2,
                'zIndex': 10
            })
            .add(this.series[2].group);
    }

    this.series[2].icon.translate(
        this.chartWidth / 2 - 10,
        this.plotHeight / 2 - this.series[2].points[0].shapeArgs.innerR -
            (this.series[2].points[0].shapeArgs.r - this.series[2].points[0].shapeArgs.innerR) / 2
    );
}

Highcharts.chart('container', {

    chart: {
        type: 'solidgauge',
        height: '110%',
        events: {
            render: renderIcons
        }
    },

    title: {
        text: '${user.nickname} 님 환영합니다!',
        style: {
            fontSize: '24px'
        }
    },

    tooltip: {
        borderWidth: 0,
        backgroundColor: 'none',
        shadow: false,
        style: {
            fontSize: '25px'
        },
        pointFormat: '{series.name}<br><span style="font-size:2em; color: {point.color}; font-weight: bold">{point.y}%</span>',
        positioner: function (labelWidth) {
            return {
                x: (this.chart.chartWidth - labelWidth) / 2,
                y: (this.chart.plotHeight / 2) + 5
            };
        }
    },

    pane: {
        startAngle: 0,
        endAngle: 360,
        background: [{ // Track for Move
            outerRadius: '112%',
            innerRadius: '88%',
            backgroundColor: Highcharts.Color(Highcharts.getOptions().colors[3])
                .setOpacity(0.3)
                .get(),
            borderWidth: 0
        }, { // Track for Exercise
            outerRadius: '87%',
            innerRadius: '63%',
            backgroundColor: Highcharts.Color(Highcharts.getOptions().colors[4])
                .setOpacity(0.3)
                .get(),
            borderWidth: 0
        }]
    },

    yAxis: {
        min: 0,
        max: 100,
        lineWidth: 0,
        tickPositions: []
    },

    plotOptions: {
        solidgauge: {
            dataLabels: {
                enabled: false
            },
            linecap: 'round',
            stickyTracking: false,
            rounded: true
        }
    },

    series: [{
        name: '리워드 펀딩',
        data: [{
            color: Highcharts.getOptions().colors[0],
            radius: '112%',
            innerRadius: '88%',
            y: ${myFundtype.reward.substring(0,2)}
        }]
    }, {
        name: '기부 펀딩',
        data: [{
            color: Highcharts.getOptions().colors[1],
            radius: '87%',
            innerRadius: '63%',
            y: ${myFundtype.donation.substring(0,2)}
        }]
    }, ]
});




</script>


<!-- 본문출력 묶는 태그 -->
	</main>
	</div> 
<!-- //본문출력 묶는 태그 -->