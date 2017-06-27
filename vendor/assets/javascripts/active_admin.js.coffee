#= require active_admin/base
#= require activeadmin_reorderable

jQuery ->
  $(".polyselect").on "change", ->
    $('.polyform').hide()
    $('#' + $(@).val() + '_poly').show()
    $(".select2-container").css('width', '');

  $('.polyform').first().parent('form').on "submit", (e) ->
    $('.polyform').each (index, element) =>
      $e = $(element)
      if $e.css('display') != 'block'
        $e.remove()

  # $('#component_lesson_id').parent().hide()
  lessons = $('#component_lesson_id').html()
  $('#component_course').change ->
    course = $('#component_course :selected').text()
    options = $(lessons).filter("optgroup[label='#{course}']").html()
    if options
      $('#component_lesson_id').html(options)
      # $('#component_lesson_id').parent().show()
    else
      $('#component_lesson_id').empty()
      # $('#component_lesson_id').parent().hide()
