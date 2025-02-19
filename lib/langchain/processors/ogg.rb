# frozen_string_literal: true

module Langchain
  module Processors
    class Ogg < Base
      EXTENSIONS = [".ogg"]
      CONTENT_TYPES = ["audio/ogg"]

      def initialize(*)
        depends_on "ruby-openai", req: "openai"
      end

      # Transcribe the file and return the text
      # @param [File] data
      # @return [Array of Hash]
      def parse(data)
        transcribe(data)
      end

      private

      def transcribe(file)
        client = ::OpenAI::Client.new(access_token: ENV['OPENAI_API_TOKEN'])
        response = client.audio.transcribe(
          parameters: {
            model: "whisper-1",
            file: file
          }
        )
        response['text']
      end
    end
  end
end

