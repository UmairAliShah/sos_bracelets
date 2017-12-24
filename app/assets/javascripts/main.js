$(document).ready(function(){
  setTimeout(function(){
    $("#notice_wrapper").slideToggle('slow', function(){
      $(this).remove();
    });
  }, 6000);
});

function send_invites_friend(count, pid) {

  var list = new Array();
  for(var i = 0; i<count; i++){
    var email = $("#email"+pid+i).val();
    var id = $("#id"+pid+i).text();
    var obj = id + "=" + email;
    list.push(obj);
  }

  $.ajax({
           url: "/invitations/send_invite", // Route to the Script Controller method
          type: "post",
      dataType: "json",
          data: {pidI: pid, listI: list}, // This goes to Controller in params hash, i.e. params[:file_name]
      complete: function() {},
       success: function(data, textStatus, xhr) {
                  if(data == "1"){
                    location.reload();
                  }
                },
         error: function() {
                  alert("Unrecognized Error!\nTry Again Later");
                }
  });
}

function callme(mydiv){
  $('.leader_div').css('background-color', 'white');
  $(mydiv).css({"background-color":"#7DCEA0"});
}
