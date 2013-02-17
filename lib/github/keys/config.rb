require 'singleton'
require 'yaml'

module Github
  module Keys
    class Config
      include Singleton

      SOURCE_FILES = %W(
        #{$HOME}/.github-keysrc
        ./.github-keysrc
      )

      def initialize
        @login = nil
        @password = nil

        load_configs
      end
      attr_accessor :login, :password

      def to_hash
        { :login => login, :password => password }
      end

      private
      def load_configs
        SOURCE_FILES.each do |path|
          load_config(path) if File.exists?(path)
        end
      end

      def load_config(path)
        yaml = YAML.load_file(path)
        return yaml unless yaml.is_a?(Hash)

        @login = yaml['login'] if yaml.has_key?('login')
        @password = yaml['password'] if yaml.has_key?('password')
      end
    end

    def self.config
      @config ||= Config.instance
    end
  end
end
