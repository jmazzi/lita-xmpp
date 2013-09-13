require 'xmpp4r'

module Lita
  module Adapters
    # Usage:
    #
    # h = HtmlMessage.new
    # h.add_text = "Hi"
    #
    # Or:
    #
    # HtmlMessage.new { add_text "hi" }
    class HtmlMessage
      include ::Jabber
      attr_reader :body, :doc

      def initialize
        @doc  = REXML::Element::new("html")
        @body = REXML::Element::new("body")

        build

        yield(self) if block_given?
      end

      def message
        doc.add body
        doc
      end

      def add_text(str)
        text = REXML::Text.new("#{str}", false, nil, true, nil, %r/.^/)
        body.add text
      end

      def add_link(text, url)
        link = REXML::Element.new('a')
        link.add_attribute('href', url)
        link.text = text

        body.add link
      end

      private

      def build
        doc.add_namespace('http://jabber.org/protocol/xhtml-im')
        body.add_namespace('http://www.w3.org/1999/xhtml')
      end
    end
  end
end
