module MenteesHelper
  def format_date(date)
    date = date - 60*60*4
    date.strftime("%l:%M %P")
  end
end
