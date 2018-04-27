require 'rails_helper'


describe PostsController do 
    describe 'index' do 

        before(:all) do
            FactoryGirl.create_list :post, 2
        end

        it 'should return success response' do 
            get :index 
            expect(response).to have_http_status(200)
        end 

        it 'should return an array of all posts' do 
            get :index
            body = JSON.parse(response.body)
            pp body
            expect(body).to be_an_instance_of(Array)
            expect(body.length).to eq(2)
            expect(body[0]["title"]).to eq("MyTitle")
            expect(body[0]["content"]).to eq("MyContent")
        end 
    end 
end 