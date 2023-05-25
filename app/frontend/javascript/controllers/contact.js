$(document).ready(function(){
  var popup = $("#contact-popup");
  var closeBtn = $("#contact-popup .close");

  $("#contact-btn").click(function(event){
    event.preventDefault();
    popup.show();
  });

  closeBtn.click(function(){
    popup.hide();
  });

  $(window).click(function(event){
    if ($(event.target).is(popup)) {
      popup.hide();
    }
  });
});
