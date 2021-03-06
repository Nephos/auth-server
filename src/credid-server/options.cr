require "option_parser"

module Credid::Server
  class Options
    property port : UInt16
    property ip : String
    property ssl : Bool
    property ssl_key_file : String
    property ssl_cert_file : String
    property users_file : String
    property groups_file : String
    property verbosity : Bool
    property password_cost : Int32
    property configure_root : Bool
    property configure_default_group : Bool
    property configure_and_exit : Bool

    def initialize
      @port = 8999_u16
      @ip = "127.0.0.1"
      @ssl = false
      @ssl_key_file = "private.key"
      @ssl_cert_file = "cert.pem"
      @users_file = "users.yaml"
      @password_cost = 11
      @groups_file = "groups.yaml"
      @verbosity = true
      @configure_root = false
      @configure_default_group = false
      @configure_and_exit = false
    end

    def parse!
      OptionParser.parse! do |parser|
        parser.banner = "Usage: auth-server <server-options>"
        parser.on("-p=PORT", "--port=PORT", "Specify the port to bind") { |port| @port = UInt16.new port }
        parser.on("-i=IP", "--ip=IP", "Specify the network interface") { |ip| @ip = ip }
        parser.on("-s", "--secure", "Enable SSL") { @ssl = true }
        parser.on("--ssl-key=FILE", "Specify the key file") { |key| @ssl_key_file = key }
        parser.on("--ssl-cert=FILE", "Specify the cert file") { |cert| @ssl_cert_file = cert }
        parser.on("-u=UFILE", "--users=FILE", "Specify the users database file") { |f| @users_file = f }
        parser.on("-a=AFILE", "--groups=FILE", "Specify the groups database file") { |f| @groups_file = f }
        parser.on("-q", "--quiet", "Disable verbosity") { |v| @verbosity = false }
        parser.on("--password-cost=COST", "The cost to decrypt each password (default 11)") { |cost| @password_cost = UInt8.new(cost).to_i }
        parser.on("--configure-root", "Configure the root user and exit") { @configure_root = true; @configure_and_exit = true }
        parser.on("--configure-default-group", "Configure the default group and exit") { @configure_default_group = true; @configure_and_exit = true }
        parser.on("-h", "--help", "Show this help") { puts parser; exit }
      end
      self
    end
  end
end
