module ApplicationHelper
  def age(birthday)
    days = (Date.today - birthday).to_i
    years = (days / 365).floor
    months = (days % 365) / 30
    "#{years} years and #{months} months"
  end
end
