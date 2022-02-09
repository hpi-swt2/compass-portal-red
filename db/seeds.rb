# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
hs_building = Building.create(name: "lecture hall")
h_building =  Building.create(name: "Main Building")
v_building =  Building.create(name: "Villa")
a_building =  Building.create(name: "A Building")

# Floors
hs_floor = Floor.create(name: "D First Floor", building: hs_building)
hs_floor2 = Floor.create(name: "D Basement", building: hs_building)
h_floor = Floor.create(name: "H First Floor", building: h_building)
h_floor3 = Floor.create(name: "H Third Floor", building: h_building)
v_floor3 = Floor.create(name: "V Third Floor", building: v_building)
a_floor2 = Floor.create(name: "A Third Floor", building: a_building)

person_list = [
  [ "michael.perscheid@hpi.de", "Michael", "Perscheid", "Dr.", "",
    "Chair Representative" ],
  [ "biene.maya@kika.de", "Maya", "Biene", "", "", "Extern" ],
  [ "mr.net@hpi.de", "Mr.", "Net", "", "", "" ],
  [ "morpheus@student.hpi.de", "Morpheus", "Cyrani", "Käpten zur See", "https://i.ytimg.com/vi/HIFNsd5ayzU/hqdefault.jpg",
    "Tutor" ],
  [ "hasso.plattner@hpi.de", "Hasso", "Plattner", "Prof. Dr. h.c.", "", "Professor" ],
  [ "katharina.@hpi.de", "Katherina", "Hölzle", "Prof. Dr.", "", "Professor" ],
  [ "fox@hpi.de", "Smilla Jane", "Fox", "", "", "Student" ],
  [ "facility-management@hpi.de", "Steffen", "Zierl", "", "", "FM-Team" ]
]
chair_list = [
  "Enterprise Platform and Integration Concepts",
  "Algorithm Engineering",
  "Data Science and Computational Statistics",
  "Human Computer Interaction",
  "Internet-Technologien und Systeme",
  "IT-Entrepreneurship",
  "Digital Health & Machine Learning"
]
course_list = [
  ["Mathematik III", "Pflichtmodul", DateTime.new(2022, 5, 15, 9, 0, 0), 1,
   [["Monday", "9:15", "10:45"], ["Wednesday", "11:00", "12:30"]]],
  ["Data Science", "Vertiefungsmodul", DateTime.new(2022, 5, 17, 10, 0, 0), 2,
   [["Tuesday", "9:15", "10:45"], ["Thursday", "11:00", "12:30"]]],
  ["Competitive Programming II", "Vertiefungsmodul", DateTime.new(2022, 5, 10, 12, 0, 0), 3,
   [["Friday", "14:00", "16:00"]]],
  ["3D-Computergrafik I", "Softwarebasissysteme", DateTime.new(2022, 3, 25, 9, 30, 0), 2,
   [["Tuesday", "13:30", "15:00"], ["Wednesday", "13:30", "15:00"]]],
  ["3D-Computergrafik II", "Vertiefungsmodul", DateTime.new(2021, 8, 15, 9, 30, 0), 5,
   [["Monday", "11:00", "12:30"], ["Wednesday", "16:15", "17:45"]]]
]
information_list = [
  %w[telegram @perscheid],
  %w[website diebienemaya.de],
  %w[slack @mr.net],
  %w[signal @morpheus],
  %w[telegram @plattner],
  %w[MeetUp @hölzle],
  %w[linkedIn @smililah],
  %w[linkedIn @steffen-zierl]
]
room_list = [
  ['D-E.3', hs_floor, "HS 3", 1],
  ['D-E.5', hs_floor, "Passage", 2],
  ['D-E.2', hs_floor, "HS 2", 3],
  ['D-E.6', hs_floor, "HS Foyer", 4],
  ['D-E.4', hs_floor, "HS Anrichte", 5],
  ['D-E.7', hs_floor, "HS Lager", 6],
  ['D-E.8', hs_floor, "HS Elektro", 7],
  ['D-K.1', hs_floor2, "Ping Pong", 4],
  ['D-K.2', hs_floor2, "HS toilet (f)", 5],
  ['D-K.3', hs_floor2, "HS toilet (m)", 6],
  ['H-2.3', h_floor3, "Bachelorprojekt Baudisch", 9],
  ['V-2.18', v_floor3, "Campus II (Villa), V-2.18", 10],
  ['H-E.51', h_floor, "Campus I, H-E.51", 11],
  ['A-1.15', a_floor2, "A-1.15", 12]
]
room_type_list = [
  ["lecture hall" ],
  ["kitchen"],
  ["lounge"],
  ["toilet"]
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
  { x: 13.13244521932, y: 52.39416195682 },
  { x: 13.131646, y: 52.393869 },
  { x: 13.132215, y: 52.393793 },
  { x: 13.133757, y: 52.394414 },
  { x: 13.13130, y: 52.39335 },
  { x: 13.133389502763748, y: 52.39391507523473 },
  { x: 13.133473992347717, y: 52.39391507523473 },
  { x: 13.133473992347717, y: 52.39397318026657 },
  { x: 13.133389502763748, y: 52.39397318026657 },
  { x: 13.123732209205627, y: 52.39220298841202 },
  { x: 13.123751655220984, y: 52.39210232349622 },
  { x: 13.123880401253698, y: 52.39211500892508 },
  { x: 13.123854920268057, y: 52.392210763335015 },
  { x: 13.133128657937048, y: 52.394085298210406 },
  { x: 13.133121952414513, y: 52.39401000735983 },
  { x: 13.133279532194136, y: 52.39401409925719 },
  { x: 13.133294954895973, y: 52.394082843076 },
  { x: 13.13133493065834, y: 52.393397855241936 },
  { x: 13.131368458271025, y: 52.393397855241936 },
  { x: 13.131368458271025, y: 52.393419951789596 },
  { x: 13.13133493065834, y: 52.393419951789596 }
]
point_of_interest_list = [
  { point_id: 40, description: "accessible", name: "Entrance" },
  { point_id: 41, description: "accessible", name: "Entrance" },
  { point_id: 42, description: 'This is Mr. Net, a landmark of the HPI.', name: 'Mr. Net' },
  { point_id: 43, description: 'This is Lake HPI.', name: 'Lake HPI' },
  { point_id: 44, description: 'This area is used for free time activities by HPI students.', name: 'Meadow' },
  { point_id: 45, description: 'This is a nice place to eat.', name: 'Ulf\'s Cafe' }
]
polyline_list = [
  [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 1],
  [2, 11, 12, 13, 14, 15, 16, 3, 2],
  [13, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 14, 13],
  [19, 27, 28, 29, 30, 31, 32, 33, 34, 35, 6, 5, 16, 15, 25, 24, 36, 20, 19],
  [9, 37, 34, 8, 9],
  [37, 38, 33, 34, 37],
  [38, 39, 32, 33, 38],
  [1, 10, 9, 39, 31, 30, 29, 28, 27, 19, 18, 17, 13, 12, 11, 2, 1],
  [46, 47, 48, 49, 46],
  [50, 51, 52, 53, 50],
  [54, 55, 56, 57, 54],
  [58, 59, 60, 61, 58]
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

point_list.each do |point|
  Point.create(point)
end

point_of_interest_list.each do |point_of_interest|
  PointOfInterest.create(point_of_interest)
end

polyline_list.each do |polyline_points|
  Polyline.create(points: polyline_points.map { |point_id| Point.create(point_list[point_id - 1]) })
end

room_list.each do |room|
  outer_shape = Polyline.find(room[3]) if room[3].present?
  Room.create(number: room[0], floor: room[1], full_name: room[2], outer_shape: outer_shape, room_types: [], tags: [])
end

Room.find(3).people << Person.find(6)
Room.find(5).people << Person.find(2)
Room.find(5).people << Person.find(3)
Room.find(11).people << Person.find(4)
Room.find(12).people << Person.find(1)
Room.find(12).people << Person.find(5)
Room.find(13).people << Person.find(7)

room_type_list.each do |room_type|
  RoomType.create(name: room_type[0])
end

Tag.create(name: "seminar room", rooms: [Room.find(13)])
Tag.create(name: "printer", rooms: [Room.find(14)])
Tag.create(name: "working", rooms: [Room.find(1), Room.find(3), Room.find(11), Room.find(12), Room.find(13)])
Tag.create(name: "quiet", rooms: [Room.find(1), Room.find(3), Room.find(13)])

Room.find(1).room_types << RoomType.find(1)
Room.find(3).room_types << RoomType.find(1)
Room.find(4).room_types << RoomType.find(3)
Room.find(5).room_types << RoomType.find(2)
Room.find(8).room_types << RoomType.find(3)
Room.find(9).room_types << RoomType.find(4)
Room.find(10).room_types << RoomType.find(4)

Chair.find(1).rooms << [Room.find(1), Room.find(2)]
Chair.find(2).rooms << [Room.find(3)]
Chair.find(3).rooms << [Room.find(4)]
Chair.find(4).rooms << [Room.find(5)]
Chair.find(5).rooms << [Room.find(5)]

course_list.each do |name, module_category, exam_date, room_id, times|
  course = Course.create(name: name, module_category: module_category, exam_date: exam_date, room_id: room_id)
  times.each do |weekday, start_time, end_time|
    course.course_times.create(weekday: weekday, start_time: start_time, end_time: end_time)
  end
end

Course.find(1).people << [Person.find(1), Person.find(4)]
Course.find(2).people << [Person.find(1)]
Course.find(3).people << [Person.find(2)]
Course.find(4).people << [Person.find(2)]
Course.find(5).people << [Person.find(2)]
