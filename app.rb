require "sinatra"
require "sinatra/reloader" if development?
require "json"

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

  if valid_params?(params)
    p = Parser.new(params[:text])

    # If tokens match
    if p.sha == params[:text_token]
      # If answers match
      if p.freq_count_excluded == param_to_hash(params[:freq_count_excluded])
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
  else
    status 400
    body 'Bad request'
  end
end

def valid_params?(params)
  params.has_key?('text_token') &&
    params.has_key?('text') &&
    !params['text'].empty?
end

def param_to_hash(hash)
  if hash
    hash.inject(hash) do |h, (k, str)|
      h[k] = str.to_i
      h
    end
  else
    {}
  end
end
