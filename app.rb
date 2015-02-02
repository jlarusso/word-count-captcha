require "sinatra"
require "sinatra/reloader" if development?

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
  source_text = Text.all.sample
  if source_text
    p = Parser.new(source_text)

    erb :"body.json", locals: { source_text: source_text, exclude: p.excludes }
  else
    erb :"error_no_text.json"
  end
end


# II.
# Receive request from client containing a text identifier and a frequency
# count of every word in the body of the text excluding words from the excludes
# list.
# Send response back to the client.
post '/' do
  puts "Here are the params: #{params}"
  erb :"answer.json"
end
