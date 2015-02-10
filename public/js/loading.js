$(document).ready(function() {
  var username = $('#username').text()
  $.ajax({
    type: 'GET',
    url: '/data/' + username + '',
    success: function(msg) {
      $('#deletethis').remove()
      $('.container').append(msg)
    },
  });
});
