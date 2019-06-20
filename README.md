# Bandwidth Dialogflow Chatbot
Bandwidth Messaging application using Google Dialogflow to create an SMS chatbot.

<a href="http://dev.bandwidth.com"><img src="https://s3.amazonaws.com/bwdemos/BW_Messaging.png"/></a>

## How It Works
When an incoming message is received by a Bandwidth number, a notification will be sent your application via a callback or webhook. Your application can then take the text from the body of that message and communicate with the NLU API of your choice to have a response created. From there, your application would take that response and send it in a message back to your customer.

This code builds on top of Bandwidth's Ruby SDK [Send SMS](https://github.com/Bandwidth/ruby-bandwidth#messaging-20){:target="_blank"} and Google Dialogflow's [detect intent texts](https://github.com/GoogleCloudPlatform/ruby-docs-samples/blob/master/dialogflow/detect_intent_texts.rb){:target="_blank"}.

One key detail to point out is the concept of a `session_id`. This is a unique value that Google Dialogflow uses to be able to map a new text to the right conversation and create a seamless dialog with your user. For this demo, the session_id is a hash value created from a concatentated sorted list of your Bandwidth number and the number texting the application. 

## Web Server using ngrok
Set up a basic Sinatra server for Bandwidth to send incoming message callbacks to. For this demo, you can simply use ngrok to expose your local development environment to the Internet. [Ngrok](https://ngrok.com/download){:target="_blank"} is free, and can be downloaded on all major operating systems. 

Once ngrok is downloaded, run ./ngrok http 4567 on the command line to open up a web server on Sinatra's default port of 4567. You should then see a screen with several pieces of information regarding your session. Take the `Forwarding` url that is secure (ex. https://some-letters-and-letters.ngrok.io) and hang onto it for later.

## Create a Bandwidth Application
Follow the instructions [here](https://dev.bandwidth.com/v2-messaging/applications/about.html){:target="_blank"} to create a Bandwidth Application and assign that application a Bandwith phone number. You can place the url for your ngrok server as the `Callback Url` for the application.

## Create a Google Dialogflow Agent
Follow the steps [here](https://dialogflow.com/docs/getting-started){:target="_blank"} to create a Google Dialogflow agent. If you don't want to build an agent from scratch, take advantage of the pre-built demo agents Google Dialogflow provides.

## Setup
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
