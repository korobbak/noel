module ApplicationHelper
  def full_title title
    default_title = t "application.title"
    default_title.empty? ? default_title : title + default_title
  end

  def get_key_url_movie id
    if !Episode.find_by(id: id).episode_url.scan("ok").empty?
      @value_url = Episode.find_by(id: id).episode_url.split("/").last
      "//ok.ru/videoembed/" + @value_url
    elsif !Episode.find_by(id: id).episode_url.scan("google").empty?
      @value_url = Episode.find_by(id: id).episode_url.split("=").last
      "https://drive.google.com/file/d/#{@value_url}/preview"
    end
  end

  def kt id
    if !Episode.find_by(id: id).episode_url.scan("ok").empty?
      0
    elsif !Episode.find_by(id: id).episode_url.scan("google").empty?
      1
    end
  end

end
