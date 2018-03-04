<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/hchartsjs/jquery-1.8.3.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/hchartsjs/highcharts.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/hchartsjs/exporting.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/hchartsjs/highcharts-zh_CN.js"></script>
</head>

<body>
	<div id="container" style="min-width: 400px; height: 400px"></div>

</body>

<script type="text/javascript">
	Highcharts.setOptions({
		global : {
			useUTC : false
		}
	});

	function activeLastPointToolip(chart) {
		var points = chart.series[0].points;
		chart.tooltip.refresh(points[points.length - 1]);
	}

	$('#container').highcharts(
			{
				chart : {
					type : 'spline',
					animation : Highcharts.svg,
					marginRight : 10,
					events : {
						load : function() {

							var series = this.series[0], chart = this;
							setInterval(function() {
								
								$.ajax({
									url:'data',
									type:'post',
									dataType:'json',
									success:function(datas){
									console.log("datas-->"+datas["unmber"]);
										var x = (new Date()).getTime(),
										//y = Math.random();
										y =datas["unmber"];
										series.addPoint([ x, y ], true, true);
										activeLastPointToolip(chart)
									}
								});
							}, 1000);
							
/*
							 //每秒从数据库获取一个数  
                            var series = this.series[0],  
                                chart = this;  
                            //定时器  
                            var iCount = setInterval(function(){  
                                var url = "${pageContext.request.contextPath}/AjaxTimeServlet";  
                                $("#getTime").load(url,function(backData,textStatus,xmlHttpRequest){  
                                    var $temperature = parseFloat(backData.substr(0,4));//对传过来的数据进行类型转换  
                                    var $time = (new Date(Date.parse((backData.substr(5,21)).replace(/-/g,"/")))).getTime();  
                                    //每隔一秒添加进去的数  
                                    var x = $time;  
                                        y = $temperature;  
                                    series.addPoint([x, y], true, true);  
                                    activeLastPointToolip(chart)  
                                });  
                            }, 1000);  
*/
						}
					}
				},
				title : {
					text : '实时数据展示'
				},
				xAxis : {
					type : 'datetime',
					tickPixelInterval : 150,
					
				},
				yAxis : {
					title : {
						text : '人数'
					},
					plotLines : [ {
						value : 0,
						width : 1,
						color : '#808080'
					} ]
				},
				tooltip : {
					formatter : function() {
						return '<b>'
								+ this.series.name
								+ '</b><br/>'
								+ Highcharts.dateFormat('%Y-%m-%d %H:%M:%S',
										this.x) + '<br/>'
								+ Highcharts.numberFormat(this.y, 2);
					}
				},
				legend : {
					enabled : false
				},
				exporting : {
					enabled : false
				},
				series : [ {
					name : '在线游客数量',
					data : (function() {
						
						var data = [],time=(new Date()).getTime();
						for (var i = -19; i <= 0; i += 1) {
							data.push({
								x : time + i * 1000,
								y : Math.random()
							});
						}
						return data;
					}())
				} ]
			}, function(c) {
				activeLastPointToolip(c)
			});
</script>


</html>