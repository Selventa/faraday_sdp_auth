# faraday_sdp_auth

This provides request middleware for Faraday to authenticate SDP URLs.

## Installation

```bash
gem install 'faraday_sdp_auth'
```

## Usage

Using [Faraday](https://github.com/lostisland/faraday) set up a connection
and configure an `:sdp_auth` middlware with your `api_key` and `private_key`.

```ruby
sdp_connection = Faraday.new 'https://your-sdp.selventa.com' do |conn|
  conn.request :sdp_auth,
    :api_key     => 'werner.brandes@toycompany.com',
    :private_key => 'my_voice_is_my_passport_verify_me'

  conn.adapter Faraday.default_adapter
end

sdp_conn.get '/api/knowledge-networks'
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
