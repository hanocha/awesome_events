require 'rails_helper'

RSpec.feature "EventShows", type: :feature do
  describe 'ユーザがイベント詳細を閲覧する' do
    describe '正常系' do
      context 'あるイベントの詳細にアクセスしたとき' do
        it '正しいイベント名が表示されていること' do
        end

        it '正しい主催者が表示されていること' do
        end

        it '正しい開催場所が表示されていること' do
        end

        it '正しいイベント内容が表示されていること' do
        end

        it '正しい開始/終了時刻が表示されていること' do
        end

        context '戻るボタンをクリックしたとき' do
          it 'イベント一覧ページに遷移すること' do
          end
        end
      end
    end
  end
end
