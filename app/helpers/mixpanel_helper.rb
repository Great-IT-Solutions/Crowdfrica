module MixpanelHelper
  # Sets up the Mixpanel alias using the Users ID
  def set_mix_alias(user_id, mixpanel_id)
    $tracker.alias(user_id, mixpanel_id)
  end

  # Tracks back end events. Requires the mixpanel ID and the Event name as a String
  def mix_track(mixpanel_id, event_name)
    $tracker.track(mixpanel_id, event_name)
  end

  # Sets and send User tracking data to mixpanel
  def mix_people_set(mixpanel_id, user_obj)
    $tracker.people.set(mixpanel_id, user_obj)
  end

  # Calls all necessary functions upon a new user sign up
  def create_mixpanel_user(user_id, mixpanel_id, event_name, user_obj)
    set_mix_alias(user_id, mixpanel_id)
    mix_track(mixpanel_id, event_name)
    mix_people_set(mixpanel_id, user_obj)
  end
end
# Work Flow For User Tracking
#
# Issues
# Most tracking is done on the front end using js. However, we cannot take this approach
# when tracking log in and sign up events because these occur on the back end. For example,
# if we simply added a click function to the log in button it would fire a log in event on click
# but what if log in fails due to an incorrect email address? This would still result in a user being tracked
# but possibly with the wrong data. This means the only valid way to set up user tracking is after we know
# the authentication process was successful and not simply when a user clicks "sign in".
#
# Work Flow
#
# 1) A new user visits the site and mixpanel automatically sets a tracking ID in a cookie
# 2) After a while they decide to sign up. When they click the sign up button
# a hidden field in the form is assigned the value of the mixpanel ID inorder to pass this to the back end
# 3) In the Registrations controller, if a new Donor account is set up then the create_mixpanel_user
# method is called. This method is located in the mixpanel helper file.
# This method calls other methods. The first method sets an alias for he user.
# We use the Donor.id to set an alias for the user. This means we can now identify our user with their current
# mixpanel Id (in the cookie) or their user id (This will be useful later)
# We also track the Sign in event and pass the user's data to mixpanel to set up a mixpanel user  record for them.
#
# 4) The next part is more interesting.
# If the user switches device or browser they will be assigned a new mix panel ID for this new environment.
# Anything they do will be tracked with this new ID until they log in. After they login, we can identify them with their alias (Donor ID)
# 5) In order to identify the user we need to call the js identify() function. Unfortunately a similar function
# does not exist in ruby so we have to do a work around.
# When the user logs in successfully we send the user ID as a param called mpi and store it in a meta tag called mix_id
# When the page loads and this meta tag has the mpi value the identify() function is called and the user is tracked!
#
# Subsequently the meta tag is blank on all other pages and so the user wont be identified every time they load a page.
# The identify function changes the mix panel ID stored in the cookie to the Donor.id and all future clicks
# will be associated with the user.
