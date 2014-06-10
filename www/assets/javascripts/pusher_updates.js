function fbProfileImage(photoUrl,isFriend,fullName){
    return  $('<img />',
        { src: photoUrl,title: fullName,
            class: isFriend === true ? 'circle-profile' : 'circle-profile friend'});
}

function linkToProfile(url,photoUrl,isFriend,fullName,uid){
    return $('<a />').attr({href: url,title: fullName,id: 'attendee-'+uid}).append(fbProfileImage(photoUrl,isFriend,fullName))
}

function incrementAttendeesCount(event_id){
    $("#attendees-count-"+event_id).text(parseInt($("#attendees-count-"+event_id).text()) + 1)
}

function decrementAttendeesCount(event_id){
    $("#attendees-count-"+event_id).text(parseInt($("#attendees-count-"+event_id).text()) - 1)
}


// update activities(events) list page when new/remove rsvp
function multiActivityRsvpUpdates(pusherKey){
    var pusher = new Pusher(pusherKey);

    var multiActivityChannel = pusher.subscribe("multi-activity-channel");
    multiActivityChannel.bind('create-rsvp', function(res) {
        if(res.is_friend === true){
            $("#people-"+res.event_id).prepend(fbProfileImage(res.photo_url,res.is_friend,res.full_name).attr('id','attendee-'+res.uid)).hide().fadeIn('slow');
        }else{
            $("#people-"+res.event_id).append(fbProfileImage(res.photo_url,res.is_friend,res.full_name).attr('id','attendee-'+res.uid)).hide().fadeIn('slow');
        }
        incrementAttendeesCount(res.event_id)
    })

    multiActivityChannel.bind('remove-rsvp', function(res) {
        $("#people-"+res.event_id+" "+"#attendee-"+res.uid).fadeOut(300, function(){
            $(this).remove();
        });
        decrementAttendeesCount(res.event_id)
    })

}

// update single activity(event show) page when new/remove rsvp
function singleActivityRsvpUpdates(pusherKey){
    var pusher = new Pusher(pusherKey);
    var singleActivityChannel = pusher.subscribe("single-activity-channel");
    singleActivityChannel.bind('create-rsvp', function(res) {
        if(res.is_friend === true){
            $("#people-"+res.event_id).prepend(linkToProfile(res.url,res.photo_url,res.is_friend,res.name,res.uid)).hide().fadeIn('slow');
        }else{
            $("#people-"+res.event_id).append(linkToProfile(res.url,res.photo_url,res.is_friend,res.name,res.uid)).hide().fadeIn('slow');
        }
        incrementAttendeesCount(res.event_id)
    })
    singleActivityChannel.bind('remove-rsvp', function(res) {
        $("#people-"+res.event_id+" "+"#attendee-"+res.uid).fadeOut(300, function(){
            $(this).remove();
        });
        decrementAttendeesCount(res.event_id)
    })
}
