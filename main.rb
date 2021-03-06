require "sinatra"
require "sinatra/activerecord"
require "./models"
require "sinatra/flash"
# set :database, "sqlite3:test.sqlite3"
configure(:development) {set :database, "sqlite3:test.sqlite3"}
enable :sessions

get "/" do
	@users = User.all
    @posts = Post.all
    @user = User.find(session[:user_id]) if session[:user_id]
    @posts_user = @user.posts if session[:user_id]
    erb :index
end

post "/posts" do
    p params
    user = User.find(session[:user_id]) if session[:user_id]
    post = Post.create(title: params["title"],body: params["body"], user_id: session[:user_id])
    post.save
    redirect "/"

end

get "/posts/delete/:id" do
    post = Post.find(params[:id])
    post.destroy

    redirect "/"
end

get "/posts/:id" do
    @post = Post.find(params[:id])
    @user = User.find(session[:user_id]) if session[:user_id]
    @posts_user = @user.posts if session[:user_id]
    erb :post_show
end

get "/posts/edit/:id" do
    @post = Post.find(params[:id])
    erb :post_edit 
end


post "/posts/edit/:id" do
    post = Post.find(params[:id])
    post.title = params[:title]
    post.body = params[:body]
    post.save
    redirect "/posts/#{post.id}"
end

get "/sign_in" do
    erb :sign_in
end

get "/sign_out" do
    session.clear
    flash[:notice]="You are successfully logged out"
    redirect "/"    
end

get "/sign_up" do
    erb :sign_up
end

post "/sessions/create" do
    user = User.create(name: params[:name], email: params[:email], birthday: params[:birthday], password: params[:password])

    flash[:notice]="Thanks for signing up, please sign in"
    session[:user_id] = user.id if session[:user_id]
    # redirect "/sign_in"
    redirect "/profile/#{user.id}"
end

post "/sessions/new" do 
    user = User.where(email: params[:email]).first
    if user && user.password == params[:password]
        session[:user_id] = user.id
        # flash[:notice]="You are successfully signed in" 
        redirect "/"
    else 
        flash[:notice]="Incorrect information, please sign up if you are not a member"
        redirect "/sign_in"

    end  
end

get "/user_edit" do
    @user = User.find(session[:user_id]) if session[:user_id]
    erb :user_edit 
end

post "/sessions/edit" do
    @user = User.find(session[:user_id])
    @user.update_attributes(name: params[:name], email: params[:email], birthday: params[:birthday], password: params[:password])
    session[:user_id] = @user.id if session[:user_id]
    redirect "/profile/#{@user.id}"
end

get "/user_delete/:id" do
    @current_user = User.find(session[:user_id]) if session[:user_id]
    @posts_user = @current_user.posts

    # @posts_user.each do |post|
    #     post.destroy
    # end  

    @current_user.destroy
    session.clear
    redirect "/"
end

get "/profile/:id" do
    @choosen_user = User.find(params[:id]) if session[:user_id]
    @current_user = User.find(session[:user_id]) if session[:user_id]
    @posts_user = User.find(params[:id]).posts
    erb :profile_user
end


def current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
end 
