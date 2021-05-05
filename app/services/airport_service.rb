require 'rest-client'

class AirportService
  def initialize
    @base_url = 'https://myflightbook.com/logbook/OAuth/oAuthToken.aspx'
    @app_tokens = AppToken.instance
  end

  def visited
    JSON.parse(RestClient.get(visited_url, params: params).body).map do |visited|
      visited['Code']
    end
  end

  def refresh_token
    json = JSON.parse(RestClient.post(base_url, post_params).body)

    app_tokens.update(mfb_token: json['access_token'],
                      mfb_refresh_token: json['refresh_token'],
                      mfb_token_expires_at: Time.now.to_i + json['expires_in'])

    schedule_refresh_token_job
  end

  private

  attr_accessor :app_tokens, :base_url

  def visited_url
    base_url + '/VisitedAirports'
  end

  def schedule_refresh_token_job
    self.delay(run_at: 7.days.from_now).refresh_token
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