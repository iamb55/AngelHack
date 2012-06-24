module MenteesHelper
  def format_date(date)
    date.strftime("%l:%m %P")
  end
end
