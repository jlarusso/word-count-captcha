require "./spec/spec_helper"
require "./spec/params_helper"

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
