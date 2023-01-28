require 'sinatra'
require 'sinatra/custom_logger'
require 'sinatra/reloader' if settings.development?
require 'dotenv/load' if settings.development?
require 'logger'
require 'slack'
require 'pry' if settings.development?

Dir['app/**/*.rb'].each { |file_path| require_relative file_path }

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
      client  = Slack::Web::Client.new

      case payload[:type]
      when 'shortcut' # Someone has openend the modal
        TaskCreateWorkflow.call(client: client, payload: payload)
      when 'view_submission' # Someone has submitted the modal
        TaskAssignmentWorkFlow.call(client: client, payload: payload)
      when 'block_actions' # Someone has completed a task
        TaskCompleteWorkflow.call(client: client, payload: payload)
      end
      200
    end

    # Use this to verify that your server is running and handling requests.
    get '/' do
      'Hello, world!'
    end
  end
end
