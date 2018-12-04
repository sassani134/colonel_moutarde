document.addEventListener("turbolinks:load", function() {
  $('document').ready(function(){
    $("a[href='#']").on('click', function ($) {
      $.preventDefault();
    });
  });
  $('document').ready(function(){
    $('#search-btn, #closeBtn').on('click', function () {
      $('body').toggleClass('search-form-on');
    });
  });
});