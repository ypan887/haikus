require 'rails_helper'

describe "POST /tags", type: :request do
  let(:params) {{ haiku_id: 1, tag: "insightful" }}

  it "should create a tag with valid parameters" do
    post "/tags", params.merge({format: :json})
    response_body = JSON.parse(response.body)
    expect(response_body["haiku_id"]).to eq(1)
    expect(response_body["tag"]).to eq("insightful")
  end

  it "should not create a tag with missing data" do
    post "/tags", {haiku_id: 1}.merge({format: :json})
    expect(response.status).to eq(400)
    post "/tags", {tag: "tag only no id"}.merge({format: :json})
    expect(response.status).to eq(400)
    post "/tags", format: :json
    expect(response.status).to eq(400)
  end
end

describe "PATCH /tags", type: :request do
  let(:tag) { FactoryGirl.create(:tag, haiku_id: 1, tag: "insightful") }

  it "should update a tag with valid parameters" do
    patch "/tags/#{tag.id}", {tag: "spiritual"}.merge({format: :json})
    tag.reload
    expect(tag.tag).to eq("spiritual")
  end

  it "should not update a tag with missing data" do
    patch "/tags/#{tag.id}", {tag: nil}.merge({format: :json})
    expect(response.status).to eq(400)
  end
end

describe "DELETE /tags", type: :request do
  let!(:tag) { FactoryGirl.create(:tag, haiku_id: 1, tag: "delete me") }

  it "should delete a tag" do
    count = Tag.count
    delete "/tags/#{tag.id}", format: :json
    expect(Tag.count).to eq(count - 1)
  end
end
