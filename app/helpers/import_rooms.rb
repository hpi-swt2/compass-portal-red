require 'csv'
require 'point'
require 'room'
require 'building'
require 'polyline'

rooms = %w[A B C D E F G H I]
# extend to import more rooms
building = Building.create

csv_text = File.read('app/assets/data/importBuilding1.csv')
csv = CSV.parse(csv_text)
points = {}
rooms.each do |name|
  polygon = {}
  # Collect all points of this room
  csv.each do |row|
    next unless row[0..3].collect { |x| x.to_s[0] }.include? name.to_s

    key = row[0].to_s + row[1].to_s + row[2].to_s + row[3].to_s
    id = row[0..3].find { |e| e.to_s[0] == name.to_s }
    number = id[1..id.length - 1] # will not work with multi-char room identifier
    points[key] = Point.create(x: row[4], y: row[5]) unless points.key? key
    polygon[number] = points[key]
  end
  polygon = polygon.sort_by { |key, _value| key.to_i }.to_h
  room = Room.new(building: building)
  room.outer_shape = Polyline.create
  room.outer_shape.points.push(polygon.values)
  room.outer_shape.points.push(polygon['1'])
  room.save
end
