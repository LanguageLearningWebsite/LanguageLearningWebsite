#= require active_admin/base
#= require activeadmin_reorderable

jQuery ->
  $(".has_many_delete").addClass("multiCol");
  $(document).on 'has_many_add:after', '.has_many_container.questions', (e, fieldset, container)->
    $('.has_many_container.options').next().children(".has_many_remove").text("Remove question");
    remove_question = $('a:contains("Remove question")').last();
    remove_question.css("margin-left", "8px");
    options_list = $('a:contains("Add option")').parent().last();
    options_list.append(remove_question);

  $(".polyselect").on "change", ->
    $('.polyform').hide();
    $('#' + $(@).val() + '_poly').show()
    $(".select2-container").css('width', '');

  $('.polyform').first().parent('form').on "submit", (e) ->
    $('.polyform').each (index, element) =>
      $e = $(element)
      if $e.css('display') != 'block'
        $e.remove()

  lessons = $('#component_lesson_id').html()
  $('#component_course').change ->
    course = $('#component_course :selected').text()
    options = $(lessons).filter("optgroup[label='#{course}']").html()
    if options
      $('#component_lesson_id').html(options)
    else
      $('#component_lesson_id').empty()
