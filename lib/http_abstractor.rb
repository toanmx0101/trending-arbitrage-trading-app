require "net/http"
require "colorize"

class HttpAbstractor
  attr_reader :uri

  def initialize(url)
    raise "HttpAbstractor#initialize need a url" unless url

    url = url.to_s
    @uri = URI.parse(url)
    @http = Net::HTTP.new(@uri.host, @uri.port)
    @timeout = false

    if @uri.scheme.to_s == 'https'
      @http.use_ssl = true
      @http.ssl_version = :TLSv1_2
    end
  end

  def send_request(request)
    self.tap do |_self|
      begin
        @response = @http.request(request)
        self.class.log_response(@response)

      rescue Timeout::Error => e
        self.class.log_response("Timeout::Error - #{e.message}")
        @timeout = true
        return self
      end
    end
  end

  def body
    return @body if @body

    if success?
      @body = if @response.body
                JSON.parse(@response.body) rescue @response.body
              end
    end
  end

  def response
    @response
  end

  def code
    @response.code.to_i
  end

  def timeout?
    @timeout
  end

  def success?
    code == 200 || created?
  end

  def error?
    !success?
  end

  def created?
    code == 201
  end

  def not_found?
    code == 404
  end

  #######################
  #### CLASS METHODS ####
  #######################

  def self.post(url, params = {}, headers = {}, log_data = [])
    headers.merge!('Content-Type' => 'application/json') if headers['Content-Type'].blank?

    # write log
    log("POST", url, params, headers, log_data)

    send_request(url, params) do |uri, request_params|
      request = Net::HTTP::Post.new(uri.request_uri, headers)

      if request_params.is_a?(String)
        request.body = request_params
      else
        request.body = request_params.to_json
      end

      request
    end
  end

  def self.post_raw(url, params = {}, headers = {}, log_data = [])
    headers.merge!('Content-Type' => 'application/xml') unless headers['Content-Type']
    # write log
    log("POST_RAW", url, params, headers, log_data)

    send_request(url, params) do |uri, request_params|
      request = Net::HTTP::Post.new(uri.request_uri, headers)
      request.body = request_params.is_a?(String) ? request_params : URI.encode_www_form(request_params)
      request
    end
  end

  def self.get(url, params = {}, headers = {}, log_data = [])
    # write log
    log("GET", url, params, headers, log_data)

    send_request(url, params) do |uri, request_params|
      if request_params
        uri.query = uri.query ? "#{uri.query}&#{URI.encode_www_form(request_params)}" :URI.encode_www_form(request_params)
      end
      Net::HTTP::Get.new(uri.request_uri, headers)
    end
  end

  def self.put(url, params = {}, headers = {}, log_data = [])
    headers.merge!('Content-Type' => 'application/json') unless headers['Content-Type']

    # write log
    log("PUT", url, params, headers, log_data)

    send_request(url, params) do |uri, request_params|
      request = Net::HTTP::Put.new(
        uri.request_uri, headers
      )
      request.body = request_params.to_json
      request
    end
  end

  def self.delete(url, headers = {}, log_data = [])
    headers.merge!('Content-Type' => 'application/json') unless headers['Content-Type']

    # write log
    log("DELETE", url, {}, headers, log_data)

    send_request(url) do |uri|
      Net::HTTP::Delete.new(
        uri.request_uri, headers
      )
    end
  end

  def self.send_request(url, params = {})
    api = new(url)

    # call request method
    request = yield(api.uri, params)

    # start send request
    api.send_request(request)
  end

  def self.log(action, url, params, headers, log_data = [])
    domain = url.is_a?(URI) ? url.host : URI.parse(url).host.downcase
    @logger_info = {
      action: action, url: url, headers: headers, domain: domain,
      params: params, log_data: Array(log_data)
    }

    return if ENV["DISABLE_REQUEST_LOG"]
    puts "#{action}##{url} #{params} #{headers}".colorize(:yellow)
  end

  def self.sensitive_data_free(data)
    case data.class.to_s
    when 'String'
      # attempt to convert String to Hash
      data = JSON.parse(data) rescue data
      if data.is_a?(String)
        data
      else
        sensitive_data_free(data)
      end
    when 'Hash'
      # convert to a Hash with key is a String type
      data = JSON.parse(data.to_json)
      filter_sensitive_data_for_a_hash data
    when 'Array'
      # convert to an Array of Hashes with key is a String type
      data = JSON.parse(data.to_json)
      data.map { |item| filter_sensitive_data_for_a_hash(item) }
    else
      data
    end
  end

  def self.filter_sensitive_data_for_a_hash(data)
    return data unless data.is_a?(Hash)

    ['password', 'Authorization', 'token', 'access_token'].each do |key|
      data[key] = "*****" if data[key]
    end

    return data
  end

  def self.log_response(response)
    return if ENV["DISABLE_REQUEST_LOG"]
    # custom data
    @logger_info[:log_data].each { |data| puts data }

    # response data
    if response.is_a?(String)
      puts response.green
    else
      puts "RESPONSE - Code: #{response.code} - " \
           "Body: #{sensitive_data_free((response.body || "").force_encoding("UTF-8"))}".green
    end
  end

end
