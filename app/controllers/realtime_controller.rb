class RealtimeController < ApplicationController

  def initial_subscription
    render :text => params['hub.challenge'] if params.include? 'hub.challenge'
    # http://www.retrojunkie.com/asciiart/animals/whales.htm
    render :text => %q{
               __   __
              __ \ / __
             /  \ | /  \
                 \|/
            _,.---v---._
   /\__/\  /            \
   \_  _/ /              \
     \ \_|           @ __|
      \                \_
       \     ,__/`      /
     ~~~`~~~~~~~~~~~~~~/~~~
Courtesy of http://www.retrojunkie.com/asciiart/animals/whales.htm
}
  end

  def handle_event
    # TODO: verify X-Hub-Signature header
    Instagram.process_subscription(params[:body]) do |handler|
      handler.on_geography_changed do |object_id, data|
        client = Instagram.client(:client_id =>
                           InstagramHeroku::Application.config.instagram_client_id,
                           :client_secret =>
                           InstagramHeroku::Application.config.instagram_client_secret)
        options = { :client_id =>
          InstagramHeroku::Application.config.instagram_client_id }
        if (min_id = GeoMinId.find_or_create_by_geo_id object_id).minid
          options[:min_id] = min_id
        else
          options[:count] = 1
        end

        data = client.geography_recent_media(object_id, options)

        min_id.update data
        Datum.store_all data
      end
    end
  end
end
