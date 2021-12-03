require 'rails_helper'

RSpec.describe Api::V0::CoursesController, type: :controller do

  describe "POST create course" do
    it "expect course to be created" do
      attributes = {"course"=>{"name"=>"Hindi", "duration"=>"10", "tutors"=>[{"name"=>"tutor1", "qualification"=>"Btech"}, {"name"=>"tutor2", "qualification"=>"MCA"}]}}
      post :create, attributes
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["name"]).to eq("Hindi")
    end

    it "expect course to be created and not tutor data" do
      attributes = {"course"=>{"name"=>"Hindi", "duration"=>"10", "tutors"=>[{"name"=>nil, "qualification"=>"Btech"}]}}
      post :create, attributes
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)["errors"]).to eq("Check tutor details missing")
    end

    it "expect course not to be created" do
      FactoryGirl.create(:course, name: "Hindi")
      attributes = {"course"=>{"name"=>"Hindi", "duration"=>"10", "tutors"=>[{"name"=>nil, "qualification"=>"Btech"}, {"name"=>"tutor2", "qualification"=>"MCA"}]}}
      post :create, attributes
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)["errors"][0]).to eq("Name This course already exists!")
    end
  end

	describe "GET index" do
    it "expect all courses with their tutors" do
    	4.times do 
    		FactoryGirl.create(:course)
    	end
      get :index
      expect(JSON.parse(response.body).length).to eq(4)
      expect(response).to have_http_status(:ok)
    end
    it "expect no courses" do
      get :index
      expect(JSON.parse(response.body).length).to eq(0)
      expect(response).to have_http_status(:ok)
    end
  end  
end
