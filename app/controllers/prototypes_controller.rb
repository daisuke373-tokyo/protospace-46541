class PrototypesController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]
  def index
    @prototypes = Prototype.all
    
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
    # プロトタイプに紐づくコメントを全て取得するして@commentsに代入。また、N+1問題を防ぐためにincludesメソッドでユーザー情報もまとめて取得している。
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index  
    end
  end


  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :main_image).merge(user_id: current_user.id) 
  end

end
