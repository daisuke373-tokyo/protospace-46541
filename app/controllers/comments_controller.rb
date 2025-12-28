class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    # コメントの保存に成功した場合、プロトタイプの詳細ページにリダイレクト
    if @comment.save
      redirect_to prototype_path(params[:prototype_id])
      # params[:prototype_id]でどのプロトタイプにコメントしたかを特定し、そのプロトタイプの詳細ページにリダイレクトしている。
    
    else
      @prototype = Prototype.find(params[:prototype_id])
      # コメントの保存に失敗した場合、再度プロトタイプを取得して@prototypeに代入
      @comments = @prototype.comments.includes(:user)
      # 再度そのプロトタイプに紐づくコメントを取得して@commentsに代入
      render 'prototypes/show', status: :unprocessable_entity

    end
  end


  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end

end