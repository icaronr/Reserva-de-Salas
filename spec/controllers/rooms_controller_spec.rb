require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
    # describe "PUT update/:id" do
    #   end
    describe "GET #edit" do
        context 'user.signed_in?' do
            before do 
                @user = FactoryBot.create(:user)
                sign_in @user
                @room = FactoryBot.create(:room)
            end
            it 'achar uma sala pra editar' do
                get :edit, params: {id: @room.id}
                expect(response.status).to eq(200) 
            end
        end
    end
    describe "POST #update" do
        let(:attr1) do { :name => 'new name', :location => 'new location' } end
        let(:attr2) do { :name => 'xx', :location => 'new location' } end
        before do
            @user = FactoryBot.create(:user)
            sign_in @user
            @room = FactoryBot.create(:room)
        end
        it 'deve editar a sala' do
            patch :update, params: {id: @room.id, room: attr1}
            expect(response.status).to eq(302) 
        end
        it 'nao deve editar a sala' do
            patch :update, params: {id: @room.id, room: attr2}
            expect(response.status).to eq(200) 
        end
    end
end
