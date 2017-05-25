class HomeController < ApplicationController
   def index
       if user_signed_in?
      @posts = Post.all
      else  
      redirect_to '/users/sign_in'
       end
   end
 
  def create
  end
  
  def new
      @post = Post.create(
      title:params[:satang],
      content:params[:kimbab])
      @post.user = current_user
      if @post.save
      redirect_to "/home/index"
      else
      render :text => @post.errors.messages[:title].first
      end
  end
  
  def read
    @post = Post.find(params[:post_id])
    
  end
 
  def update
    @post = Post.find(params[:post_id])
  end
  
  def edit
    post = Post.find(params[:post_id])
    post.title = params[:satang]
    post.content = params[:kimbab]
    post.save
    redirect_to "/home/index"
  end
  
  def delete
    post = Post.find(params[:post_id])
    post.destroy
    redirect_to "/home/index"
  end
  
  def comment
      comment = Comment.new
      comment.content = params[:comment_id]
      comment.post_id = params[:comment_hidden]
      comment.user = current_user
      comment.save
      redirect_to "/home/read/#{comment.post.id}"
  end
  
  def comment_delete
      comment = Comment.find(params[:comment_id])
      comment.destroy
      redirect_to "/home/read/#{comment.post.id}"
  end
end