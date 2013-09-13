module Lita
  module Adapters
    module NotifyRoom
      def send_html_message_to_room(string, room)
        muc_domain = Lita.config.adapter.muc_domain
        target     = Source.new(nil, "#{room}@#{muc_domain}")
        adapter    = robot.instance_variable_get('@adapter')

        begin
          adapter.send_raw_messages(target, string)
        rescue => e
          puts e.backtrace.join("\n")
          puts :error
        end
      end

      def send_message_to_room(string, room)
        muc_domain = Lita.config.adapter.muc_domain
        target     = Source.new(nil, "#{room}@#{muc_domain}")
        robot.send_message(target, string)
      end

      def create_raw_message(string)
        message = Jabber::Message::new.set_type(:groupchat)
        message.add_element string
        message
      end
    end
  end
end
