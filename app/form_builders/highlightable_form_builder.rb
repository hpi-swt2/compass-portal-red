class HighlightableFormBuilder < ParamFormBuilder
  HIGHLIGHT_PARAM_NAME = :c_form_highlight
  HIGHLIGHT_PARAM_SEP = ','.freeze
  HIGHLIGHT_CLASS_NAME = 'highlighted'.freeze

  def initialize(*args)
    super
    @highlights = split_highlight_params
  end

  def update_options(name, options)
    options[:class] = "#{options[:class]} form-control"
    options[:class] = "#{options[:class]} #{HIGHLIGHT_CLASS_NAME}" if highlighted? name
    options
  end

  # Splits the passed highlights in the parameters to an array
  def split_highlight_params
    highlight_string = @params[HIGHLIGHT_PARAM_NAME]
    highlight_string.nil? ? [] : highlight_string.split(HIGHLIGHT_PARAM_SEP)
  end

  def highlighted?(name)
    @highlights.include?(name.to_s)
  end
end
