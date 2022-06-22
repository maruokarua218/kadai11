module ApplicationHelper

  def random_string(n)
    chars = ("0".."9").to_a.join + ("A".."Z").to_a.join + ("a".."z").to_a.join
    (Array.new(n).map! {|e| chars[rand(chars.length)]}).join
  end

end
