module ApplicationHelper
  def full_title title
    default_title = t "application.title"
    default_title.empty? ? default_title : title + default_title
  end

  def watch_movie value_url
    "//ok.ru/videoembed/" + value_url
  end

  def get_key_url_movie id
    Episode.find_by(id: id).episode_url.split("/").last
  end
end
