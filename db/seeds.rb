address = "Louvain La Neuve"
capacity = 9

for i in 1..6 do
  time = i * 100
  start_time = time.hours.from_now
  end_time = (time + 1).hours.from_now

  Session.create(start_time:, end_time:, address:, capacity:)
end
