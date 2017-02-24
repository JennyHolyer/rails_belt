class UsersController < ApplicationController
  # before_action :check_status, :except => [:login_reg, :create_user, :login]
  def index
      render '/users/index'
  end

  def ideas
    @id = session[:user_id]
    @ideas = Idea.all
    # render json: @ideas
    @user = User.find(session[:user_id])
    @user_ideas = User.find(@id).ideas
    # @user_likes = Like.where(user: User.find(@id))
    @liked_ideas = Like.where(user: User.find(1))


    # Like.where(user: User.find(1)).first.idea.idea
    # @one_idea_liked_by_user = Like.where(user: User.find(@id)).first

    # render text: @one_idea_liked_by_user

    # render json: @user_likes[0].ideas

    # print @user
    render '/users/ideas'
  end

  def create_user
      user = User.create(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])

      if user.valid?
        session[:user_id] = user.id
        flash[:success] = "You have successfully signed up!"
        redirect_to "/ideas"
      else
        flash[:errors] = user.errors.full_messages
        redirect_to '/'
      end

    #     if user.valid?
    #      session[:user_id] = user[:id]
    #      flash[:notice] = "Successfully created..."
    #      redirect_to '/show'
      #
    #   else
    #       user.errors.full_messages
    #       render json: user.errors
    #     end
    end


      def login
       user = User.find_by_email(params[:email])

       if user && user.authenticate(params[:password])
         session[:user_id] = user.id
         flash[:success] = "You have successfully logged in!"

         redirect_to "/ideas"
       else
         flash[:errors] = "Your login credentials are incorrect!"
         # user.errors.full_messages
         redirect_to '/'
       end
   end



   def create_idea
     @id = session[:user_id]
     @idea = Idea.create(idea: params[:idea], user: User.find(@id))
     print @idea
     redirect_to "/ideas"
   end


   def delete

      @id = params[:id]

      Idea.find(@id).destroy

      redirect_to '/ideas'
    end


def user_profile
    @user = User.find(session[:user_id])
    @id = params[:id]
    @user = User.find(@id)
    @user_ideas_total = Idea.where(user: User.find(@id))
    @user_likes_total = Like.where(user: User.find(@id))
    render "/users/user_profile"

end



def detail
    @user = User.find(session[:user_id])
    @id = params[:id]
       @idea = Idea.find(@id)
       @users_who_like = Idea.find(@idea).likes
       render '/users/detail'


end



    def like_idea
    @idea_id = params[:id]
    like = Like.where(user: User.find(session[:user_id]), idea: Idea.find(@idea_id))
    if like.empty?
      Like.create(user: User.find(session[:user_id]), idea: Idea.find(@idea_id))
      flash[:success] = "Idea liked!"
      redirect_to '/ideas'
    else
      flash[:notice] = "You can't like an idea twice, bro!"
      redirect_to '/ideas'
    end
  end

  def unlike_idea
    unlike = Like.where(user: User.find(session[:user_id]), idea: Idea.find(params[:id])).destroy_all
    flash[:notice] = "Idea unliked!"
    redirect_to '/ideas'
  end

  def ideas_detail
    @id = params[:id]
    @idea = Idea.find(@id)
    @users_who_like = Idea.find(@idea).likes
    # render json: @users_who_like
    render '/users/ideas_detail'

  end




   def clearSession
          reset_session
          flash[:success] = "You have successfully logged out!"
          redirect_to '/'
       end


   # private
   #
   #  def check_status
   #    if !session[:user_id]
   #      redirect_to '/'
   #    end
   #  end


end
