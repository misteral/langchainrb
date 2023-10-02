
module Langchain
  module Processors
    class OGG < ::Langchain::Processors::Base
      EXTENSIONS = [".ogg"]
      CONTENT_TYPES = ["audio/ogg"]

      def initialize
        depends_on "ruby-openai", req: "openai"
      end

      # Transcribe the file and return the text
      # @param [File] data
      # @return [Array of Hash]
      def parse(data)
        transcribe(data)
      end

      private

      def transcribe(file, open_ai_token)
        client = OpenAI::Client.new(access_token: open_ai_token)
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

