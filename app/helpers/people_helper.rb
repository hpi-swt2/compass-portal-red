module PeopleHelper
  def last_verified_in_words(verification_attr)
    verification_attr.present? ? "#{time_ago_in_words(verification_attr)} ago" : "never"
  end
end
