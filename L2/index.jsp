<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="style.css">
<script>

</script>
</head>
<body>

<form action="result.jsp" method="post">
    
    <div class="full">

        <div class="top">
            <div class="top-bar">
                <img class="logo" src="./img/Logo.jpg" alt="logo">
            </div>
            <div> 
                <div class="list">
                   
                    <div id="start"> </div>
                    <div id="stop"> </div>
                   <div id="hidden1"></div><div id="hidden4"></div>
                    <div id="hidden2"></div><div id="hidden3"></div>
                    <div id="hidden5"></div><div id="hidden6"></div>
                    <div id="hidden7"></div>
                    <!--  <input type="hidden" id="selectNm" name="selectNm" value="">  -->
                </div> 
                 
            </div>
            <button type="submit">조회</button> 
            
        </div>

        <div class="Route-map">
            <img class="route-map" src="./img/1.png" alt="노선도">
        </div>
    </div>
    
    
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="assets/bootstrap-4.5.0/js/bootstrap.min.js"></script>
    
    <script>
    $.get({
            url: 'http://openapi.seoul.go.kr:8088/6e7363656e6861703637645550626f/xml/SearchSTNBySubwayLineInfo/1/52/%20/%20/02%ED%98%B8%EC%84%A0',
            MobileOS: 'ETC',
            MobileApp: 'AppTesting'
        }).done(function(data){
            console.log(data);
    
            var items = $(data).find('row');
            var rs = [];
    
            $.each(items, function(index,value){
                var title = $(this).find('STATION_NM').text();
                var CD = $(this).find('STATION_CD').text();
                rs.push('<option value='+CD+'>'+title+'</option>'); //rs 배열에 삽입
            });

         //역 셀렉트 삽입
            $('#start').html('<select name="upr_cd" id="upr_cd">  <option value="출발역" selected disabled hidden>출발역을 선택하세요</option> '+rs.join('')+'</select>');
            $('#stop').html('<select name="upr_cd1" id="upr_cd1"> <option value="도착역" selected disabled hidden>도착역을 선택하세요</option> '+rs.join('')+'</select>');
      
            //시작역 이름
            let cdSelect = document.querySelector('#upr_cd');
            let selectEvent = function(){
            	
                let text1 = cdSelect.options[cdSelect.selectedIndex].text;
                let text2 = cdSelect.options[cdSelect.selectedIndex-1].text;
               let text3 = cdSelect.options[cdSelect.selectedIndex+1].text;
                $('#hidden1').html('<input type="hidden" id="departureStation" name="departureStation" value='+text1+'>');
                $('#hidden2').html('<input type="hidden" id="beforeStartStation" name="beforeStartStation" value='+text2+'>');
                $('#hidden3').html('<input type="hidden" id="selectNm4" name="selectNm4" value='+text3+'>');

                console.log(text2);
                console.log(text1);
                console.log(text3);
            }
            cdSelect.addEventListener("change", selectEvent);

		  //도착역 이름
		    let cdSelect1 = document.querySelector('#upr_cd1');
		    let selectEvent1 = function(){
		    	
			        let text4 = cdSelect1.options[cdSelect1.selectedIndex].text;
			        let text5 = cdSelect1.options[cdSelect1.selectedIndex].value -
			        cdSelect.options[cdSelect.selectedIndex+1].value;
			        
			        var text55 = parseInt(text5); 
			        
			      //사이역 넣을 배열
			        	rss=[];
			        let text6 = cdSelect1.options[cdSelect1.selectedIndex-text5].text;
			        	
			        	//rss 배열에 사이역 넣기 
			        for(var i=1; i<parseInt(text5);i++){
		        		rss.push(cdSelect1.options[cdSelect1.selectedIndex-text5+i].text);
		        		//$('#tl7').html('<input type="hidden" id="selectNm'+(6+i)+'" name="selectNm'+(6+i)+'" value='+rss[i]+'>');
			        }//for
			        
			        $('#hidden7').html('<input type="hidden" id="selectNm6" name="selectNm6" value='+rss.join('')+'>');
		            $('#hidden4').html('<input type="hidden" id="stopStation" name="stopStation" value='+text4+'>');
	              	$('#hidden5').html('<input type="hidden" id="afterStartSration" name="afterStartSration" value='+text5+'>');

		        	console.log(rss);
		    }
		    cdSelect1.addEventListener("change", selectEvent1);
        });

    </script>
   </form>
</body>
</html>