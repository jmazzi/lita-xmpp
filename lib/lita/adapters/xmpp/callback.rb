module Lita
  module Adapters
    class Xmpp < Adapter
      class Callback
        attr_reader :robot, :roster

        def initialize(robot, roster)
          @robot = robot
          @roster = roster
          @start_time = Time.now.utc
        end

        def private_message(client)
          client.add_message_callback do |m|
            next if m.type == :error || m.body.nil?
            user = user_by_jid(m.from)
            source = Source.new(user)
            message = Message.new(robot, m.body, source)
            message.command!
            Lita.logger.debug("Dispatching PM to Lita from #{user.id}.")
            robot.receive(message)
          end
        end

        def muc_message(muc)
          muc.on_message do |time, nick, text|
            if time.is_a?(Time) && time < @start_time
              Lita.logger.debug "#{time} < #{@start_time} Skipping #{nick}: #{text}"
              next
            else
              user = user_by_name(nick)
              source = Source.new(user, muc.jid.bare.to_s)
              message = Message.new(robot, text, source)
              Lita.logger.debug(
                "Dispatching message to Lita from #{user.id} in MUC #{muc.jid}."
              )
              robot.receive(message)
            end
          end
        end

        def roster_update
          roster.add_update_callback do |old_item, item|
            jid = item.attributes["jid"]
            Lita.logger.debug("Updating record for user with ID: #{jid}.")
            create_user(item.attributes)
          end
        end

        private

        def jid_without_domain(jid)
          jid.to_s.sub(/@.*/, '')
        end

        def create_user(user_data)
          name = user_data['name'].downcase.gsub(/\s+/, '.')
          User.create(
            user_data["jid"],
            name: name,
            mention_name: jid_without_domain(user_data['jid'])
          )
        end

        def user_by_jid(jid)
          Lita.logger.debug("Looking up user with JID: #{jid}.")
          create_user(roster[jid].attributes)
        end

        def user_by_name(name)
          Lita.logger.info("Looking up user with name: #{name}.")
          items = roster.items.detect { |jid, item| jid_without_domain(jid) == name }

          if items
            Lita.logger.info("Looking up user by jid: #{items.first}.")
            user_by_jid(items.first)
          else
            Lita.logger.warn "No user with the name #{name.inspect} was found in the roster"
            User.new(nil, name: name)
          end
        end
      end
    end
  end
end
