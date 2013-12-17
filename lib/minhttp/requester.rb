module MinHTTP
  class Requester
    attr_reader :url, :timeout, :transcript
    def initialize(url, options={})
      @url = url
      @timeout = (options[:timeout] || 5)
      @content_type = Mime::Type.lookup_by_extension(options[:content_type] || :xml)
      @transcript = ""
      @headers = (options[:headers] || {})
    end

    def post(body)
      Timeout::timeout(timeout) do
        uri = URI.parse(url)
        request = Net::HTTP::Post.new(uri.request_uri, {"Content-Type" => @content_type.to_s}.merge(@headers))
        request.body = body
        http = Net::HTTP.new(uri.host, uri.port)
        http.set_debug_output(transcript)
        if uri.scheme == "https"
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_PEER
        end
        response = http.start{|session| session.request(request)}
        if block_given?
          yield response
        else
          response.body
        end
      end
    end

    def options
      Timeout::timeout(timeout) do
        uri = URI.parse(url)
        request = FixedOptions.new(uri.request_uri, {"Content-Type" => @content_type.to_s}.merge(@headers))
        http = Net::HTTP.new(uri.host, uri.port)
        http.set_debug_output(transcript)
        if uri.scheme == "https"
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_PEER
        end
        response = http.start{|session| session.request(request)}
        if block_given?
          yield response
        else
          response.body
        end
      end
    end
  end

  class FixedOptions < Net::HTTPRequest
    METHOD = "OPTIONS"
    REQUEST_HAS_BODY = false
    RESPONSE_HAS_BODY = true
  end
end