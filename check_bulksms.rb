#!/usr/bin/env ruby

require 'net/http'

EXIT_CODES = {
  :unknown => 3,
  :critical => 2,
  :warning => 1,
  :ok => 0
}

begin

  uri = URI('http://bulksms.vsms.net/eapi/user/get_credits/1/1.1')
  params = { :username => '', :password => '' } #changeme
  res = Net::HTTP.post_form(uri, params)
  body = res.body.strip
  if (body[0] != '0' and body[0] != 48); raise Exception, 'Error code returned: ' + body end
  remaining_credits = body.split('|')[1].to_f
  if (remaining_credits < 20) then #changeme
    puts 'CRIT: Insufficient credits remaining: ' + remaining_credits.to_s
    exit EXIT_CODES[:critical]
  end

rescue SystemExit
  raise

rescue Exception => e
  puts 'CRIT: Unexpected error: ' + e.message + ' <' + e.backtrace[0] + '>'
  exit EXIT_CODES[:critical]

end

puts 'OK: Sufficient credits remaining: ' + remaining_credits.to_s
exit EXIT_CODES[:ok]
