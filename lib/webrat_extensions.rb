require 'webrat'

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
