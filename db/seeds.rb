address = "Louvain La Neuve"
capacity = 9
duration = 90

for i in 1..6 do
  time = i * 100
  start_time = time.hours.from_now
  Session.create(start_time:, duration:, address:, capacity:)
end
