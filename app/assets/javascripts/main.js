$(document).ready(function(){
  setTimeout(function(){
    $("#notice_wrapper").slideToggle('slow', function(){
      $(this).remove();
    });
  }, 6000);
  });


  function callme(mydiv){
    $('.leader_div').css('background-color', 'white');
    $(mydiv).css({"background-color":"#7DCEA0"});
  }
