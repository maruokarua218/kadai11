class PicturesController < ApplicationController
  before_action :set_picture, only: %i[ show edit update destroy ]

  def index
    @pictures = Picture.all
  end

  def show
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  def new
    @picture = Picture.new
  end

  def edit
    if current_user.id != Picture.find(params[:id]).user.id
      flash[:notice]="権限がありません"
      redirect_to pictures_path
    end
  end

  def create
    @picture = current_user.pictures.build(picture_params)
    if params[:back]
      render :new
    else
      if @picture.save
      # ContactMailer.contact_mail(User.find(session[:user_id])).deliver
        redirect_to pictures_path, notice: "画像を投稿しました！"
      else
        render :new
      end
    end
  end

  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to picture_url(@picture), notice: "Picture was successfully updated." }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if current_user.id != Picture.find(params[:id]).user.id
      flash[:notice]="権限がありません"
      redirect_to pictures_path
    else
      @picture.destroy
      respond_to do |format|
        format.html { redirect_to pictures_url, notice: "Picture was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end

  def confirm
    @picture = current_user.pictures.build(picture_params)
    render :new if @picture.invalid?
  end

  private

  def set_picture
    @picture = Picture.find(params[:id])
  end


  def picture_params
    params.require(:picture).permit(:image, :image_cache, :content)
  end
end
