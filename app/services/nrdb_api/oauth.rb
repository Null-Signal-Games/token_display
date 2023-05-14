module NrdbApi
#oauth:
#  client_id: local_token_display
#  client_secret: jR4WXpLR0NX4XJ01EQ9Cv6041Ec2P7ak
#  redirect_uri: http://localhost:3400/show_token
  class Oauth
    def self.auth_uri
      URI(Rails.configuration.auth_login_url).tap do |uri|
        uri.query = {
          client_id: Rails.application.credentials.oauth[:client_id],
          redirect_uri: Rails.application.credentials.oauth[:redirect_uri],
          response_type: :code
        }.to_query
      end.to_s
    end

    def self.get_access_token(grant_code)
      Rails.logger.info(grant_token_uri(grant_code))
      JSON.parse(
        Faraday.post(grant_token_uri(grant_code), {
          client_id: Rails.application.credentials.oauth[:client_id],
          client_secret: Rails.application.credentials.oauth[:client_secret],
          redirect_uri: Rails.application.credentials.oauth[:redirect_uri],
          grant_type: :authorization_code,
          code: grant_code
        }).body
      ).with_indifferent_access
    end

    # TODO(plural):  Add support for refreshing tokens.

    private

    def self.grant_token_uri(code)
      URI(Rails.configuration.auth_token_url).tap do |uri|
        uri.query = {
          client_id: Rails.application.credentials.oauth[:client_id],
          client_secret: Rails.application.credentials.oauth[:client_secret],
          redirect_uri: Rails.application.credentials.oauth[:redirect_uri],
          grant_type: :authorization_code,
          code: code
        }.to_query
      end.to_s
    end
  end
end
