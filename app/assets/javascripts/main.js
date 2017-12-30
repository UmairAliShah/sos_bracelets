$(document).ready(function(){

  setTimeout(function(){
    $("#notice_wrapper").slideToggle('slow', function(){
      $(this).remove();
    });
  }, 6000);

  /************************ Loading data in Edit Contact Window ********************************/
  $(document).on("click", '#editContact', function() {
    $('#showid').val($(this).attr('data-id'));
    $('#showname').val($(this).attr('data-name'));
    $('#showcountry').val($(this).attr('data-country'));
    $('#shownumber').val($(this).attr('data-number'));
    $('#showrelation').val($(this).attr('data-relation'));
    $('#showemail').val($(this).attr('data-email'));
  });
  /************************ Loading data in Edit Contact Window ********************************/


  /************************ Loading data in Edit Address Window ********************************/
  $(document).on("click", '#editAddress', function() {
    $('#upaid').val($(this).attr('data-aid'));
    $('#upline1').val($(this).attr('data-line1'));
    $('#upline2').val($(this).attr('data-line2'));
    $('#upcity').val($(this).attr('data-city'));
    $('#upstate').val($(this).attr('data-state'));
    $('#upaddress_country').val($(this).attr('data-acountry'));
  });
  /************************ Loading data in Edit Address Window ********************************/


  /************************ Loading data in Edit Medical Condition Window ********************************/
  $(document).on("click", '#editCondition', function() {
    $('#upid').val($(this).attr('data-id'));
    $('#upcondition').val($(this).attr('data-condition'));
    var n = $(this).attr('data-note');
    if (n == "- - -"){
      $('#upnote').val("");
    }
    else{
      $('#upnote').val(n);
    }
  });
  /************************ Loading data in Edit Medical Condition Window ********************************/


  /************************ Loading data in Edit Allergy Window ********************************/
  $(document).on("click", '#editAllergy', function() {
    $('#up_allergy_id').val($(this).attr('data-alid'));
    $('#up_allergy_name').val($(this).attr('data-alname'));
    var n = $(this).attr('data-alnote');
    if (n == "- - -"){
      $('#up_allergy_note').val("");
    }
    else{
      $('#up_allergy_note').val(n);
    }
  });
  /************************ Loading data in Edit Allergy Window ********************************/


});
/************************ Sending Invites ********************************/
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
/************************ Sending Invites ********************************/



function callme(mydiv){
  $('.leader_div').css('background-color', 'white');
  $(mydiv).css({"background-color":"#7DCEA0"});
}


/************************ Adding new Emergenct Contact of Profile and Leader ********************************/
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
/************************ Adding new Emergenct Contact of Profile and Leader ********************************/



/************************ Updating Emergenct Contact of Profile and Leader ********************************/
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
/************************ Updating Emergenct Contact of Profile and Leader ********************************/



/************************ Adding Medical Condition of Profile and Leader ********************************/
function addMC(id){
  var condition = $("#condition").val();
  if(condition == null || condition == ""){
    $("#condition_error").show('slow');
    return;
  }
  $("#condition_error").hide('slow');

  var notes = $("#note").val();
  if(notes == null || notes == ""){
    notes = "- - -";
  }

  $("#add_medical_condition").prop('disabled', true);
  $("#loading_MC").show();
  $.ajax({
           url: "/medical_conditions", // Route to the Script Controller method
          type: "post",
      dataType: "json",
          data: {id: id, condition: condition, notes: notes}, // This goes to Controller in params hash, i.e. params[:file_name]
      complete: function() {},
       success: function(data, textStatus, xhr) {
                  $("#add_medical_condition").prop('disabled', false);
                  $("#loading_MC").hide();
                  if (data == "-1"){
                    $("#mc_error").show('slow');
                  }
                  else if (data == "1") {
                    location.reload();
                  }
                  else{
                    $("#mc_error").show('slow');
                  }
                },
         error: function() {
                  $("#add_medical_condition").prop('disabled', false);
                  $("#loading_MC").hide();
                  $("#mc_error").show('slow');
                }
  });
}
/************************ Adding Medical Condition of Profile and Leader ********************************/



/************************ Updating Medical Condition of Profile and Leader ********************************/
function update_medical_condition(lpid){
  var cid = $("#upid").val();
  var condition = $("#upcondition").val();
  if(condition == null || condition == ""){
    $("#up_condition_error").show('slow');
    return;
  }
  $("#up_condition_error").hide('slow');

  var notes = $("#upnote").val();
  if(notes == null || notes == ""){
    notes = "- - -";
  }
  $("#updte_medical_condition").prop('disabled', true);
  $("#loading_update_condition").show();

  $.ajax({
           url: "/medical_conditions/update", // Route to the Script Controller method
          type: "patch",
      dataType: "json",
          data: {lpid: lpid, cid: cid, condition: condition, notes: notes}, // This goes to Controller in params hash, i.e. params[:file_name]
      complete: function() {},
       success: function(data, textStatus, xhr) {
                 $("#updte_medical_condition").prop('disabled', false);
                 $("#loading_update_condition").hide();
                  if (data == "-1"){
                    $("#upcondition_error").show('slow');
                  }
                  else if (data == "1") {
                    location.reload();
                  }
                  else{
                    $("#upcondition_error").show('slow');
                  }
                },
         error: function() {
                  $("#updte_medical_condition").prop('disabled', false);
                  $("#loading_update_condition").hide();
                  $("#upcondition_error").show('slow');
                }
  });
}
/************************ Updating Medical Condition of Profile and Leader ********************************/


/************************ Adding Address of Profile and Leader ********************************/
function add_my_address(lpid){
  var line1 = $("#line1").val();
  if(line1 == null || line1 == ""){
    line1 = "";
  }
  var line2 = $("#line2").val();
  if(line2 == null || line2 == ""){
    line2 = "";
  }

  var city = $("#city").val();
  if(city == null || city == ""){
    $("#city_error").show('slow');
    return;
  }
  $("#city_error").hide('slow');


  var state = $("#state").val();
  if(state == null || state == ""){
    $("#state_error").show('slow');
    return;
  }
  $("#state_error").hide('slow');


  var address_country = $("#address_country").val();
  if(address_country == null || address_country == ""){
    $("#address_country_error").show('slow');
    return;
  }
  $("#address_country_error").hide('slow');

  $("#add_address").prop('disabled', true);
  $("#loading_add_address").show();

  $.ajax({
           url: "/addresses", // Route to the Script Controller method
          type: "post",
      dataType: "json",
          data: {lpid: lpid, line1: line1, line2: line2, city: city, state: state, country: address_country}, // This goes to Controller in params hash, i.e. params[:file_name]
      complete: function() {},
       success: function(data, textStatus, xhr) {
                  $("#add_address").prop('disabled', false);
                  $("#loading_add_address").hide();
                  if (data == "-1"){
                    $("#address_error").show('slow');
                  }
                  else if (data == "1") {
                    location.reload();
                  }
                  else{
                    $("#address_error").show('slow');
                  }
                },
         error: function() {
                  $("#add_address").prop('disabled', false);
                  $("#loading_add_address").hide();
                  $("#address_error").show('slow');
                }
  });

}
/************************ Adding Address of Profile and Leader ********************************/


/************************ Updating Address of Profile and Leader ********************************/
function update_my_address(lpid){
  var aid = $("#upaid").val();
  var line1 = $("#upline1").val();
  if(line1 == null || line1 == ""){
    line1 = "";
  }
  var line2 = $("#upline2").val();
  if(line2 == null || line2 == ""){
    line2 = "";
  }

  var city = $("#upcity").val();
  if(city == null || city == ""){
    $("#upcity_error").show('slow');
    return;
  }
  $("#upcity_error").hide('slow');


  var state = $("#upstate").val();
  if(state == null || state == ""){
    $("#upstate_error").show('slow');
    return;
  }
  $("#upstate_error").hide('slow');


  var address_country = $("#upaddress_country").val();
  if(address_country == null || address_country == ""){
    $("#upaddress_country_error").show('slow');
    return;
  }
  $("#upaddress_country_error").hide('slow');


  $("#update_address").prop('disabled', true);
  $("#loading_update_address").show();

  $.ajax({
           url: "/addresses/update", // Route to the Script Controller method
          type: "patch",
      dataType: "json",
          data: {lpid: lpid, aid: aid, line1: line1, line2: line2, city: city, state: state, country: address_country}, // This goes to Controller in params hash, i.e. params[:file_name]
      complete: function() {},
       success: function(data, textStatus, xhr) {
                  $("#update_address").prop('disabled', false);
                  $("#loading_update_address").hide();
                  if (data == "-1"){
                    $("#upaddress_error").show('slow');
                  }
                  else if (data == "1") {
                    location.reload();
                  }
                  else{
                    $("#upaddress_error").show('slow');
                  }
                },
         error: function() {
                  $("#update_address").prop('disabled', false);
                  $("#loading_update_address").hide();
                  $("#upaddress_error").show('slow');
                }
  });
}
/************************ Updating Address of Profile and Leader ********************************/




/************************ Adding Allergy of Profile and Leader ********************************/
function addAllergy(lpid){
  var allergy_name = $("#allergy_name").val();
  if(allergy_name == null || allergy_name == ""){
    $("#allergy_name_error").show('slow');
    return;
  }
  $("#allergy_name_error").hide('slow');

  var allergy_note = $("#allergy_note").val();
  if(allergy_note == null || allergy_note == ""){
    allergy_note = "- - -";
  }

  $("#add_allergy").prop('disabled', true);
  $("#loading_allergy").show();
  $.ajax({
           url: "/allergies", // Route to the Script Controller method
          type: "post",
      dataType: "json",
          data: {lpid: lpid, name: allergy_name, notes: allergy_note}, // This goes to Controller in params hash, i.e. params[:file_name]
      complete: function() {},
       success: function(data, textStatus, xhr) {
                  $("#add_allergy").prop('disabled', false);
                  $("#loading_allergy").hide();
                  if (data == "-1"){
                    $("#allergy_error").show('slow');
                  }
                  else if (data == "1") {
                    location.reload();
                  }
                  else{
                    $("#allergy_error").show('slow');
                  }
                },
         error: function() {
                  $("#add_allergy").prop('disabled', false);
                  $("#loading_allergy").hide();
                  $("#allergy_error").show('slow');
                }
  });
}
/************************ Adding Allergy of Profile and Leader ********************************/

/************************ Updating Allergy of Profile and Leader ********************************/
function update_allergy(lpid){
  var up_allergy_id = $("#up_allergy_id").val();
  var up_allergy_name = $("#up_allergy_name").val();
  if(up_allergy_name == null || up_allergy_name == ""){
    $("#up_allergy_name_error").show('slow');
    return;
  }
  $("#up_allergy_name_error").hide('slow');

  var up_allergy_note = $("#up_allergy_note").val();
  if(up_allergy_note == null || up_allergy_note == ""){
    up_allergy_note = "- - -";
  }

  $("#update_allergy").prop('disabled', true);
  $("#up_loading_allergy").show();
  $.ajax({
           url: "/allergies/update", // Route to the Script Controller method
          type: "patch",
      dataType: "json",
          data: {lpid: lpid, aid: up_allergy_id, name: up_allergy_name, notes: up_allergy_note}, // This goes to Controller in params hash, i.e. params[:file_name]
      complete: function() {},
       success: function(data, textStatus, xhr) {
                  $("#update_allergy").prop('disabled', false);
                  $("#up_loading_allergy").hide();
                  if (data == "-1"){
                    $("#up_allergy_error").show('slow');
                  }
                  else if (data == "1") {
                    location.reload();
                  }
                  else{
                    $("#up_allergy_error").show('slow');
                  }
                },
         error: function() {
                  $("#update_allergy").prop('disabled', false);
                  $("#up_loading_allergy").hide();
                  $("#up_allergy_error").show('slow');
                }
  });
}
/************************ Updating Allergy of Profile and Leader ********************************/
