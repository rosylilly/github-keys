require 'slop'
require 'github_api'

require 'github/keys'
require 'github/keys/config'

module Github
  module Keys
    class CLI
      def self.start
        Slop.parse(strict: true) do
          banner 'Usage: github-keys [options] name ...'

          on '-v', 'Print version' do
            puts "github-keys v#{Github::Keys::VERSION}"
            exit
          end

          on '-l', :login=, 'Github Username', as: String
          on '-p', :password=, 'Github Password Authenticate'

          on '-f', :file=, 'Save to'

          run do |opts, args|
            (puts banner; exit) if args.empty?

            CLI.new(opts).get_keys(*args)
          end
        end
      end

      def initialize(options = {})
        @config = Github::Keys.config
        @config.login = options[:login] if options[:login]
        @config.password = options[:password] if options[:password]

        @client = Github.new(@config.to_hash.merge(ssl: { verify: false }))

        @keys = ''

        @file = STDOUT
        if options[:file]
          @file = file = open(options[:file], 'w')
          at_exit do
            file.close
          end
        end
      end
      attr_reader :keys

      def get_keys(*usernames)
        usernames.each do |name|
          get_key(name)
        end

        @file.print keys
      end

      def get_key(name)
        user = @client.users.get(user: name)
        if user.type == 'Organization'
          get_org_keys(name)
        else
          get_user_keys(name)
        end
      end

      def get_org_keys(org)
        members = @client.orgs.members.list(org).map{|m| m[:login] }
        members.each do |member|
          get_user_keys(member)
        end
      end

      def get_user_keys(name)
        keys << connection.get("/#{name}.keys").body
      end

      private
      def connection
        @connection ||= Faraday.new(
          url: 'https://github.com',
          ssl: { verify: false }
        )
      end
    end
  end
end
