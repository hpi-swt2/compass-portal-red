class ProblemChecker
  @@human_verified_time = 365
  @@outdated_time = 183

  def data_check_routine
    check_empty_fields(Person)
    check_empty_fields(Room)
    check_for_outdated(Room)
  end

  def check_empty_fields(model)
    model.all.each do |entry|
      entry.attributes.each do |name, value|
        save_problem("missing", entry, name) unless value || name["human_verified"]
      end
    end
  end

  def check_for_outdated(model)
    model.all.each do |entry|
      save_problem("outdated", entry, "all") if entry.updated_at.days_since(@@outdated_time).past?
    end
  end

  def check_for_conflict(entry, new, field)
    old = entry.public_send(field)
    return true if !new || new == old

    if !entry.public_send("human_verified_#{field}")
      if Time.zone.now.days_since(1).future?
        save_problem('conflicting', entry, field)
        return true
      end
    elsif entry.public_send("human_verified_#{field}").days_since(@@human_verified_time).past?
      save_problem('outdated', entry, field)
      return true
    end
    false
  end

  def save_problem(problem, entry, field)
    if entry.instance_of?(Person)
      item = { url: "/people/#{entry.id}", description: problem, field: field, person_id: entry.id }
    end
    DataProblem.where(item).first_or_create if item.present?
  end
end
