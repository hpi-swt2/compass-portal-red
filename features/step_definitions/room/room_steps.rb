When 'a room was created' do
  FactoryBot.create :room
end

When 'a room without a room type was created' do
  FactoryBot.create :room, room_types: [], tags: [Tag.create(name: "quiet")], full_name: "H-E.43"
end
