require 'cucumber/formatter/ordered_xml_markup'
require 'cucumber/formatter/duration'

module Webrat
  class ButtonField
  end

  class SelectOption
    alias :standard_choose :choose

    def choose
      standard_choose
      current_selections = XML.xpath_search(select_element, ".//option[@selected = 'selected']")
      remove_selection_from current_selections unless current_selections.empty?
      @element['selected'] = ''
    end

    private

    def remove_selection_from options
      options.each {|option| option.remove_attribute 'selected' }
    end
  end

  class TextField
    def set(value)
      @value = value
      @element['value'] = value
    end
  end

  class TextAreaField
  end

  class CheckboxField
  end

  class RadioField
  end

  class PasswordField
  end

  class FileField
  end

  class ResetField
  end
end

class VisibleCukes < Cucumber::Formatter::Html
  def initialize(step_mother, io, options)
    super(step_mother, io, options)

    @rb = step_mother.load_programming_language('rb')
  end

  def visit_feature_name(name)
    super(name)
    @current_page_name_prefix = name.split(/\r?\n/)[0].downcase.gsub(/\s+/, '_').gsub(/[^a-z_]/, '')
    @current_page_name_count = 1
  end

  def visit_step(step)
    @step_id = step.dom_id
    html_filename = "feature_pages/#{@current_page_name_prefix}_#{@current_page_name_count}.html"
    @current_page_name_count += 1
    @builder.a(:href => html_filename) do
      super
    end
    save_file html_filename
  end

  private

  def save_file html_filename
    full_path = File.expand_path("./doc/#{html_filename}")
    unless has_response?
      File.open(full_path, 'w') do |f|
        f.write(current_page)
      end
    end
  end

  def has_response?
    current_world.response.nil?
  end

  def current_page
    current_world.webrat.dom
  end

  def current_world
    @rb.current_world
  end
end
