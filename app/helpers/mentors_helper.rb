module MentorsHelper
  def format_date(date)
    date = date - 60*60*4
    date.strftime("%l:%m %P")
  end
end
