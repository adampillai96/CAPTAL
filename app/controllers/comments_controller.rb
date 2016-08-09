class CommentsController < ApplicationController

  def index

    @post = Post.includes(:comments).find_by(id: params[:post_id])
    @topic = @post.topic
    @comments = @post.comments.order("created_at DESC")


  end

  def show
    # @comment = Comment.find_by(id: params[:id])

  end

  def new
    @post = Post.find_by(id: params[:post_id])
    @topic = @post.topic
    @comment = Comment.new
  end

  def create
    @post = Post.find_by(id: params[:post_id])
    @topic = @post.topic
    @comment = Comment.new(comment_params.merge(post_id: params[:post_id]))

  if @comment.save
            redirect_to topic_post_comments_path(@topic, @post)
        else
            render :new
        end
  end

  def edit
    @comment = Comment.find_by(id: params[:id])
    @post = @comment.post
    @topic = @post.topic
  end

  def update
    @post = Post.find_by(id: params[:post_id])
    @topic = @post.topic
    @comment = Comment.find_by(id: params[:id])

    if @comment.update(comment_params)
      redirect_to topic_post_comments_path(@topic , @post)
    else
      redirect_to edit_topic_post_comment_path(@post, @comment)
    end
  end


  def destroy
        @comment = Comment.find_by(id: params[:id])
        @post = @comment.post
        @topic = @post.topic

        if @comment.destroy
          redirect_to topic_post_comments_path(@topic , @post)
        end
      end


  private
  def comment_params
    params.require(:comment).permit(:body, :image)
    end
  end