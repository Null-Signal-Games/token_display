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

    # TODO(plural): Pull the expiration time out of the JWT instead of this hack.  :)
    @token_expiration = Time.now + (@token_data['expires_in'].to_i).seconds
    @access_token = @token_data['access_token']
  end

end
