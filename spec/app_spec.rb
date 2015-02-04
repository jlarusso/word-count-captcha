require "./spec/spec_helper"
require "json"
require "pry"

describe 'The Word Counting App' do
  describe "GET '/'" do
    it "returns 200 and has the right keys" do
      get '/'
      expect(last_response).to be_ok
      parsed_response = JSON.parse(last_response.body)
      expect(parsed_response).to have_key("text")
      expect(parsed_response).to have_key("excluded")
      expect(parsed_response).to have_key("text_token")
    end
  end

  describe "POST '/'" do
    it "responds with 200 if frequency count is correct" do
      post '/', params_correct
      expect(last_response).to be_ok
    end

    it "responds with 400 if frequency count is incorrect" do
      post '/', params_bad_token
      expect(last_response.status).to eq(400)
    end

    it "responds with 400 if token is incorrect" do
      post '/', params_bad_count
      expect(last_response.status).to eq(400)
    end
  end
end

describe Parser do
  describe "#excluded" do
    it "returns an empty array if @word_ary contains only one unique word" do
      text = "hello"
      p = Parser.new(text)
      expect(p.excluded).to be_empty
    end

    it "returns an non-random array of some words from @word_ary" do
      text = "The account had a pathetic quality.  A rough, cold android,"\
        " hoping to undergo an experience from which, due to a deliberate"\
        " defect, it remained excluded."

      p = Parser.new(text)
      excluded_ary = %w{ excluded to rough }
      expect(p.excluded).to eq(excluded_ary)
    end

    it "doesn't return duplicate words" do
      text = Array.new(21) { 'pie' }.join(' ')
      p = Parser.new(text)
      expect(p.excluded).to eq(['pie'])
    end
  end

  describe "#freq_count" do
    it "returns a hash count of all words in @word_ary" do
      text = "At three in the afternoon the following day they reached the"\
        " airfield at Des Moines.  Having landed the plane, the pilot"\
        " sauntered off for parts unknown, carrying his flask of gold flakes"\
        " with him.  With aching, cramped stiffness, Joe climbed from the"\
        " plane, stood for a time rubbing his numb legs, and then unsteadily"\
        " headed toward the airport office, as little of it as there was."

      p = Parser.new(text)
      freq_count_excluded_hash = p.freq_count_excluded
      p.excluded.each do |word|
        expect(freq_count_excluded_hash[word]).to be_nil
      end
    end
  end
end
