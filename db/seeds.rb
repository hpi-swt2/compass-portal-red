# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

person_list = [
  [ "michael.perscheid@hpi.de", "Michael", "Perscheid", "Dr.", "https://via.placeholder.com/150",
    "Chair Representative" ],
  [ "hasso.plattner@hpi.de", "Hasso", "Plattner", "Prof. Dr. h.c.", "https://via.placeholder.com/150", "Professor" ],
  [ "mr.net@hpi.de", "Mr.", "Net", "", "https://via.placeholder.com/150", "" ],
  [ "morpheus@student.hpi.de", "Morpheus", "Cyrani", "Käpten zur See", "https://i.ytimg.com/vi/HIFNsd5ayzU/hqdefault.jpg",
    "Tutor" ],
  [ "biene.maya@kika.de", "Maya", "Biene", "", "https://via.placeholder.com/150", "Extern" ]
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
building_list = [{}, {}, {}, {}]
room_list = [
  ["V-2.18", "2", "Campus II (Villa), V-2.18", nil, 2],
  ["V-2.12", "2", "Campus II (Villa), V-2.18", nil, 2],
  ["H-E.51", "E", "Campus I, H-E.51", nil, 3],
  ["H-2.3", "2", "Bachelorprojekt Baudisch", nil, 3],
  ["A-1.15", "1", "A-1.15", nil, 4]
]
hs_rooms = [
  [nil, "E", "HS 3", 1, 1],
  [nil, "E", "Passage", 2, 1],
  [nil, "E", "HS 2", 3, 1],
  [nil, "E", "Foyer", 4, 1],
  [nil, "E", "R1", 5, 1],
  [nil, "E", "R2", 6, 1],
  [nil, "E", "R3", 7, 1],
  [nil, "E", "HS Building", 8, 1]
]
room_type_list = [
  ["Seminarraum" ],
  ["Hörsaal" ],
  ["Büro" ],
  ["Toilette" ],
  ["Bachelorprojekt"]
]
point_list = [
  { x: 13.13197497245, y: 52.39424529105 },
  { x: 13.13216574457, y: 52.39425511155 },
  { x: 13.1321680915, y: 52.39423935783 },
  { x: 13.13216373291, y: 52.39423894864 },
  { x: 13.1321821731, y: 52.39410719002 },
  { x: 13.132140598859435, y: 52.3941054509739 },
  { x: 13.132140431217495, y: 52.39410872448395 },
  { x: 13.132140284539737, y: 52.394108740636504 },
  { x: 13.132051922451973, y: 52.39410510807157 },
  { x: 13.13199307736, y: 52.39410268895 },
  { x: 13.13216440346, y: 52.39426575042 },
  { x: 13.13219591942, y: 52.39426759176 },
  { x: 13.13219726052, y: 52.39425695289 },
  { x: 13.13220027801, y: 52.39424099458 },
  { x: 13.13221905347, y: 52.39410903137 },
  { x: 13.13218753751, y: 52.39410759921 },
  { x: 13.13239574399, y: 52.39426697798 },
  { x: 13.13241451945, y: 52.39414033431 },
  { x: 13.13242491301, y: 52.3941407435 },
  { x: 13.13242725994, y: 52.39412785406 },
  { x: 13.13241686638, y: 52.39412744487 },
  { x: 13.13241820749, y: 52.39412069325 },
  { x: 13.13225358691, y: 52.39411414623 },
  { x: 13.13225392219, y: 52.39411128191 },
  { x: 13.13222441789, y: 52.39410944056 },
  { x: 13.13220497187, y: 52.39424119917 },
  { x: 13.132422230802476, y: 52.39416345345555 },
  { x: 13.132507390938697, y: 52.39416734074453 },
  { x: 13.132536895237862, y: 52.3939860699573 },
  { x: 13.132123164497317, y: 52.39397297587612 },
  { x: 13.132119811736047, y: 52.39400264214824 },
  { x: 13.132154009900987, y: 52.394003869717686 },
  { x: 13.132149133270739, y: 52.394040695928865 },
  { x: 13.13214318143126, y: 52.3940856416154 },
  { x: 13.132140598855912, y: 52.39410514407977 },
  { x: 13.132429271601138, y: 52.39411885190486 },
  { x: 13.132054768335074, y: 52.39408182020559 },
  { x: 13.132060803305361, y: 52.39403742316715 },
  { x: 13.132064826618882, y: 52.39400100528661 },
  { x: 13.1324212709, y: 52.39398422012 },
  { x: 13.13244521932, y: 52.39416195682 }
]
point_of_interest_list = [
  { point_id: 40, description: "accessible", name: "Entrance" },
  { point_id: 41, description: "accessible", name: "Entrance" },
  { point: Point.create(x: 13.131646, y: 52.393869),
    description: 'This is Mr. Net, a landmark of the HPI.', name: 'Mr. Net' },
  { point: Point.create(x: 13.132215, y: 52.393793),
    description: 'This is Lake HPI.', name: 'Lake HPI' },
  { point: Point.create(x: 13.133757, y: 52.394414),
    description: 'This area is used for free time activities by HPI students.', name: 'Meadow' },
  { point: Point.create(x: 13.13130, y: 52.39335),
    description: 'This is a nice place to eat.', name: 'Ulf\'s Cafe' }

]
polyline_list = [
  [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 1, 1],
  [2, 11, 12, 13, 14, 15, 16, 3, 2, 2],
  [13, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 14, 13, 13],
  [19, 27, 28, 29, 30, 31, 32, 33, 34, 35, 6, 5, 16, 15, 25, 24, 36, 20, 19, 19],
  [9, 37, 34, 8, 9, 9],
  [37, 38, 33, 34, 37, 37],
  [38, 39, 32, 33, 38, 38],
  [1, 10, 9, 39, 31, 30, 29, 28, 27, 19, 18, 17, 13, 12, 11, 2, 1, 1]
]
person_collection = []

person_list.each do |email, first_name, last_name, title, image, status|
  person_collection << Person.create(email: email, first_name: first_name, last_name: last_name, title: title, image: image,
                                     status: status)
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

building_list.each do |building|
  Building.create(building)
end

point_list.each do |point|
  Point.create(point)
end

point_of_interest_list.each do |point_of_interest|
  PointOfInterest.create(point_of_interest)
end

polyline_list.each do |polyline_points|
  Polyline.create(points: polyline_points.map { |point_id| Point.find(point_id) })
end

bundle.each do |person, room|
  Room.create(number: room[0], floor: room[1], full_name: room[2], building_id: room[4], people: [person])
end

hs_rooms.each do |room|
  outer_shape = Polyline.find(room[3]) if room[3].present?
  Room.create(number: room[0], floor: room[1], full_name: room[2], outer_shape: outer_shape, building_id: room[4])
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

PointOfInterest.create(point: Point.create(x: 13.131646, y: 52.393869),
                       description: 'This is Mr. Net, a landmark of the HPI.', name: 'Mr. Net')
PointOfInterest.create(point: Point.create(x: 13.132215, y: 52.393793),
                       description: 'This is Lake HPI.', name: 'Lake HPI')
PointOfInterest.create(point: Point.create(x: 13.133757, y: 52.394414),
                       description: 'This area is used for freetime activities by HPI students.', name: 'Meadow')
PointOfInterest.create(point: Point.create(x: 13.13130, y: 52.39335),
                       description: 'This is a nice place to eat.', name: 'Ulf\'s Cafe')
