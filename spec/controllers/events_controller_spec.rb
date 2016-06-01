require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe 'GET #new' do
    context '未ログインユーザがアクセスしたとき' do
      before { get :new }

      it 'トップページにリダイレクトすること' do
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'POST #create' do
    describe '正常系' do
      context '有効なイベントを作成しようとしたとき' do
        it '#show にリダイレクトすること' do
        end

        it 'notice を渡していること' do
        end
      end
    end

    describe '異常系' do
      context '無効なイベントを作成しようとしたとき' do
        it '#new に遷移すること' do
        end
      end
    end
  end
end
