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

    it "responds with 400 if freq_count_excluded is missing" do
      post '/', params_missing
      expect(last_response.status).to eq(400)
    end

    it "responds with 400 if params are empty" do
      post '/', {}
      expect(last_response.status).to eq(400)
    end
  end

  describe "#param_to_hash" do
    it "converts keys to integers" do
      hash = param_to_hash({"hello" => "1"})
      expect(hash).to eq({"hello" => 1})
    end

    it "returns an empty hash if param is nil" do
      hash = param_to_hash(nil)
      expect(hash).to eq({})
    end
  end
end
