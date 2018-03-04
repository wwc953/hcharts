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

	$('#container').highcharts( {
				//图表配置
				chart : {
					//图表类型
					type : 'spline',
					animation : Highcharts.svg,
					marginRight : 10,//右边距
					events : {
						load : function() {
							//series[0]第一条数据
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
				//标题
				title : {
					text : '实时数据展示'
				},
				//x轴
				xAxis : {
					//时间轴
					type : 'datetime',
					//刻度间隔px
					tickPixelInterval : 150,
					
				},
				//y轴
				yAxis : {
					title : {
						text : '人数'
					},
					//标示线
					plotLines : [ {
						value : 0,//值
						width : 1,//宽度
						color : '#808080'
					} ]
				},
				//数据提示框
				tooltip : {
					//格式化回调函数
					formatter : function() {
						return '<b>'
								+ this.series.name
								+ '</b><br/>'
								+ Highcharts.dateFormat('%Y-%m-%d %H:%M:%S',
										this.x) + '<br/>'
								+ Highcharts.numberFormat(this.y, 2);
					}
				},
				//版权信息
				credits:{
					enabled:false
				},
				//图例
				legend : {
					enabled : false
				},
				//导出图表
				exporting : {
					enabled : true
				},
				//图表的数据列
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