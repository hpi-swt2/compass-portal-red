require 'csv'
require 'point'
require 'room'
require 'building'
require 'polyline'

rooms = ['A','B','C','D','E','F','G','H','I']
building = Building.create

csv_text = File.read('app/assets/data/test2.csv')
csv = CSV.parse(csv_text)
rooms.each do |name, array|
    room = Room.new(building: building)
    points = Hash.new
    csv.each do |row|
    #reihenfolge ? 
        if row[0..3].include? name.to_s
            puts 'hahah'
            id = row[0..3].select {|e| e.include? name.to_s}
            puts id
            number = id[1]
            points[number] = Point.create(x: row[4], y: row[5])
            #find column id 
            #seperate number from char 
            #speicher point in ordered list mit key der nummer 
            
        end
        #points.sort()
        #room.outer_shape = Polyline.create
        #room.outer_shape.points.push(points.value)
        #room.save()
    end
end

