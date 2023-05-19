if Rails.env.development?
  Event.destroy_all

  address = "Louvain La Neuve"
  capacity = 9
  duration = 90
  title = "Vinyasa flow"
  price = 12

  for i in 1..6 do
    time = i * 100
    start_time = time.hours.from_now
    Event.create(start_time:, duration:, address:, capacity:, title:, price:, title:)
  end
end
