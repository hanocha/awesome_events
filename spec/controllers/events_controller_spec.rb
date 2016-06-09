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

  describe 'GET #show' do
    describe '正常系' do
      context '存在するイベントを表示しようとしたとき' do
        before do
          created_event = create(:event)
          get :show, id: created_event.id
        end

        it 'ステータスコード200が返ること' do
          expect(response.status).to eq 200
        end

        it '指定したidのイベントが取得できること' do
          expect(event.id).to eq created_event.id
        end

        it 'showテンプレートがレンダリングされること' do
          expect(response).to render_template(:show)
        end
      end
    end

    describe '異常系' do
      context '存在しないイベントidを指定したとき' do
        it 'ステータスコード400が返ってくること' do
          expect(response.status).to eq 400
        end

        it 'イベント一覧ページにリダイレクトすること' do
          expect(response).to redirect_to(events_path)
        end

        it '「存在しないイベントです」というアラートを出すこと' do
          expect(session['flash']['flashes']['notice']).to eq '存在しないイベントです'
        end
      end
    end
  end

  describe 'POST #create' do
    describe '正常系' do
      before do
        user = create(:user)
        session[:user_id] = user.id
        post :create, event: attributes_for(:event)
      end

      context '有効なイベントを作成しようとしたとき' do
        it '#show にリダイレクトすること' do
          expect(response).to redirect_to event_path(assigns[:event])
        end

        it '#show で"作成しました"というメッセージを表示すること' do
          expect(session['flash']['flashes']['notice']).to eq '作成しました'
        end

        it 'データベースにイベントが追加されること' do
          created_event = Event.find(assigns[:event][:id])
          expect(created_event).to be_present
        end
      end
    end

    describe '異常系' do
      context '未ログインユーザがアクセスしたとき' do
        before { post :create }

        it 'トップページにリダイレクトすること' do
          expect(response).to redirect_to root_path
        end
      end

      context '不正なパラメータのイベントを作成しようとしたとき' do
        let(:invalid_event) { attributes_for(:event, :blank) }
        before do
          user = create(:user)
          session[:user_id] = user.id
        end

        it '#new を再描画すること' do
          post :create, event: invalid_event
          expect(response).to render_template :new
        end

        it 'ステータスコードとして400が返ってくること' do
          post :create, event: invalid_event
          expect(response.status).to eq 400
        end

        it 'イベントがデータベースに追加されていないこと' do
          expect{ post :create, event: invalid_event }.not_to change(Event, :count)
        end
      end
    end
  end
end
