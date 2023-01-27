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
      when 'view_submission' # Someone has submitted the modal
        author       = payload[:user]
        input_values = payload.dig(:view, :state, :values)
        assignees    = input_values.dig(:task_assignees, :task_assignees, :selected_users)

        assignees.each do |assignee_id|
          assignment = TaskAssignmentMessage.create(
            task:     input_values.dig(:task_description, :task_description, :value),
            author:   author,
          )

          channel_id = client.conversations_open(users: assignee_id).channel.id
          client.chat_postMessage(channel: channel_id, text: assignment)
        end
      200
    end

    # Use this to verify that your server is running and handling requests.
    get '/' do
      'Hello, world!'
    end
  end
end
