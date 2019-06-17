# Bandwidth Dialogflow Chatbot
Bandwidth Messaging application using Google Dialogflow to create an SMS chatbot.

<a href="http://dev.bandwidth.com"><img src="https://s3.amazonaws.com/bwdemos/BW_Messaging.png"/></a>

## Web Server using ngrok
Set up a basic Sinatra server for Bandwidth to send incoming message callbacks to. For this demo, you can simply use ngrok to expose your local development environment to the Internet. [Ngrok](https://ngrok.com/download) is free, and can be downloaded on all major operating systems. 

Once ngrok is downloaded, run ./ngrok http 4567 on the command line to open up a web server on Sinatra's default port of 4567. You should then see a screen with several pieces of information regarding your session. Take the `Forwarding` url that is secure (ex. https://some-letters-and-letters.ngrok.io) and hang onto it for later.

## Create a Bandwidth Application
Follow the instructions [here](https://dev.bandwidth.com/v2-messaging/applications/about.html) to create a Bandwidth Application and assign that application a Bandwith phone number. You can place the url for your ngrok server as the `Callback Url` for the application.

## Create a Google Dialogflow Agent
Follow the steps [here](https://dialogflow.com/docs/getting-started) to create a Google Dialogflow agent. If you don't want to build an agent from scratch, take advantage of the pre-built demo agents Google Dialogflow provides.

## How It Works
Before running the project, the following environmental variables need to be set:

```
BANDWIDTH_USER_ID
BANDWIDTH_API_TOKEN
BANDWIDTH_API_SECRET
BANDWIDTH_APPLICATION_ID
```

BANDWIDTH_USER_ID, BANDWIDTH_API_TOKEN, and BANDWIDTH_API_SECRET, BANDWIDTH_APPLICATION_ID can be found on your account on https://dashboard.bandwidth.com.

```
project_id
```

This is the Project ID of your Google Dialogflow agent.

Required dependencies can be installed by running the following command:

```
bundle install
```

To start the server, run the following command

```
ruby app.rb
```

Once running, text the Bandwidth phone number associated with your application to begin communicating with your Google Dialogflow agent.
