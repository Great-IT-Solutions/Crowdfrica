module DonorsHelper
  # find out if current donor is a known donor
  def donor_is_registered?
    # we can determine if a donor is a registered donor if only the donor can
    # sign in, thus if you have the current_donor signed in then that donor is
    # a registered donor
    # reason that you can only sign in when registered? else you are not a registered
    # donor
    donor_signed_in? && current_donor.registered?
  end
end
