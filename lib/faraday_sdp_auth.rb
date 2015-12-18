require 'faraday'
require 'faraday_sdp_auth/version'

module FaradaySdpAuth
  class SdpAuthMiddleware < Faraday::Middleware

    def initialize(app, options)
      super(app)
      @options = options
    end

    def call(env)
      # parse
      uri    = env[:url]
      params = CGI.parse(uri.query || '')

      # add auth params to url
      params[:ts]     = Time.now.to_i
      params[:apikey] = @options[:api_key]
      auth_uri       = uri.dup
      auth_uri.query = to_query(params)

      # compute hash of auth'd url
      hexdigest = OpenSSL::HMAC.hexdigest(
        OpenSSL::Digest.new('md5'), @options[:private_key], auth_uri.to_s
      )

      # add hash to auth'd url
      params[:hash] = hexdigest
      auth_uri.query = to_query(params)

      # set request url
      env[:url] = auth_uri

      # call the next middleware
      @app.call env
    end

    private

    def to_query(params)
      query=''
      params.each { |name, values|
        name   = CGI.escape(name.to_s)
        values = [values].flatten
        if values.size > 1
          values.each { |v|
            query << "#{name}=#{CGI.escape(v.to_s)}&"
          }
        else
          query << "#{name}=#{CGI.escape(values.first.to_s)}&"
        end
      }
      query.chomp('&')
    end
  end
end

Faraday::Request.register_middleware(
  :sdp_auth => lambda { FaradaySdpAuth::SdpAuthMiddleware }
)
