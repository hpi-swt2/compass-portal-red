module ApplicationHelper
  def check_human_verification(datetime: Time)
    return false unless datetime

    # Return false once the last human verification was more than 180 days ago
    (Time.now.utc - datetime.utc) / (24 * 60 * 60) < 180
  end
end
