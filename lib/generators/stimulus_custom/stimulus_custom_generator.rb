require "rails/generators/named_base"

class StimulusCustomGenerator < Rails::Generators::NamedBase # :nodoc:
  source_root File.expand_path("templates", __dir__)

  def copy_view_files
    @attribute = stimulus_attribute_value(controller_name)
    template "controller.js", "#{Dir.glob('**/javascript/controllers/').first}#{controller_name}_controller.js"
    rails_command "stimulus_custom:manifest:update" unless Rails.root.join("config/importmap.rb").exist?
  end

  private

  def controller_name
    name.underscore.gsub(/_controller$/, "")
  end

  def stimulus_attribute_value(controller_name)
    controller_name.gsub(/\//, "--").gsub("_", "-")
  end
end