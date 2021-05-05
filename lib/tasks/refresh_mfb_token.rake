desc 'refresh the mfb token'
task refresh_mfb_token: :environment do
  AirportService.new.refresh_token
end