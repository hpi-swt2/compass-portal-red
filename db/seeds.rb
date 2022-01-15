# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Points of Interest
PointOfInterest.create(point: Point.create(x: 13.131646, y: 52.393869),
                       description: 'This is Mr. Net, a landmark of the HPI.', name: 'Mr. Net')
PointOfInterest.create(point: Point.create(x: 13.132215, y: 52.393793),
                       description: 'This is Lake HPI.', name: 'Lake HPI')
PointOfInterest.create(point: Point.create(x: 13.133757, y: 52.394414),
                       description: 'This area is used for freetime activities by HPI students.', name: 'Meadow')
PointOfInterest.create(point: Point.create(x: 13.13130, y: 52.39335),
                       description: 'This is a nice place to eat.', name: 'Ulf\'s Cafe')

# Building
building = Building.create(name: "Allesgebäude")

# Floors
floor = Floor.create(name: "First Floor", building: building)
floor2 = Floor.create(name: "Second Floor", building: building)

person_list = [
  [ "michael.perscheid@hpi.de", "Michael", "Perscheid", "Dr.", "",
    "Chair Representative" ],
  [ "hasso.plattner@hpi.de", "Hasso", "Plattner", "Prof. Dr. h.c.", "", "Professor" ],
  [ "mr.net@hpi.de", "Mr.", "Net", "", "", "" ],
  [ "morpheus@student.hpi.de", "Morpheus", "Cyrani", "Käpten zur See", "https://i.ytimg.com/vi/HIFNsd5ayzU/hqdefault.jpg",
    "Tutor" ],
  [ "biene.maya@kika.de", "Maya", "Biene", "", "", "Extern" ]
]
chair_list = [
  "Enterprise Platform and Integration Concepts",
  "Algorithm Engineering",
  "Data Science and Computational Statistics",
  "Human Computer Interaction",
  "Internet-Technologien und Systeme"
]
information_list = [
  [ "telegram", "@perscheid" ],
  [ "telegram", "@plattner" ],
  [ "slack", "@mr.net" ],
  [ "signal", "@morpheus" ],
  [ "website", "diebienemaya.de" ]
]
room_list = [
  [ "V-2.18", floor, "Campus II (Villa), V-2.18"],
  [ "V-2.12", floor, "Campus II (Villa), V-2.18"],
  [ "H-E.51", floor, "Campus I, H-E.51"],
  [ "H-2.3", floor, "Bachelorprojekt Baudisch"],
  [ "A-1.15", floor2, "A-1.15"]
]
room_type_list = [
  ["Seminarraum" ],
  ["Hörsaal" ],
  ["Büro" ],
  ["Toilette" ],
  ["Bachelorprojekt"]
]
person_collection = []

person_list.each do |email, first_name, last_name, title, image, status|
  p_to_add = Person.create(email: email, first_name: first_name, last_name: last_name, title: title,
                           status: status)
  if image.present?
    Rails.logger.debug { "Downloading image! #{image} " }
    p_to_add.image.attach(io: URI(image).open, filename: "test.png")
  end
  person_collection << p_to_add
end

bundle = person_collection.zip chair_list

bundle.each do |person, chair|
  Chair.create(name: chair, people: [person])
end

bundle = person_collection.zip information_list

bundle.each do |person, information|
  Information.create(key: information[0], value: information[1], person: person)
end

Information.create(key: "phone", value: "+49 30 1234567", person: person_collection[0])
Information.create(key: "phone", value: "+49 172 420691337", person: person_collection[3])
Information.create(key: "patent", value: "A", person: person_collection[3])
Information.create(key: "patent", value: "B", person: person_collection[3])
Information.create(key: "patent", value: "C", person: person_collection[3])
Information.create(key: "patent", value: "6", person: person_collection[3])

bundle = person_collection.zip room_list

bundle.each do |person, room|
  Room.create(number: room[0], floor: room[1], full_name: room[2], people: [person])
end

room_type_list.each do |room_type|
  RoomType.create(name: room_type[0])
end

Tag.create(name: "Seminarraum", rooms: [Room.find(5), Room.find(3)])
Tag.create(name: "Drucker", rooms: [Room.find(4)])
Tag.create(name: "Ruhig", rooms: [Room.find(2), Room.find(1), Room.find(3)])
Tag.create(name: "Viel zu laut", rooms: [Room.find(2), Room.find(1), Room.find(3)])

Room.find(1).room_types << RoomType.find(3)
Room.find(2).room_types << RoomType.find(3)
Room.find(3).room_types << RoomType.find(1)
Room.find(4).room_types << RoomType.find(5)
Room.find(5).room_types << RoomType.find(1)
Room.find(5).room_types << RoomType.find(2)

Chair.find(1).rooms << [Room.find(1), Room.find(2)]
Chair.find(2).rooms << [Room.find(3)]
Chair.find(3).rooms << [Room.find(4)]
Chair.find(4).rooms << [Room.find(5)]
Chair.find(5).rooms << [Room.find(5)]
