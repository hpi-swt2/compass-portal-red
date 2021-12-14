module DataProblemsHelper
    def edit_params(id)
        params = "?"
        for data_problem in DataProblem.where(person_id: id) do
            params+=data_problem[:field]
            params+="&"
        end
    return params[0...-1]
    end
end
