module PeopleHelper
    def form_color(key, params)
        for param in params do
            if param == key
                return "#FF9999"
            end
        end
        return "#FFFFFF"
    end
end
