# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

person_list = [
  [ "michael.perscheid@hpi.de", "Michael", "Perscheid", "Dr.", "https://via.placeholder.com/150",
    "Chair Representative" ],
  [ "hasso.plattner@hpi.de", "Hasso", "Plattner", "Prof. Dr.", "https://via.placeholder.com/150", "Professor" ],
  [ "mr.net@hpi.de", "Mr.", "Net", "", "https://via.placeholder.com/150", "" ],
  [ "morpheus@student.hpi.de", "Morpheus", "Cyrani", "", "https://via.placeholder.com/150", "Tutor" ],
  [ "biene.maya@kika.de", "Maya", "Biene", "", "https://via.placeholder.com/150", "Extern" ]
]
chair_list = [
  [ "Enterprise Platform and Integration Concepts" ],
  [ "Algorithm Engineering" ],
  [ "Data Science and Computational Statistics" ],
  [ "Human Computer Interaction" ],
  [ "Internet-Technologien und Systeme" ]
]
person_collection = []

person_list.each do |email, first_name, last_name, title, image, status|
    person_collection << Person.create(email: email, first_name: first_name, last_name: last_name, title: title, image: image,
        status: status)
    end
    
chair_list = [
    [ "Enterprise Platform and Integration Concepts" ],
    [ "Algorithm Engineering" ],
    [ "Data Science and Computational Statistics" ],
    [ "Human Computer Interaction" ],
    [ "Internet-Technologien und Systeme" ]
]
bundle = person_collection.zip chair_list

bundle.each do |person, chair|
  chair = Chair.create(name: chair, people: [person])
end
    
information_list = [
    [ "Telegram", "@perscheid" ],
    [ "Telegram", "@plattner" ],
    [ "Slack", "@mr.net" ],
    [ "Signal", "@morpheus" ],
    [ "Website", "die-biene-maya.de" ],
]
bundle = person_collection.zip information_list

bundle.each do |person, information|
    Information.create(key: information[0], value: information[1], person: person)
end
