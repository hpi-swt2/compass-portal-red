class ProblemChecker
  @@human_verified_time = 365

  def check_for_empty_person_fields
    Person.all.each do |entry|
      entry.attributes.each do |name, value|
        save_problem("missing", entry, name) unless value
      end
    end
  end

  def check_for_empty_room_fields
    Room.all.each do |entry|
      entry.attributes.each do |name, value|
        save_problem("missing", entry, name) unless value
      end
    end
  end

  def check_for_conflict(entry, new, field)
    old = entry.public_send(field)
    return true if !new || new == old

    if !entry.public_send("human_verified_#{field}")
      if time.current - entry.updated_at < 1
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
    item = { url: entry.url, description: problem, field: field, person_id_id: entry.object_id } if entry.instance_of?(Person)
    DataProblem.where(item).first_or_create if item.present?
  end
end
