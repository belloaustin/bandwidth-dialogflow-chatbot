require 'rubygems'
require 'ruby-bandwidth'
require "google/cloud/dialogflow"
require 'sinatra'
require 'CGI'
require "securerandom"
require "json"
require 'zlib'

# Messaging Application using Google's Dialogflow and Bandwidth

$BANDWIDTH_USER_ID = ENV['BANDWIDTH_USER_ID'] || raise(StandardError, "Environmental variable BANDWIDTH_USER_ID needs to be defined")
$BANDWIDTH_API_TOKEN = ENV['BANDWIDTH_API_TOKEN'] || raise(StandardError, "Environmental variable BANDWIDTH_API_TOKEN needs to be defined")
$BANDWIDTH_API_SECRET = ENV['BANDWIDTH_API_SECRET'] || raise(StandardError, "Environmental variable BANDWIDTH_API_SECRET needs to be defined")
$BANDWIDTH_APPLICATION_ID = ENV['BANDWIDTH_APPLICATION_ID'] || raise(StandardError, "Environmental variable BANDWIDTH_APPLICATION_ID needs to be defined")
$GOOGLE_PROJECT_ID = ENV["GOOGLE_CLOUD_PROJECT"] || raise(StandardError, "Environmental variable GOOGLE_CLOUD_PROJECT needs to be defined")

# create a unique value for the combination of two numbers
def hash_function(to_num, from_num)
    hash = Zlib.crc32 [to_num, from_num].sort.join(",")
    return hash.to_s
end

# detects intent from a piece of text, and returns the fullfillment text
def detect_intent_text(project_id, session_id, text, language_code)

    session_client = Google::Cloud::Dialogflow::Sessions.new
    session = session_client.class.session_path project_id, session_id

    query_input = { text: { text: text, language_code: language_code } }
    response = session_client.detect_intent session, query_input
    query_result = response.query_result

    return query_result.fulfillment_text

end

bandwidth_client = Bandwidth::Client.new(:user_id => $BANDWIDTH_USER_ID, :api_token => $BANDWIDTH_API_TOKEN, :api_secret => $BANDWIDTH_API_SECRET)

# handle messages events from Bandwidth
post '/messages' do
    status 204 # successful request with no body content

    request_payload = JSON.parse(request.body.read)[0]

    if request_payload["type"] == "message-received"
        message = Bandwidth::V2::Message.create(bandwidth_client, {
            :from => request_payload["to"],
            :to => [request_payload["message"]["from"]],
            # session_id will be a unique value for two numbers using the hash function
            :text => detect_intent_text($GOOGLE_PROJECT_ID, hash_function(request_payload["to"], request_payload["message"]["from"]), request_payload["message"]["text"], "en-US"),
            :application_id => $BANDWIDTH_APPLICATION_ID}
            )

        return "success"
    end
end
