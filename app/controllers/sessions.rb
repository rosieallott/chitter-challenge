class Chitter < Sinatra::Base

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/sessions/new' do
    if user = User.authenticate(params[:email], params[:password])
      session[:user_id] = user.id
      redirect '/'
    else
      flash.now[:notice] = 'Email or password incorrect'
      erb :'sessions/new'
    end
  end

  delete '/sessions/sign_out' do
    session[:user_id] = nil
    flash[:notice] = 'Goodbye!'
    redirect '/'
  end
end
