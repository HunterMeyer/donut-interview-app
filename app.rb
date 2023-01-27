require 'sinatra'
require 'sinatra/custom_logger'
require 'sinatra/reloader' if settings.development?
require 'dotenv/load' if settings.development?
require 'logger'
require 'slack'
require 'pry' if settings.development?
require_relative 'task_assignment_modal'
require_relative 'task_assignment_message'

Slack.configure do |config|
  config.token = ENV['SLACK_BOT_TOKEN']
end

module Donut
  class App < Sinatra::Base
    helpers Sinatra::CustomLogger

    ###
    #
    # Custom logging
    #
    ###
    def self.logger
      @logger ||= Logger.new(STDERR)
    end

    configure :development, :production do
      register Sinatra::Reloader
      set :logger, Donut::App.logger
    end

    ###
    #
    # Routes
    #
    ###
    post '/interactions' do
      payload = JSON.parse(params[:payload], symbolize_names: true)
      # Donut::App.logger.info "\n[+] Interaction type #{payload[:type]} recieved."
      # Donut::App.logger.info "\n[+] Payload:\n#{JSON.pretty_generate(payload)}"

      client = Slack::Web::Client.new

      case payload[:type]
      when 'shortcut' # Someone has openend the shortcut
        modal = TaskAssignmentModal.create(payload[:trigger_id])

        # views_push, views_open, views_publish, views_update
        client.views_open(modal)
      end
      200
    end

    # Use this to verify that your server is running and handling requests.
    get '/' do
      'Hello, world!'
    end
  end
end
