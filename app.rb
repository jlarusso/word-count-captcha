require 'sinatra'
require "sinatra/reloader" if development?

get '/' do
  files = %w(texts/0 texts/1 texts/2 texts/3 texts/4 texts/5)

  text_file = files.sample
  source_text = File.read(text_file).strip
  text_array = source_text.split

  # array with the last 5 words
  exclude = ((text_array.length-5)...(text_array.length)).map do |i|
    text_array[i]
  end

  erb :"get.json", locals: { source_text: source_text, exclude: exclude }
end
