require 'rest-client'

class AirportService
  def initialize
    @base_url = 'https://myflightbook.com/logbook/OAuth/oAuthToken.aspx'
    @app_tokens = AppToken.instance
  end

  def visited
    refresh_token if app_tokens.mfb_token_expires_at - Time.now.to_i <= 60 * 60 * 24 * 2 # 2 days

    JSON.parse(RestClient.get(visited_url, params: params).body).map do |visited|
      visited['Code']
    end
  end

  private

  attr_accessor :app_tokens, :base_url

  def visited_url
    base_url + '/VisitedAirports'

  end

  def refresh_token
    json = JSON.parse(RestClient.post(base_url, post_params).body)

    app_tokens.update(mfb_token: json['access_token'],
                      mfb_refresh_token: json['refresh_token'],
                      mfb_token_expires_at: Time.now.to_i + json['expires_in'])
  end

  def params
    {
      access_token: app_tokens.mfb_token,
      json: 1
    }
  end

  def post_params
    {
      grant_type: 'refresh_token',
      refresh_token: app_tokens.mfb_refresh_token,
      client_id: app_tokens.mfb_client_id,
      client_secret: app_tokens.mfb_client_secret
    }
  end
end