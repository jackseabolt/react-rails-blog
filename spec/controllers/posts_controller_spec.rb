require 'rails_helper'


describe PostsController do 
    it 'should return success response' do 
        get :index 
        expect(response).to have_http_status(200)
    end 

    it 'should return an array' do 
        FactoryGirl.create_list :post, 2
        get :index
        json = JSON.parse(response.body)
        pp json
        expect(json).to be_an_instance_of(Array)
    end 
end 