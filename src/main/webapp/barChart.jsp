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
$(function () {
    $('#container').highcharts({
    	//图表类型
        chart: {
            type: 'column'
        },
        //主标题
        title: {
            text: '月平均降雨量'
        },
        //二级标题
        subtitle: {
            text: '数据来源: 网络'
        },
		//版权信息
		credits:{
			enabled:false
		},
        xAxis: {
            categories: [
                '一月',
                '二月',
                '三月',
                '四月',
                '五月',
                '六月',
                '七月',
                '八月',
                '九月',
                '十月',
                '十一月',
                '十二月'
            ],
            //十字准星线
            crosshair: true
        },
        yAxis: {
            min: 0,
            title: {
                text: '降雨量 (mm)'
            }
        },
        tooltip: {
            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
            '<td style="padding:0"><b>{point.y:.1f} mm</b></td></tr>',
            footerFormat: '</table>',
            //提示框是否被共享,多个数据在同一提示框中显示,默认false
            shared: true,
            //HTML渲染
            useHTML: true
        },
        //数据配置
        plotOptions: {
        	//代表柱状图
            column: {
            	//柱状图边框
                borderWidth: 0
            }
        },
        //数据列
        series: [{
            name: '东京',
            data: [49.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4]
        }, {
            name: '纽约',
            data: [83.6, 78.8, 98.5, 93.4, 106.0, 84.5, 105.0, 104.3, 91.2, 83.5, 106.6, 92.3]
        }, {
            name: '伦敦',
            data: [48.9, 38.8, 39.3, 41.4, 47.0, 48.3, 59.0, 59.6, 52.4, 65.2, 59.3, 51.2]
        }, {
            name: '柏林',
            data: [42.4, 33.2, 34.5, 39.7, 52.6, 75.5, 57.4, 60.4, 47.6, 39.1, 46.8, 51.1]
        }]
    });
});

</script>

</html>