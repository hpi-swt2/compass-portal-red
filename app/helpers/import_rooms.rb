require 'csv'
require 'point'
require 'room'
require 'building'
require 'polyline'

rooms = ['A','B','C','D','E','F','G','H','I']
building = Building.create

csv_text = File.read('app/assets/data/importBuilding1.csv')
csv = CSV.parse(csv_text)
points = Hash.new
rooms.each do |name, array|
    polygon = Hash.new
    csv.each do |row|
        if row[0..3].collect{|x| x.to_s[0] }.include? name.to_s
            key = row[0].to_s + row[1].to_s + row[2].to_s + row[3].to_s
            id = row[0..3].select{|e| e.to_s[0] == name.to_s}[0]
            number = id[1..id.length-1] #will not work if more than 24 rooms (can be fixed with regex)
            if points.key? key
                polygon[number] = points[key]
            else
                points[key] = Point.create(x: row[4], y: row[5])
                polygon[number] = points[key]
            end
        end
    end
    polygon = Hash[polygon.sort_by{ |key, value| key.to_i }]
    room = Room.new(building: building)
    room.outer_shape = Polyline.create
    room.outer_shape.points.push(polygon.values)
    room.outer_shape.points.push(polygon['1'])
    room.save
end


