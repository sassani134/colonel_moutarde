# frozen_string_literal: true

module ApplicationHelper
  def flash_class(level)
    case level.to_sym
    when :notice then 'alert alert-info mb-0'
    when :success then 'alert alert-success mb-0'
    when :error then 'alert alert-error mb-0'
    when :alert then 'alert alert-error mb-0'
    end
  end
end
