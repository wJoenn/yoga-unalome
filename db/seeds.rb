if Rails.env.development?
  admin = User.create(email: "info@yogaunalome.com", password: "password", first_name: "admin", last_name: "admin", admin: true)
  admin.confirm

  user = User.create(email: "user@example.com", password: "password", first_name: "user", last_name: "user")
  user.confirm

  Event.destroy_all

  address = "Louvain La Neuve"
  capacity = 9
  duration = 90
  title = "Vinyasa flow"
  price = 12

  for i in 1..20 do
    time = i * 100
    start_time = time.hours.from_now
    Event.create(start_time:, duration:, address:, capacity:, price:, title:)
  end
end
