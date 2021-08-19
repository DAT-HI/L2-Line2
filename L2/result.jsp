<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="resultstyle.css">


</head>
<body>

   <% request.setCharacterEncoding("utf-8"); %> 
<div class="container">
        <div class="bar">
            <div class="departure"> <%= request.getParameter("departureStation") %> </div>
                <img src="./img/go.png" class="goto" alt="goto">
            <div class="arrival"> <%= request.getParameter("stopStation") %> </div>
                <a href="index.jsp">
                    <img src="./img/exit.png" class="xicon" alt="닫기">
                </a>
        </div>
        <div class="time">
            <div class="previous"> 
                <img src="./img/left2.png" class="leftarrow" alt="화살표">
            <div class="prestation" alt="전역">
                <div> <%= request.getParameter("beforeStartStation") %> </div>
            </div>
            </div>
            <div class="station">
                <div> <%= request.getParameter("departureStation") %> </div>
            </div>
            <div class="next"> 
            <div class="nextstation" alt="다음역">
            <div> <%= request.getParameter("selectNm4") %> </div>
                </div>
                <img src="./img/right2.png" class="rightarrow" alt="화살표">
            </div>
        </div>
         <div class="subway_direction"><!-- 행(이전역 방향) 정보-->
       <!-- 
           <div class = "subway_name">
                성수(내선)행<br>
                성수(내선)행
            </div>
            <div class = "spacing"></div>
            <div class = "subway_time">
                곧 도착<br>
                2분 34초
            </div>
            --> 
        </div>
        
         
        <div class="subway_direction2"><!-- 행(다음역 방향) 정보-->
        <!-- 
            <div class = "subway_name">
                성수(외선)행<br>
                성수(외선)행
            </div>
            <div class = "spacing"></div>
            <div class = "subway_time">
                곧 도착<br>
                3분 3초
            </div>
             -->
        </div>
        
        <div class="duration">소요시간</div>
        <div class="durationtime"> 17분 </div>

        <div class="selection">
            <select>
                <option selected disabled hidden>출발시간을 선택하세요</option>
            </select>
        </div>
         <div><!-- 출발~도착 -->
		        <div class = "circle">출발</div>
		        	<p class="AlineNM"> 
		        		<%= request.getParameter("departureStation")%>
		        	</p>
		
		        <div class="line">  
		        <!-- 사이역 -->
			        <div class="Line2">
			       		 <p class="lineNM"><%= request.getParameter("selectNm6") %></p>
			        </div>
		        </div>

				<div class = "a">
		        <div class = "circle2">도착</div>
		        		<p class="AlineNM2"> 
		        			<%= request.getParameter("stopStation")%>
	        			</p>
		        </div>
		        
		 </div>
        
    </div>

    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>



    <script>
    $.get({
            url: 'http://swopenapi.seoul.go.kr/api/subway/sample/xml/realtimeStationArrival/1/4/<%= request.getParameter("departureStation") %>',//역 이름 데이터 받아서 get으로 넣는거 php로 만들어서 넣기
            MobileOS: 'ETC',
            MobileApp: 'AppTesting'
        }).done(function(data){
            console.log(data);
    
            var items = $(data).find('row');
            var rs = []; //화면상 오른쪽
            var rs2 = []; //화면상 왼쪽
    
            $.each(items, function(index,value){
                var bstatnNm = $(this).find('bstatnNm').text(); //종착지 //종착지 2개씩 같은 방향. 같은 방향 데이터끼리 div로 분리해서 표현
                var arvlMsg2 = $(this).find('arvlMsg2').text(); //남은 시간
                var rowNum = $(this).find('rowNum').text();
                var updnLine = $(this).find('updnLine').text(); //내,외선 구분
                
                //열차 방향별 2개씩 나눔
                if(rowNum<3){
                rs.push('<div class="subway_name">'+bstatnNm+'&#40;'+updnLine+'&#41;'+'</div><div class="subway_time">'+arvlMsg2+'</div>'); //rs 배열에 삽입 //종착지와 남은시간 사이에 div로 공백 넣어줌
                }else{
                   rs2.push('<div class="subway_name">'+bstatnNm+'&#40;'+updnLine+'&#41;'+'</div><div class="subway_time">'+arvlMsg2+'</div>');
                   }
             });
         
            //$('#abc').html(rs.join(''));
            $('.subway_direction').html(rs.join(''));
            $('.subway_direction2').html(rs2.join(''));
            
        });

        $.get({
                    url: 'http://openapi.seoul.go.kr:8088/6e7363656e6861703637645550626f/xml/SearchSTNTimeTableByIDService/1/1000/<%= request.getParameter("upr_cd") %>/1/1/',
                    MobileOS: 'ETC',
                    MobileApp: 'AppTesting'
                }).done(function(data){
                    console.log(data);
            
                    var items = $(data).find('row');
                    var rs = [];
            
                    $.each(items, function(index,value){
                        var arrive = $(this).find('ARRIVETIME').text();
                        rs.push('<option>'+arrive+'</option>'); //rs 배열에 삽입
                        //console.log(arrive);
                    });

                    $('.selection').html('<select name="upr_arrive" id="upr_arrive">  <option value="출발시간" selected disabled hidden>출발시간을 선택하세요</option> '+rs.join('')+'</select>');
                
                
              
        
                
                });
    </script>
<!--
   출발코드: <%= request.getParameter("upr_cd") %>
   도착코드: <%= request.getParameter("upr_cd1") %>
   출발 <%= request.getParameter("departureStation") %>
   도착 <%= request.getParameter("stopStation") %>
   전역 <%= request.getParameter("beforeStartStation") %>
   다음역 <%= request.getParameter("afterStartSration") %>
  사이역 <%= request.getParameter("selectNm6") %>
 -->
</body>
</html>