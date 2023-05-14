require 'jwt'

class HomeController < ApplicationController

  def index
    
  end

  def callback
    code = params.require(:code)
    token_data = NrdbApi::Oauth.get_access_token(code)
    redirect_to controller: 'home', action: 'show_token', token_data: token_data
  end

  def show_token
    token_param = params[:token_data]
    if not token_param
      return redirect_to controller: 'home', action: 'index'
    end

    @token_data = JSON.parse(token_param.to_json)
    @token_data_json = JSON.pretty_generate(@token_data)

    @access_token = @token_data['access_token']
    @refresh_token = @token_data['refresh_token']

    @decoded_access_token = JWT.decode @access_token, nil, false
    @decoded_access_token_json = JSON.pretty_generate(JSON.parse(@decoded_access_token.to_json))
  end

  def refresh_token
    refresh_token = params.require(:refresh_token)
    if not refresh_token
      return redirect_to controller: 'home', action: 'index'
    end 
    token_data = NrdbApi::Oauth.refresh_access_token(refresh_token)
    redirect_to controller: 'home', action: 'show_token', token_data: token_data
  end
end
