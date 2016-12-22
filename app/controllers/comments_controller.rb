class CommentsController < ApplicationController

  def index
    @comments = Comment.hash_tree
  end

  def show
  end

  def new
    @comment = Comment.new(parent_id: params[:parent_id])
  end

  def edit
  end

  def create
  	#Clicking "Create Comment" transferes control here
    binding.pry
    if params[:comment][:parent_id].to_i > 0
      parent = Comment.find_by_id(params[:comment].delete(:parent_id))
      @comment = parent.children.build(comment_params)
    else
      @comment = Comment.new(comment_params)
    end
  	# @comment = Comment.new(comment_params)
    @comment.article.update(read_count: @comment.article.read_count + 1)
    #User id is not a form field and hence is not assigned in the view. It is assigned when control is transferred back here after Save is pressed
    @comment.user_id = current_user.id
    #Assigning comment_date since it is not a filed on the form
    @comment.comment_date = Date.today

    if @comment.save
      flash[:success] = 'Your comment was successfully added!'
      redirect_to articles_path
    end
  end

  def update
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to articles_path, :notice => "Comment deleted"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:article_id, :comment)
    end

end