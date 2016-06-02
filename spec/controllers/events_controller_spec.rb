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
      before do
        user = User.create(
          provider: 'twitter',
          uid: 'uid',
          nickname: 'nickname',
          image_url: 'http://example.jp/image.jpg'
        )
        session[:user_id] = user.id

        post :create, event: {
            name: 'testname',
            place: 'testplace',
            content: 'testcontent',
            start_time: end_time - 1.days,
            end_time: end_time
          }
      end
      let(:end_time) { Date.today }

      context '有効なイベントを作成しようとしたとき' do
        it '#show にリダイレクトすること' do
          expect(response).to redirect_to event_path(assigns[:event])
        end

        it 'notice を渡していること' do
          expect(session['flash']['flashes']['notice']).to eq '作成しました'
        end

        it 'データベースにイベントが追加されること' do
          created_event = Event.find(assigns[:event])
          expect(created_event).to be_present
        end
      end
    end

    describe '異常系' do
      context '未ログインユーザがアクセスしたとき' do
        before { post :create }

        it 'トップページにリダイレクトすること' do
          expect(response).to redirect_to(root_path)
        end
      end

      context '無効なイベントを作成しようとしたとき' do
        before do
          user = User.create(
            provider: 'twitter',
            uid: 'uid',
            nickname: 'nickname',
            image_url: 'http://example.jp/image.jpg'
          )
          session[:user_id] = user.id
        end

        it '#new を再描画すること' do
          post :create, event: {
            name: '',
            place: '',
            content: '',
            start_time: nil,
            end_time: nil
          }
          expect(response).to render_template :new
        end

        it 'ステータスコードとして400が返ってくること' do
          post :create, event: {
            name: '',
            place: '',
            content: '',
            start_time: nil,
            end_time: nil
          }
          expect(response.status).to eq 400
        end

        it 'イベントがデータベースに追加されていないこと' do
          expect{
            post :create, event: {
            name: '',
            place: '',
            content: '',
            start_time: nil,
            end_time: nil
            }
          }.not_to change(Event, :count)
        end
      end
    end
  end
end
