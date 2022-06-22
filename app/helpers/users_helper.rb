module UsersHelper

  def user_image_url(user)
    "/user_images/#{user.image_file_name}"
  end

end
