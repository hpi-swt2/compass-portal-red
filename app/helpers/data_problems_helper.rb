module DataProblemsHelper
  def edit_params(id)
    params = "?c_form_highlight="
    DataProblem.where(person_id: id).each do |data_problem|
      params += data_problem[:field]
      params += ","
    end
    params[0...-1]
  end
end
