module ApplicationHelper
    def check_human_verification(datetime)
        return false if !datetime

        # Return false once the last human verification was more than 180 days ago
        (Time.now - datetime) / (24 * 60 * 60) < 180
    end
end
