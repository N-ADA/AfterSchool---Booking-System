<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Book A Session</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link type="text/css" rel="stylesheet" href="BookNowStyle.css">
        <link rel="shortcut icon" href="pictures/logo.png">
    </head>
    <body>
        <div id="booking" class="section">
          <div class="section-center">
            <div class="container">
              <div class="booking-form">
                <div class="form-header">
                </div>
                <form>
                  <div class="level-select-box select-box">
                    <select class="selection" id="level" name="level" onchange="dynamicdropdown(1);">
                        <option value="">Select Level...</option>
                        <option>TC</option>
                        <option>1BAC</option>
                        <option>2BAC</option>
                    </select>
                  </div>
                  <div class="course-select-box select-box">
                    <select class="selection" id="course" name="course" onchange="dynamicdropdown(2);" disabled >
                        <option>Select Course...</option>
                    </select>
                  </div>

                  <div class="date">
                    <div class="form-group">
                      <input class="form-control" id="date" type="date"  required onchange="dynamicdropdown(4);">
                    </div>
                  </div>

                  <div class="type-select-box select-box">
                    <select class="selection" id="type" name="type" style=" width: 50%; margin-left: 50%; margin-top: 2px;" disabled onchange="dynamicdropdown(3);">
                        <option>Select Type...</option>
                        <option>Individual Session</option>
                        <option>Group Session</option>
                    </select>
                  </div>

                  <div class="tutor-select-box select-box">
                      <select class="selection" id="tutor" name="tutor" disabled onchange="dynamicdropdown(4);">
                        <option>Select Tutor...</option>
                      </select>
                  </div>

                    <div class="availability-select-box select-box">
                        <select class="selection" id="availability" name="availability" disabled onchange="dynamicdropdown(5);">
                          <option>Select Availability...</option>
                        </select>
                    </div>
                    <div class="form-btn">
                         <button type="button" id="bookBtn" class="btn" disabled> Confirm Booking </button>
                    </div>
                    <div class="message" id="msg" style="display: none;"> Thank you! Your session has been booked successfully. </div>
                </form>
              </div>
            </div>
          </div>
        </div>
    </body>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.js"></script>
    <script type="text/javascript">
    function dynamicdropdown(dropdown){
          if(dropdown === 1){
              document.getElementById("course").disabled=false;
          }else if(dropdown === 2){
              document.getElementById("type").disabled=false;
          }else if(dropdown === 3){
              document.getElementById("tutor").disabled=false;
          }else if(dropdown === 4){
            if(document.getElementById("date").value && document.getElementById("tutor").value !== "Select Tutor..." && document.getElementById("course").value !== "Select Course..." && document.getElementById("type").value !== "Select Type..."){
                document.getElementById("availability").disabled=false;
            }
          }
          else{
              document.getElementById("bookBtn").disabled=false;
          }
      }
      </script>
      <script>
        document.getElementById('bookBtn').addEventListener('click', function(){
            document.getElementById('msg').style.display = 'block'; 
            setTimeout(function() {
               document.getElementById('msg').style.display = 'none'; 
            }, 2000);
            
            let course = document.getElementById("course").value;
            let tutor = document.getElementById("tutor").value;
            let typeVal = document.getElementById("type").value;
            let date = document.getElementById("date").value;
            let time = document.getElementById("availability").value;
            const urlParams = new URLSearchParams(window.location.search);
            let studId = urlParams.get('studId');
            let type = 0;
            if(typeVal === "Individual Session"){
                type = 2;
            }
            else if(typeVal === "Group Session"){
                type = 1;
            }

            let data = {
                operation: "confirm",
                id1: course,
                id2: type,
                id3: tutor,
                id4: date,
                id5: time,
                id6: studId
            };
            console.log(data);
            $.ajax({
                url: "BookNowServlet",
                method: "GET",
                data: data,
                cache: false
            });
            setTimeout(function() {
               document.location.reload(true);
            }, 2000);
            
        });
      </script>
      <script type="text/javascript">
      $(document).ready(function () {
            $('#level').change(function () {
                $('#course').find('option').remove();
                $('#course').append('<option>Select Course...</option>'); 

                let level = $('#level').val();
                console.log(level);
                let data = {
                    operation: "course",
                    id: level
                };
                $.ajax({
                    url: "BookNowServlet",
                    method: "GET",
                    data: data,
                    success: function (data, textStatus, jqXHR) {
                        let obj = $.parseJSON(data);
                        $.each(obj, function (key, value) {
                            $('#course').append('<option>' + value.courseTitle + '</option>');
                        });
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        $('#course').append('<option>Course Unavailable</option>');
                    },
                    cache: false
                });
            });

            $('#course').change(function () {
                $('#tutor').find('option').remove();
                $('#tutor').append('<option>Select Tutor...</option>'); 

                let course = $('#course').val();
                let data = {
                    operation: "tutor",
                    id: course
                };

                $.ajax({
                    url: "BookNowServlet",
                    method: "GET",
                    data: data,
                    success: function (data, textStatus, jqXHR) {
                        let obj = $.parseJSON(data);
                        $.each(obj, function (key, value) {
                            $('#tutor').append('<option>' + value.tutorFname + " " + value.tutorLname + '</option>');
                        });
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        $('#tutor').append('<option>Tutor Unavailable</option>');
                    },
                    cache: false
                });
            });

            $('#tutor').change(function () {
                $('#availability').find('option').remove();

                $('#availability').append('<option>Select Availability...</option>'); 

                let tutor = $('#tutor').val();
                let typeVal = $('#type').val();
                let date = $('#date').val();
                let type = 0;
                if(typeVal === "Individual Session"){
                    type = 2;
                }
                else if(typeVal === "Group Session"){
                    type = 1;
                }

                let data = {
                    operation: "availability",
                    id1: tutor,
                    id2: type,
                    id3: date
                };
                
                console.log(data);

                $.ajax({
                    url: "BookNowServlet",
                    method: "GET",
                    data: data,
                    success: function (data, textStatus, jqXHR) {
                        let obj = $.parseJSON(data);
                        $.each(obj, function (key, value) {
                            console.log(value);
                            $('#availability').append('<option> From: ' + 
                                    value.av_start_time + ' To: '
                                    + value.av_end_time + '</option>');
                        });
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        $('#availability').append('<option>No Availabilities</option>');
                    },
                    cache: false
                });
            });
       });
    </script>
</html>