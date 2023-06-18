if Rails.env.test?
  require "simplecov"
  SimpleCov.start "rails" do
    add_filter "app/channels"
  end
end
