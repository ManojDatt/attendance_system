  require 'screencap'

  f = Screencap::Fetcher.new('http://google.com')
  screenshot = f.fetch(:output => './capture')

  p screenshot