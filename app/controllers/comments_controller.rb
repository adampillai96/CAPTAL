class CommentsController < ApplicationController
    respond_to :js
    before_action :authenticate!, only: [:create, :edit, :update, :new, :destroy], except: [:index]

    def index
      @post = Post.includes(:comments).find_by(id: params[:post_id])
      @topic = @post.topic
      # @comments = @post.comments.order('created_at DESC')
      @comments = @post.comments
      @comment = Comment.new
    end


    def create
      @new_comment = Comment.new
      @post = Post.find_by(id: params[:post_id])
      @topic = @post.topic
      @comment = current_user.comments.build(comment_params.merge(post_id: params[:post_id]))

      if @comment.save
         CommentBroadcastJob.perform_later("create", @comment)
        flash.now[:success] = "You've created a new comment."
      else
        flash.now[:danger] = @comment.errors.full_messages
      end
    end

    def edit

        @comment = Comment.find_by(id: params[:id])
        @post = @comment.post
        @topic = @post.topic
        authorize @comment
    end

    def update
        @post = Post.find_by(id: params[:post_id])
        @topic = @post.topic
        @comment = Comment.find_by(id: params[:id])
        authorize @comment

        if @comment.update(comment_params)
            flash.now[:success] = "You've successfully updated your comment."

        else
            flash.now[:danger] = @comment.errors.full_messages

        end
    end

    def destroy
        @comment = Comment.find_by(id: params[:id])
        @post = @comment.post
        @topic = @post.topic
        authorize @comment

        if @comment.destroy
            flash.now[:success] = "You've successfully deleted your comment."
          else
              flash.now[:danger] = @comment.errors.full_messages
        end
        end

    private

    def comment_params
        params.require(:comment).permit(:body, :image)
    end
  end
