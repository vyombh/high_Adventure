
// $(document).ready(function(){

//   $(function() {
//   	$('input[name="daterange"]').daterangepicker({
//   	opens: 'left'
//    });
//   });
//   var RoomNo = document.getElementById("Rooms").value;
//   var AdultNo = document.getElementById("Adults").value;
//   var ChildrenNo = document.getElementById("Children").value;
//   var button = document.getElementById("myBtn");

//   button.innerHTML ="Rooms:" + RoomNo +"  Adults:" + AdultNo +" Children:" + ChildrenNo;

//   function changevalue(){
//   	var RoomNo = document.getElementById("Rooms").value;
//   	var AdultNo = document.getElementById("Adults").value;
//   	var ChildrenNo = document.getElementById("Children").value;
//   button.innerHTML ="Rooms:" + RoomNo +"  Adults:" + AdultNo +" Children:" + ChildrenNo;
//   }

//   Rooms.oninput = function(){
//   	changevalue();
//   }

//   Adults.oninput = function(){
//   	changevalue();
//   }

//   Children.oninput = function(){
//   	changevalue();
//   }

//   var acc = document.getElementsByClassName("accordion");
//   var i;

//   for (i = 0; i < acc.length; i++) {
//     acc[i].addEventListener("click", function() {
//       this.classList.toggle("active");
//       var panel = this.nextElementSibling;
//       if (panel.style.maxHeight){
//         panel.style.maxHeight = null;
//       } else {
//         panel.style.maxHeight = panel.scrollHeight + "px";
//       }
//     });
//   }

// });
$(document).ready(function(){
  $('#BasicAmenties').slideUp(1);
  $('#MediaAmenties').slideUp(1);
  $('#FoodAmenties').slideUp(1);
  $('#DisabilityAmenties').slideUp(1);
  $('#EntertainmentAmenties').slideUp(1);

  var basicamenities=1;
  var mediaamenities=1;
  var foodamenities=1;
  var disabilityamenities=1;
  var entertainmentamenities=1;

  function basicAmenities(){
    if(basicamenities==1)
    {
      $('#BasicAmenties').slideDown(250);
      $('#PlusSignA').removeClass('RotatePlusB');
      $('#PlusSignA').addClass('RotatePlusA');
    }
    else
    {
      $('#BasicAmenties').slideUp(250);
      $('#PlusSignA').removeClass('RotatePlusA');
      $('#PlusSignA').addClass('RotatePlusB');
    }
    basicamenities=(basicamenities)*(-1);
  }

  function MediaAmenities(){
    if(mediaamenities==1)
    {
      $('#MediaAmenties').slideDown(250);
      $('#PlusSignB').removeClass('RotatePlusB');
      $('#PlusSignB').addClass('RotatePlusA');
    }
    else
    {
      $('#MediaAmenties').slideUp(250);
      $('#PlusSignB').removeClass('RotatePlusA');
      $('#PlusSignB').addClass('RotatePlusB');
    }
    mediaamenities=(mediaamenities)*(-1);
  }

  function FoodAmenities(){
    if(foodamenities==1)
    {
      $('#FoodAmenties').slideDown(250);
      $('#PlusSignC').removeClass('RotatePlusB');
      $('#PlusSignC').addClass('RotatePlusA');
    }
    else
    {
      $('#FoodAmenties').slideUp(250);
      $('#PlusSignC').removeClass('RotatePlusA');
      $('#PlusSignC').addClass('RotatePlusB');
    }
    foodamenities=(foodamenities)*(-1);
  }

  function DisabilityAmenities(){
    if(disabilityamenities==1)
    {
      $('#DisabilityAmenties').slideDown(250);
      $('#PlusSignD').removeClass('RotatePlusB');
      $('#PlusSignD').addClass('RotatePlusA');
    }
    else
    {
      $('#DisabilityAmenties').slideUp(250);
      $('#PlusSignD').removeClass('RotatePlusA');
      $('#PlusSignD').addClass('RotatePlusB');
    }
    disabilityamenities=(disabilityamenities)*(-1);
  }

  function EntertainmentAmenities(){
    if(entertainmentamenities==1)
    {
      $('#EntertainmentAmenties').slideDown(250);
      $('#PlusSignE').removeClass('RotatePlusB');
      $('#PlusSignE').addClass('RotatePlusA');
    }
    else
    {
      $('#EntertainmentAmenties').slideUp(250);
      $('#PlusSignE').removeClass('RotatePlusA');
      $('#PlusSignE').addClass('RotatePlusB');
    }
    entertainmentamenities=(entertainmentamenities)*(-1);
  }
  $('#BasicAmenitiesBtn').click(function(){
    
    mediaamenities=-1;
    foodamenities=-1;
    disabilityamenities=-1;
    entertainmentamenities=-1;

    basicAmenities();
    MediaAmenities();
    FoodAmenities();
    DisabilityAmenities();
    EntertainmentAmenities();
  });

  $('#MediaAmenitiesBtn').click(function(){

    basicamenities=-1;
    foodamenities=-1;
    disabilityamenities=-1;
    entertainmentamenities=-1;

    basicAmenities();
    MediaAmenities();
    FoodAmenities();
    DisabilityAmenities();
    EntertainmentAmenities();
  });

  $('#FoodAmenitiesBtn').click(function(){

    basicamenities=-1;
    mediaamenities=-1;
    disabilityamenities=-1;
    entertainmentamenities=-1;

    basicAmenities();
    MediaAmenities();
    FoodAmenities();
    DisabilityAmenities();
    EntertainmentAmenities();
  });

  $('#DisabilityAmentiesBtn').click(function(){

    basicamenities=-1;
    mediaamenities=-1;
    foodamenities=-1;
    entertainmentamenities=-1;

    basicAmenities();
    MediaAmenities();
    FoodAmenities();
    DisabilityAmenities();
    EntertainmentAmenities();
  });


  $('#EntertainmentAmentiesBtn').click(function(){

    basicamenities=-1;
    mediaamenities=-1;
    foodamenities=-1;
    disabilityamenities=-1;

    basicAmenities();
    MediaAmenities();
    FoodAmenities();
    DisabilityAmenities();
    EntertainmentAmenities();
  });
});