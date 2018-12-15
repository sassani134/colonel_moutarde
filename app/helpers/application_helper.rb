# frozen_string_literal: true

module ApplicationHelper
  def flash_class(level)
    case level.to_sym
    when :notice then 'alert alert-info alert-dismissible mb-0'
    when :success then 'alert alert-success alert-dismissible mb-0'
    when :error then 'alert alert-error alert-dismissible mb-0'
    when :alert then 'alert alert-error alert-dismissible mb-0'
    end
  end
end
