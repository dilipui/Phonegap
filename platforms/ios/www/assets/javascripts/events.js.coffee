$ ->
  ###
  $('#event_start_time').timepicker()
  $('#event_end_time').timepicker()

  $('.eventDatePair .time').timepicker(
    'showDuration': true
    'timeFormat': 'g:ia'
  )
  ###



  ### ////////////////////////////////////////// ###
  ### CREATE ACTIVITY                            ###
  ### ////////////////////////////////////////// ###
  $(".eventDatePair .date").datepicker
    format: "yyyy-m-d"
    startDate: '0d' #show future dates only
    autoclose: true

  #$('.eventDatePair').datepair()

  $('.create-activity .activity-wrapper .btn').click ->
    $('.activity-wrapper .active').removeClass('active')
    $(this).addClass('active')
    $('#event_category_id').val($(this).data('id'))

  $('.form-page .form-group .input-group input').focus ->
    $('.form-page .form-group .input-group.active').removeClass('active')
    $(this).parent().addClass('active')




  ### ////////////////////////////////////////// ###
  ### ACTIVITIES LIST                            ###
  ### ////////////////////////////////////////// ###

  $('.btn-categories').click ->
    if ($(this).hasClass('active'))
      $(this).removeClass('active')
      $('#event-filters').hide()
    else
      $('.activities-filters .active').removeClass('active')
      $(this).addClass('active')
      $('#event-filters .filter.active').removeClass('active')
      $('#event-filters').show()
      $('#event-filters .category-filter').addClass('active')

  $('.btn-timeframe').click ->
    if ($(this).hasClass('active'))
      $(this).removeClass('active')
      $('#event-filters').hide()
    else
      $('.activities-filters .active').removeClass('active')
      $(this).addClass('active')
      $('#event-filters .filter.active').removeClass('active')
      $('#event-filters').show()
      $('#event-filters .timeframe-filter').addClass('active')
  ###
  $('.btn-friends').click ->
    if ($(this).hasClass('active'))
      $(this).removeClass('active')
      $('#event-filters').hide()
    else
      $('.activities-filters .active').removeClass('active')
      $(this).addClass('active')
      $('#event-filters .filter.active').removeClass('active')
      $('#event-filters').show()
      $('#event-filters .friends-filter').addClass('active')
  ####

  $('#event-filters .activity-wrapper .btn').click ->
    $('.activity-wrapper .active').removeClass('active')
    $(this).addClass('active')
    $('#event_category_id').val($(this).data('id'))

  # on category change add the active class for related button
  $('.category-filter #event_category_id').change ->
    $('.activity-wrapper .activity-category .active').removeClass('active')
    $('.activity-wrapper .activity-category').find("[data-id='" + $(this).val()+ "']").addClass('active');




  ### ////////////////////////////////////////// ###
  ### BLUR BACKGROUND IMAGE                      ###
  ### ////////////////////////////////////////// ###

  $('#signin-background').blurjs(
    'source': '#signin-background'
    'radius': 10
    'overlay': 'rgba(0, 0, 0, .1)'
  )

  #$('#event-landing').blurjs(
  #  'source': '#event-landing'
  #  'radius': 10
  #  'overlay': 'rgba(0, 0, 0, .1)'
  #)

  #$('#profile').blurjs(
  #  'source': '#profile'
  #  'radius': 20
  #  'overlay': 'rgba(0, 0, 0, .1)'
  #)


### ////////////////////////////////////////// ###
###  Invite friends                            ###
### ////////////////////////////////////////// ###
root = exports ? this
root.auto_search_friends = (friends) ->
  $("#auto_suggested_friends").autocomplete(
    source: friends
    focus: (event, ui) ->
      $("#auto_suggested_friends").val ui.item.label
      false

    select: (event, ui) ->
      # remove from added list and decrement attendees count
      if $(".friends-added .event-section").find("#inivited-uid-" + ui.item.value).length
        $(".friends-added #inivited-uid-" + ui.item.value).remove()
        $(".friends-added input[value='" + ui.item.value + "']").remove()
        $("#attendees-count").text parseInt($("#attendees-count").text()) - 1
      else
        # append to added list and increment attendees count and create a checkbox with uid as checked
        $(".friends-added .event-section").append "<input type=\"hidden\" name=\"invited_uids[]\" value=\"" + ui.item.value + "\" />"
        $("<img/>").attr(
          id: "inivited-uid-" + ui.item.value
          src: ui.item.photo
          class: "circle-profile-md friend"
          title: $.trim(ui.item.label)
        ).appendTo($(".friends-added .event-section")).fadeIn()
        $("#attendees-count").text parseInt($("#attendees-count").text()) + 1
      # clear the text field
      $(this).val ""
      event.preventDefault()
  ).data("ui-autocomplete")._renderItem = (ul, item) ->
    active_class = "ui-menu-item"
    # apply active class if friend already added in list
    active_class = "ui-menu-item active"  if $(".friends-added .event-section").find("#inivited-uid-" + item.value).length
    $("<li class='" + active_class + "' role='presentation'>").append("<img src= '" + item.photo + "' class='circle-profile-md friend' alt= 'Profile4'/><a id='ui-id-2' class='ui-corner-all' tabindex='-1'>" + item.label + "<i class='fa fa-check'></i></a>").appendTo ul



# http://christianvarga.com/simple-infinite-scroll-with-rails-and-jquery/
# Activities/events infinite page scroll
$ ->
  loading_events = false
  $('a.load-more-events').on 'inview', (e, visible) ->
    return if loading_events or not visible
    loading_events = true
    $.getScript $(this).attr('href'), ->
      loading_events = false