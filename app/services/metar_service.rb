require 'rest-client'
require 'csv'

class MetarService
  def initialize(icaos)
    @icaos = icaos.gsub(/\s+/, '')
    @url = 'https://aviationweather.gov/adds/dataserver_current/httpparam'
  end

  def call
    @response = RestClient.get(url, params: params)
    parse_response
  end

  private

  def params
    {
      dataSource: 'metars',
      requestType: 'retrieve',
      format: 'csv',
      mostRecentForEachStation: 'constraint',
      hoursBeforeNow: 1.25,
      stationString: icaos
    }
  end

  def sanitized_response
    response.lines.to_a[5..-1].join
  end

  def parse_response
    metars = {}

    CSV.parse(sanitized_response, headers: true) do |row|
      metars[row['station_id']] = row.to_h
    end

    metars
  end

  attr_reader :icaos, :response, :url
end