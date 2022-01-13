namespace :export do
  desc "Export building"
  task export_to_seeds: :environment do
    def print_serialized(record)
      excluded_keys = %w[created_at updated_at id]
      serialized = record
                   .serializable_hash
                   .delete_if { |key, _value| excluded_keys.include?(key) }
      puts "#{record.class.name}.create(#{serialized})"
    end
    Point.all.each { |point| print_serialized(point) }

    PointOfInterest.all.each { |point_of_interest| print_serialized(point_of_interest) }

    Polyline.all.each { |polyline| print_serialized(polyline) }

    Wall.all.each { |wall| print_serialized(wall) }

    Room.all.each { |room| print_serialized(room) }

    Building.all.each { |building| print_serialized(building) }
  end
end
