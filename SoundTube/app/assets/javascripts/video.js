$(function() {
  $('.ajax-progress').hide();  // hide it initially.
  $(document)
    .ajaxStart(function() {
    	$('.content').hide();
      $('.ajax-progress').show(); // show on any Ajax event.
    })
    .ajaxStop(function() {
      $('.ajax-progress').hide();
      $('.content').show(); // hide it when it is done.
  });
});
