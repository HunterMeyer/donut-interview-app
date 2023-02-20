# Slack Task App

## Create and Assign a Task
You can create a task by clicking the Dough (Beta) app from the Shortcuts menu.

You must enter a task description and one or more assignees

![Create a Task](/public/create-task.png)

## Completing a Task
Assignees will receive a DM from Dough (Beta) letting them know you have assigned them a task.

They can click the "Task Complete" button to indicate they have completed the task.

![Complete Task](/public/complete-task.gif)

You will be notified when the task is completed!

![Author Notice](/public/author-completion.png)

Enjoy 🍩

# Prerequisites

You will need three values necessary to configure your app.

`SLACK_BOT_TOKEN` - This is the token that will authenticate the requests you make to the Slack API.

`NGROK_AUTH` - This is the token that will allow you to use an ngrok tunnel with a persistent url.

`NGROK_SUBOMAIN` - This is the subdomain for the aforementioend persisent url.

# Running the App

Use the following command to run your app at http://localhost:4567/:

```sh
bundle exec rackup --host 0.0.0.0 -p 4567
```

Visit <http://localhost:4567/> to check that it's working.

In order for Slack to send requests to your locally running application, you need ngrok to open a tunnel.

First, we need to authenticate.

```sh
ngrok authtoken <your_ngrok_token_here>
```

This will persist, so you don't need to run it every time you want to open the tunnel.

Next, we have to open the tunnel:

```sh
ngrok http --subdomain=<your_ngrok_subdomain_here> 4567
```

Now, when you visit `https://<your_ngrok_subdomain_here>.ngrok.io`, or when Slack sends requests to it, the traffic will be routed to your locally running instance of this application.
