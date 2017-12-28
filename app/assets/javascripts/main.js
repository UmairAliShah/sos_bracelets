$(document).ready(function(){
  setTimeout(function(){
    $("#notice_wrapper").slideToggle('slow', function(){
      $(this).remove();
    });
  }, 6000);

  /* *********************** Loading data in Deatil window of Post ********************************/
  $(document).on("click", '#editContact', function() {
    $('#showid').val($(this).attr('data-id'));
    $('#showname').val($(this).attr('data-name'));
    $('#showcountry').val($(this).attr('data-country'));
    $('#shownumber').val($(this).attr('data-number'));
    $('#showrelation').val($(this).attr('data-relation'));
    $('#showemail').val($(this).attr('data-email'));
  });


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


function add_my_contact(profile_id){
  var name = $("#name").val();
  if(name == null || name == ""){
    $("#name_error").show('slow');
    return;
  }
  $("#name_error").hide('slow');

  var country = $("#country").val();
  if(country == null || country == ""){
    $("#country_error").show('slow');
    return;
  }
  $("#country_error").hide('slow');

  var number = $("#number").val();
  if(number == null || number == ""){
    $("#number_error").show('slow');
    return;
  }
  $("#number_error").hide('slow');

  var relation = $("#relation").val();
  if(relation == null || relation == ""){
    relation = "";
  }
  var email = $("#email").val();
  if(email == null || email == ""){
    email = "";
  }
  $("#add_contact").prop('disabled', true);
  $("#loading_add_contact").show();


  $.ajax({
           url: "/contacts", // Route to the Script Controller method
          type: "post",
      dataType: "json",
          data: {profile_id: profile_id, name: name, country: country, number: number, relation: relation, email: email}, // This goes to Controller in params hash, i.e. params[:file_name]
      complete: function() {},
       success: function(data, textStatus, xhr) {
                 $("#add_contact").prop('disabled', false);
                 $("#loading_add_contact").hide();
                  if (data == "-1"){
                    $("#incorrect_number_error").show('slow');
                  }
                  else if (data == "1") {
                    location.reload();
                  }
                  else{
                    $("#contact_error").show('slow');
                  }
                },
         error: function() {
                   $("#add_contact").prop('disabled', false);
                   $("#loading_add_contact").hide();
                    $("#contact_error").show('slow');
                }
  });

}

function update_my_contact(profile_id){
  var cid = $("#showid").val();
  var name = $("#showname").val();
  if(name == null || name == ""){
    $("#upname_error").show('slow');
    return;
  }
  $("#upname_error").hide('slow');

  var country = $("#showcountry").val();
  if(country == null || country == ""){
    $("#upcountry_error").show('slow');
    return;
  }
  $("#upcountry_error").hide('slow');

  var number = $("#shownumber").val();
  if(number == null || number == ""){
    $("#upnumber_error").show('slow');
    return;
  }
  $("#upnumber_error").hide('slow');

  var relation = $("#showrelation").val();
  if(relation == null || relation == ""){
    relation = "";
  }
  var email = $("#showemail").val();
  if(email == null || email == ""){
    email = "";
  }
  $("#update_contact").prop('disabled', true);
  $("#loading_update_contact").show();
  $.ajax({
           url: "/contacts/update", // Route to the Script Controller method
          type: "patch",
      dataType: "json",
          data: {profile_id: profile_id, cid: cid, name: name, country: country, number: number, relation: relation, email: email}, // This goes to Controller in params hash, i.e. params[:file_name]
      complete: function() {},
       success: function(data, textStatus, xhr) {
                 $("#update_contact").prop('disabled', false);
                 $("#loading_update_contact").hide();
                  if (data == "-1"){
                    $("#upincorrect_number_error").show('slow');
                  }
                  else if (data == "1") {
                    location.reload();
                  }
                  else{
                    $("#upcontact_error").show('slow');
                  }
                },
         error: function() {
                   $("#update_contact").prop('disabled', false);
                   $("#loading_update_contact").hide();
                   $("#upcontact_error").show('slow');
                }
  });
}
