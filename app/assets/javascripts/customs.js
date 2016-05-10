$(document).ready(function(){
  $('#change').click(function(){
    $('#password').slideToggle('slow');
  });

  $('form').on('click', '.remove_fields', function(event){
    $(this).prev('input[type=hidden]').val(true);
    $(this).parent().parent().parent().hide();
    event.preventDefault();

    validateSubjectForm()
  });

  $('form').on('click', '.add_fields', function(event){
    var time = new Date().getTime();
    var regexp = new RegExp($(this).data('id'), 'g');
    $(this).before($(this).data('fields').replace(regexp, time));
    event.preventDefault();

    validateSubjectForm()
  });

  $('#subject-form-update').change(function(){
    if($(this).find('#subject_title').val().length == 0){
      $('#error-subject-title').html('Subject title can not be blank');
    }else{
      $('#error-subject-title').html(null);
    }
    if($(this).find('#subject_description').val().length == 0){
      $('#error-subject-description').html('Subject description can not be blank');
    }else{
      $('#error-subject-description').html(null);
    }

    validateSubjectForm()
  });
});

function validateSubjectForm(){
  var number_of_task = 0;
  $('.form-task-field').each(function(){
    if($(this).find('.col-sm-12').find('input:hidden').val() == 'false'){
      number_of_task++;
    }
  });
  if(number_of_task < 2){
    $('#error-number-task').html('Word answer Must have at least two answers');
  }else{
    $('#error-number-task').html(null);
  }
}
