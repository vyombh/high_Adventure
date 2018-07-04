// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
function ChangeHamburgerIcon() {
$("#bar1").toggleClass("bar1change");
$("#bar2").toggleClass("bar2change");
$("#bar3").toggleClass("bar3change");
}

function NavbarTwoAttachOnTop(){
  if(window.pageYOffset >= 227)
  {
    $("#NavbarTwo").addClass("StickNavbarOnTop");
    $("#DestinationHeading").addClass("AfterPadding");
  }
  else{
    $("#NavbarTwo").removeClass("StickNavbarOnTop");
    $("#DestinationHeading").removeClass("AfterPadding");

  }
}
function srch(){
  var x=$("#Calendar");
}
