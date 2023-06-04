function changeIcon(event) {
  event.preventDefault();
  var iconElement = event.currentTarget.querySelector('i');
  iconElement.className = 'fas fa-envelope-open';

  setTimeout(function () {
    var popup = $("#contact-popup");
    var closeBtn = $("#contact-popup .close");
    var contactButtonDiv = $(".contact-button");

    popup.css({ "display": "block", "height": "0" }).animate({ height: "40%" }, 500);
    contactButtonDiv.hide();

    closeBtn.click(function () {
      popup.animate({ height: "0" }, 500, function () {
        popup.css("display", "none");
        contactButtonDiv.show();
      });
    });
  }, 1000);
}

$(document).ready(function () {
  var contactBtn = $("#contact-btn");
  var mailContactBtn = $("#mail-contact-btn");
  contactBtn.click(function (event) {
    event.preventDefault();
    var popup = $("#contact-popup");
    var closeBtn = $("#contact-popup .close");
    var contactButtonDiv = $(".contact-button");

    popup.css({ "display": "block", "height": "0" }).animate({ height: "40%" }, 500);
    contactButtonDiv.hide();

    closeBtn.click(function () {
      popup.animate({ height: "0" }, 500, function () {
        popup.css("display", "none");
        contactButtonDiv.show();
      });
    });
  });

  mailContactBtn.click(changeIcon);

  var popup = $("#contact-popup");
  var closeBtn = $("#contact-popup .close");
  var contactButtonDiv = $(".contact-button");

  closeBtn.click(function () {
    popup.animate({ height: "0" }, 500, function () {
      popup.css("display", "none");
      contactButtonDiv.show();
    });
  });

  $(window).click(function (event) {
    if ($(event.target).is(popup)) {
      popup.animate({ height: "0" }, 500, function () {
        popup.css("display", "none");
        contactButtonDiv.show();
      });
    }
  });
});
