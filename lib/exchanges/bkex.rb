require "./lib/exchanges/base_exchange.rb"
require "./lib/redis_marshal.rb"
require "pry"

module Exchanges
  class Bkex < BaseExchange
    SPOT_TRADE_ENDPOINT = "https://www.bkex.com/trade/"
    API_ENDPOINT = "https://api.bkex.com"

    def price(coin_name)
      response = HttpAbstractor.get(ticket_url(coin_name))
      response.body["data"].first["price"]
    end

    def symbols
      response = HttpAbstractor.get(symbols_url)
      data = response.body["data"].select { |symbol| symbol["symbol"].index(default_currency) }
      data = data.map { |symbol| symbol["symbol"].gsub("#{symbol_prefix}#{default_currency}", "") }
      data.reject { |symbol| symbol.index("3L") || symbol.index("3S") || symbol.index("5L") || symbol.index("5S") || symbol.index("BULL") || symbol.index("BEAR")}
    end

    def spot_trade_url coin_name
      "#{SPOT_TRADE_ENDPOINT}#{symbol(coin_name)}"
    end

    def ignore_symbol? coin_name
      ["5CDP","AIOT","AZP","BCE","BHG","BITC","BKF","CKZ70","CMC","CTFTT","DATA","DCNT","DDD","DSC","DT","DTO","EDG","EDP","EIDOS","FM","GOT",
        "HEBE","HZT","JMC","LEND","LOOM","MED","MRL","NIUMC","NPXS","ODIN","OG","PCC","PGO","POLY","PROPS","QC","QRC","QWC","SBT","SFQJ","SNT","TED","TKC","TTJ","VCASH","VLX","VOKEN","ZEL","UFC","CMN",
        "AMPL","REP","PAMP","GEN","RLC","LID","DXD","ZAP","TRADE","PNK","REL","NMR","DNT","QKC","KEN","STAKE","RDN","2KEY","OMNI","JST","STRONG","AXIS","IDEX","LBA","SLINK","HAKKA","CVP","GON","CORN",
        "ANK","TAS","ULU","PFID","GOF","MOON","HGET","SAFE","BURGER","DIP","SUP","COLA","FIN","HBC","DIPS","HARD","KLP","NSURE","HEGIC","KP3R","VIDT","UNFI","ANRX","FIC","PSI","PHO","EDC","SIG","APYS",
        "INV","HOGE","HNTH","DRYCAKE","EQ","SBGO","LEMD","ARES","ORAO","GFX","DFD","GDT","HOKK","XDOGE","AQUAGOAT","TKINU","DOGEFATHER","EMAX","GINU","CLU","ACM","JUV","ASR","BARMY","ZOOT","HELMET",
        "sDOGE","GHOSTFACE","HODL","EMAX1","KOJI","GAL","TOKAU","GINUX","CATGE","CAVA","KEEP3L","KEEP3S","HTMOON","LET","OMT","FOX","REDFEG","HORD","ROCKI","ASAP","PKMON","CUSD","HUB","BIN","YAG",
        "DDX","BOND","UM","MOWA","DNFT","SIN","NU3L","NU3S","UBI","NFTB","POLX","WAI","PLAY","DOGEZILLA","DINGER","UFO1","TZKI","BLOCKS","AKAMARU","WOLVERINU","ZDC","NFTL","PIT","MXS","SCAR","SWCAT",
        "DOBO","GULL","HELIOS","NABOX","WOOL","BLWA","ELMON","WAG","WGMI","BABYWKD","BATMAN","CLIST","VVS","GP","NASADOGE","MAT","BKUSD","META","PLSPAD","RPS","XTime","FREE","TGT","NANO","CSHIP","ORKL",
        "RBXS","SILO","xDAI","DESO","TSHARE","DEPO","ACCEL","ASTRO","OXD","LQDR","APED","VRN","GYM","RIO","SGB","EXFI","PHAE","ITAMCUBE","aFLOOR","STACK","RND","FLAG","BIFA","KSP","USTC","LUNC", "TRU", "OSMO", "WTF", "BOT",
      "ZOO", "ATC", "RISE","DSG", "COVER", "FBX", "ACT", "BZRX", "PEX", "VOX", "LARIX", "ALEPH", "PMON","FLX", "NEC", "STRM", "REAL", "ISA", "QI", "HE", "LSP", "APN", "BABYDOGE"].include? coin_name
    end

    def currency_info coin_name
      data = RedisMarshal.fetch("bkex_all_currencys") do
        HttpAbstractor.get(currencys_url).body["data"]
      end

      data.find {|currency| currency["currency"] == coin_name}
    end

    def support_withdraw? coin_name
      currency_info(coin_name) && currency_info(coin_name)["supportWithdraw"]
    end

    def support_deposit? coin_name
      currency_info(coin_name) && currency_info(coin_name)["supportDeposit"]
    end

    def support_trade? coin_name
      currency_info(coin_name) && currency_info(coin_name)["supportTrade"]
    end

    def withdraw_fee coin_name, price
      (currency_info(coin_name)["withdrawFee"] * price).round(2)
    end

    private

    def ticket_url(coin_name)
      "#{API_ENDPOINT}/v2/q/ticker/price?symbol=#{symbol(coin_name)}"
    end

    def orderbook_url(coin_name)
      "#{API_ENDPOINT}/v2/q/deals?symbol=#{symbol(coin_name)}"
    end

    def symbols_url
      "#{API_ENDPOINT}/v2/common/symbols"
    end

    def currencys_url
      "#{API_ENDPOINT}/v2/common/currencys"
    end

    def symbol_prefix
      "_"
    end
  end
end
