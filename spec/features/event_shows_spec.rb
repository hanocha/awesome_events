require 'rails_helper'

RSpec.feature "EventShows", type: :feature do
  describe 'ユーザがイベント詳細を閲覧する' do
    describe '正常系' do
      let(:sample_event) { create(:event) }
      before do
        visit event_path(sample_event.id)
      end

      context 'あるイベントの詳細にアクセスしたとき' do
        it '正しいイベント名が表示されていること' do
          expect(page).to have_content sample_event.name
        end

        it '正しい主催者が表示されていること' do
          binding.pry
          expect(page).to have_content sample_event.owner_id
        end

        it '正しい開催場所が表示されていること' do
          expect(page).to have_content sample_event.place
        end

        it '正しいイベント内容が表示されていること' do
          expect(page).to have_content sample_event.content
        end

        it '正しい開始/終了時刻が表示されていること' do
          expect(page).to have_content sample_event.start_time
          expect(page).to have_content sample_event.end_time
        end

        context '戻るボタンをクリックしたとき' do
          it 'イベント一覧ページに遷移すること' do
            expect(page.current_url).to eq events_path
          end
        end
      end
    end
  end
end
