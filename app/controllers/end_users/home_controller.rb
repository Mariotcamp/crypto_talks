class EndUsers::HomeController < ApplicationController
  before_action :finished_log_in
  def index
     # 今回の場合 params[:id] => "btc"
    url = URI.parse("https://public.bitbank.cc/#{"btc"}_jpy/ticker")
    # response_textに返ってきた値が入る
    response_text = Net::HTTP.get(url)
    # response_textは文字列なのでパースしてハッシュに変換する
    response_hash = JSON.parse(response_text)
    @btc = response_hash['data']['sell']

    url = URI.parse("https://public.bitbank.cc/#{"eth"}_jpy/ticker")
    response_text = Net::HTTP.get(url)
    response_hash = JSON.parse(response_text)
    @eth = response_hash['data']['sell']

    url = URI.parse("https://public.bitbank.cc/#{"xrp"}_jpy/ticker")
    response_text = Net::HTTP.get(url)
    response_hash = JSON.parse(response_text)
    @xrp = response_hash['data']['sell']

    url = URI.parse("https://public.bitbank.cc/#{"mona"}_jpy/ticker")
    response_text = Net::HTTP.get(url)
    response_hash = JSON.parse(response_text)
    @mona = response_hash['data']['sell']

    url = URI.parse("https://public.bitbank.cc/#{"bcc"}_jpy/ticker")
    response_text = Net::HTTP.get(url)
    response_hash = JSON.parse(response_text)
    @bcc = response_hash['data']['sell']

  end
end
