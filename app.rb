require 'sinatra'
require 'json'
require_relative 'my_user_model.rb'

class MyUserApp < Sinatra::Base
    configure do
        set :bind, '0.0.0.0'
        set :port, 8080
        enable :sessions
    end

    get '/' do
        @users = User.all()
        erb :index
    end

    get '/users' do
        content_type :json
        status 200
        users = User.all.map { |col| col.slice("firstname", "lastname", "age", "email") }
        users.to_json
    end

# Route pour se connecter (sign_in)
    post '/sign_in' do
        verify_user = User.authenticate(params[:password], params[:email])
        if !verify_user.empty?
            status 200
            # Simuler une session en renvoyant l'utilisateur (sans mot de passe)
            session[:user_id] = verify_user[0]["id"]
            verify_user[0].to_json
        else
            status 401 # Unauthorized
        end
    end

# Route pour mettre à jour le mot de passe d'un utilisateur connecté
    post '/users' do
        # Vérification de la session pour l'utilisateur connecté
        if params[:firstname] != nil
            create_user = User.create(params)
            new_user = User.find(create_user.id)
            user = {
                firstname: new_user.firstname,
                lastname: new_user.lastname,
                age: new_user.age,
                password: new_user.password,
                email: new_user.email
            }.to_json
        else
            check_user = User.authenticate(params[:password], params[:email])
            if !check_user[0].empty?
                session[:user_id] = check_user[0]["id"]
                status 200 
            else
                status 401
            end
            check_user[0].to_json
        end
    end

    put '/users' do
        User.update(session[:user_id], 'password', params[:password])
        user = User.find(session[:user_id])
        status 200
        user_info = {
            firstname: user.firstname,
            lastname: user.lastname,
            age: user.age,
            password: user.password,
            email: user.email
    }.to_json
    end

    # Route pour se déconnecter (sign_out)
    delete '/sign_out' do
        session[:user_id] = nil if session[:user_id]# Vide la session pour déconnecter l'utilisateur
        status 204 # No Content
    end

    # Route pour supprimez un utilisateur connecté
    delete '/users' do
        user_id = session[:user_id]
        halt 401, json({ message: 'Unauthorized' }) if user_id.nil?
        User.new.destroy(user_id)
        session.clear
        status 204
    end

    run! if app_file == $0
end

