// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready(function(){

  $(function() {
  	$('input[name="daterange"]').daterangepicker({
  	opens: 'left'
   });
  });
  var RoomNo = document.getElementById("Rooms").value;
  var AdultNo = document.getElementById("Adults").value;
  var ChildrenNo = document.getElementById("Children").value;
  var button = document.getElementById("myBtn");

  button.innerHTML ="Rooms:" + RoomNo +"  Adults:" + AdultNo +" Children:" + ChildrenNo;

  function changevalue(){
  	var RoomNo = document.getElementById("Rooms").value;
  	var AdultNo = document.getElementById("Adults").value;
  	var ChildrenNo = document.getElementById("Children").value;
  button.innerHTML ="Rooms:" + RoomNo +"  Adults:" + AdultNo +" Children:" + ChildrenNo;
  }

  Rooms.oninput = function(){
  	changevalue();
  }

  Adults.oninput = function(){
  	changevalue();
  }

  Children.oninput = function(){
  	changevalue();
  }

  var acc = document.getElementsByClassName("accordion");
  var i;

  for (i = 0; i < acc.length; i++) {
    acc[i].addEventListener("click", function() {
      this.classList.toggle("active");
      var panel = this.nextElementSibling;
      if (panel.style.maxHeight){
        panel.style.maxHeight = null;
      } else {
        panel.style.maxHeight = panel.scrollHeight + "px";
      }
    });
  }

  function myMap() {
    var myCenter = new google.maps.LatLng(51.508742,-0.120850);
    var mapCanvas = document.getElementById("map");
    var mapOptions = {center: myCenter, zoom: 5};
    var map = new google.maps.Map(mapCanvas, mapOptions);
    var marker = new google.maps.Marker({position:myCenter});
    marker.setMap(map);
  }

  myMap();

});
