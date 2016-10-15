$(document).ready(function() {

	// Delegating events on document rather than binding
	// since many of these buttons are generated after on() fires
	// (i.e. through an AJAX call, usually)
	$(document).on('click', '.btn_like', function(event) { 

		// Determine which like button they pressed
		like_id = event.target.id;

		// Determine which way they went: liking or unliking
		// * when :liked is :true, they are now UN-Liking it. And the buttons should change to Like.
		// * when :liked is :false, they are now Liking it. And the buttons should change to Unlike.
		point_id = like_id.split('_')[1];
		liked = $('#liked_'+point_id).val() == 'true' ? true : false;
		reputation = parseInt($('#reputation_'+point_id).html());

		// Change the innerHTML of the a.btn_like#like_id
		$('#'+like_id).html( liked ? 'Like' : 'Unlike' );

		// Change the AJAX target between like_point_path and unlike_point_path
		$('#'+like_id).attr("href", "/points/"+point_id+"/"+(liked?'like':'unlike')+".json");

		// Change value of input#liked_id to the new value
		$('#liked_'+point_id).val( liked ? 'false' : 'true' );

		// Adjust the innerHTML of the span#reputation_id up or down
		$('#reputation_'+point_id).html( liked ? reputation - 1 : reputation + 1 );

		// Hide the span#reputation_block_id if rep is zero, show otherwise
		if(parseInt($('#reputation_'+point_id).html()) == 0){
			$('#reputation_block_'+point_id).hide();
		} else {
			$('#reputation_block_'+point_id).show();
		}

		// If they are liking it, 
		if(liked == false) {

			// figure out who they are, then
			[display_name, profile_url] = $('#reputation_liker_'+point_id).val().split(', ');

			// append their name to the liker list.
			current_user_link = '<a href="'+profile_url+'">'+display_name+'</a>';
			likers = $('#reputation_likers_'+point_id).html().split(', ');
			if (likers.length == 1 && likers[0] == "") {
				likers = [];
			}
			if (current_user_link != likers[likers.length-1]) {
				likers.unshift(current_user_link);
			}
			$('#reputation_likers_'+point_id).html(likers.join(', '));
		}
	});
});