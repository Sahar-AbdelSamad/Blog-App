require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET #index' do
    before(:each) { get '/users/:user_id/posts' } # get(:index)
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end
    it "renders 'index' template" do
      expect(response).to render_template('index')
    end
    it 'includes the correct placeholder text' do
      expect(response.body).to include('Index Posts')
    end
  end

  describe 'GET #show' do
    before(:each) { get '/users/:user_id/posts/:id' } # get(:show)
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end
    it "renders 'show' template" do
      expect(response).to render_template('show')
    end
    it 'includes the correct placeholder text' do
      expect(response.body).to include('Show Posts')
    end
  end
end
