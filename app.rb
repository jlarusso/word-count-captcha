require "sinatra"
require "sinatra/reloader" if development?
require "json"
require 'pry'

require "./models/text"
require "./models/parser"


# Parse texts when app starts
Dir["texts/*"].each do |text_path|
  Text.add_from_path(text_path)
end


# I.
# Send a random body of text to the client with a list of some (but not all)
# words in that text
get '/' do
  content_type :json

  source_text = Text.all.sample
  if source_text
    p = Parser.new(source_text)

    { text: source_text, excluded: p.excluded, text_token: p.sha }.to_json
  else
    { error: "No texts found." }.to_json
  end
end


# II.
# Receive request from client containing a text identifier and a frequency
# count of every word in the body of the text excluding words from the excludes
# list.
# Send response back to the client.
post '/' do
  content_type :json

  # TODO: validate params
  # source_text = params[:text]
  # excluded = params[:excluded]
  # freq_count = params[:freq_count]

  p = Parser.new(params[:text])

  # If tokens match
  if p.sha == params[:text_token]
    # If answers match
    if p.freq_count_excluded == integerize_param(params[:freq_count_excluded])
      status 200
      body 'Ok'
    else
      status 400
      body 'Bad request'
    end
  else
    status 400
    body 'Bad token'
  end
end

def integerize_param(hash)
  new_hash = {}

  hash.keys.each do |key|
    new_hash[key] = hash[key].to_i
  end

  new_hash
end
