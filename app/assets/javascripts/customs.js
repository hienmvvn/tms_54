$(document).ready(function(){
  $('form').on('click', '.remove_fields', function(event){
    $(this).prev('input[type=hidden]').val(true);
    $(this).parent().parent().parent().hide();
    event.preventDefault();
  });

  $('form').on('click', '.add_fields', function(event){
    var time = new Date().getTime();
    var regexp = new RegExp($(this).data('id'), 'g');
    $(this).before($(this).data('fields').replace(regexp, time));
    event.preventDefault();
  });
});

$(document).ready(function(){
  $('#change').click(function(){
    $('#password').slideToggle('slow');
  });
});
