# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'development'
ENV['KARAFKA_ENV'] = ENV['RAILS_ENV']
require ::File.expand_path('../config/environment', __FILE__)
Rails.application.eager_load!

# This lines will make Karafka print to stdout like puma or unicorn
if Rails.env.development?
  Rails.logger.extend(
    ActiveSupport::Logger.broadcast(
      ActiveSupport::Logger.new($stdout)
    )
  )
end

class KarafkaApp < Karafka::App
  setup do |config|
    config.kafka.seed_brokers = %w[kafka://moped-01.srvs.cloudkafka.com:9094]
    config.client_id = 'example_app'
    config.batch_fetching = true
    config.batch_consuming = true
    config.logger = Rails.logger
    config.kafka.ssl_ca_cert_file_path = Rails.root.join("cloudkarafka.ca").to_s
    config.kafka.sasl_scram_username = "1jkft6j2"
    config.kafka.sasl_scram_password = "ng0oQ_7aP_oZ56U5qBfZ1cLYG9EAU2xg"
    config.kafka.sasl_scram_mechanism = "sha256"
    # config.shutdown_timeout = 5000
    config.kafka.max_wait_time = 20
    config.kafka.socket_timeout = 60
    # config.kafka.heartbeat_interval = 10
  end

  # Comment out this part if you are not using instrumentation and/or you are not
  # interested in logging events for certain environments. Since instrumentation
  # notifications add extra boilerplate, if you want to achieve max performance,
  # listen to only what you really need for given environment.
  Karafka.monitor.subscribe(WaterDrop::Instrumentation::StdoutListener.new)
  Karafka.monitor.subscribe(Karafka::Instrumentation::StdoutListener.new)
  Karafka.monitor.subscribe(Karafka::Instrumentation::ProctitleListener.new)

  # Uncomment that in order to achieve code reload in development mode
  # Be aware, that this might have some side-effects. Please refer to the wiki
  # for more details on benefits and downsides of the code reload in the
  # development mode
  #
  # Karafka.monitor.subscribe(
  #   Karafka::CodeReloader.new(
  #     *Rails.application.reloaders
  #   )
  # )

  consumer_groups.draw do
    topic "1jkft6j2-chats" do
      consumer ChatsConsumer
    end
    topic "1jkft6j2-messages" do
      consumer MessagesConsumer
    end
    # consumer_group :bigger_group do
    #   topic :test do
    #     consumer TestConsumer
    #   end
    #
    #   topic :test2 do
    #     consumer Test2Consumer
    #   end
    # end
  end
end

Karafka.monitor.subscribe('app.initialized') do
  # Put here all the things you want to do after the Karafka framework
  # initialization
end

KarafkaApp.boot!
