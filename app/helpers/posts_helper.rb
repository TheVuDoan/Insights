module PostsHelper
  DESCRIPTION_MAX_LENGTH = 125
  TITLE_MAX_LENGTH = 50

  def truncate_description(text)
    short_text = if text.length > DESCRIPTION_MAX_LENGTH
                   text.slice(0, DESCRIPTION_MAX_LENGTH).concat('...') 
                 else
                   text
                 end
  end

  def truncate_title(text)
    short_text = if text.length > TITLE_MAX_LENGTH
                   text.slice(0, TITLE_MAX_LENGTH).concat('...') 
                 else
                   text
                 end
  end
end
