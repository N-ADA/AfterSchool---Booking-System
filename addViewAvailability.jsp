<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Add Availability</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="addViewAvailabilityStyle.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="vendor/bootstrap/bootstrap.min.css">
        <link rel="shortcut icon" href="pictures/logo.png">
        <style>
            
            .AvBox{
                font-family: monospace;
                width: 40%;
                height: 31.5%;
                border-radius: 8px;
                padding-left: 15px;
                margin: 20px;
                padding-top: 20px;
                position: absolute;
                top: 32.5%;
                margin-left: 50%;
                background-color: whitesmoke;
                opacity: 0.9;
                border: solid gray 3px;
                overflow-y: scroll;
            }
        </style>
    </head>
    <body>

      <div class="center_name"><i>After School</i></div>
      
        <div id="addingAv" class="section">
          <div class="section-center">
            <div class="container">
              <div class="adding-form">
                <div class="form-header">
                  <h1 style="text-shadow: 5px 5px 20px black;"> Add Availability</h1>
                </div>
                <form>
                    <div class="date">
                      <div class="date-group form-group">
                        <input class="date-control form-control" id="avDate" type="date" required>
                      </div>
                    </div>
                    <div class="time">
                      <div class="time-group form-group">
                          <label style="color: white"><b>Start Time:</b></label>
                        <input class="start-time-control form-control" id="avStTime" label="Start Time" type="time" name="appt-time" required>
                      </div>
                    </div>
                    <div class="time">
                      <div class="time-group form-group">
                          <label style="color: white"><b>End Time:</b></label>
                          <input class="end-time-control form-control" id="avEndTime" type="time" name="appt-time" required>
                      </div>
                    </div>   
                    <div class="form-btn">
                      <button class="btn" id="addBtn" disabled>Add Availability</button>
                    </div>
                </form>
              </div>
            </div>
          </div>
            <form class="AvBox">
                <h2 style="color:black;">Availabilities</h2>
                <ul id="list">
                </ul>
            </form>
        </div>
    </body>
    <script type="text/javascript" src="addViewAvailability.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.js"></script>
    <script>
        const urlParams = new URLSearchParams(window.location.search);
        let tutorId = urlParams.get('tutorId');
        $(document).ready(function () {
            let data = {
                operation: "displayAv",
                id: tutorId
            };
            $.ajax({
                url: "AddAvailabilityServlet",
                method: "GET",
                data: data,
                success: function (data, textStatus, jqXHR) {
                    let obj = $.parseJSON(data);
                    $.each(obj, function (key, value) {
                        console.log(value);
                        $('#list').append('<li>' + value.av_date + ' From: ' + value.av_start_time + ' To: ' + value.av_end_time + '</li>');
                    });
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    $('#list').append('<h3>Oups You Have No Availabilities</h3>');
                },
                cache: false
            });
        });
    </script>
    <script>
        document.getElementById('addBtn').addEventListener('click', function(){
            
            const urlParams = new URLSearchParams(window.location.search);
            let tutorId = urlParams.get('tutorId');
            let date = document.getElementById("avDate").value;
            let stTime = document.getElementById("avStTime").value;
            let endTime = document.getElementById("avEndTime").value;
            
            let data = {
                    operation: "addAv",
                    id: tutorId,
                    st: stTime,
                    et: endTime,
                    d: date
                };
                console.log(data);
                $.ajax({
                    url: "AddAvailabilityServlet",
                    method: "GET",
                    data: data,
                    cache: false
                });
            setTimeout(function() {
               document.location.reload(true);
            }, 2000);
            
        });
        
        
    </script>
</html>
