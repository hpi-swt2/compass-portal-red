module ApplicationHelper
    def form_color(key, params)
        if params.include? key
            return "#FF9999"
        end
        return "#FFFFFF"
    end
end
