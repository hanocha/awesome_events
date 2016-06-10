require 'rails_helper'

RSpec.feature "CreateEvents", type: :feature do
  describe 'ユーザがイベントを新規登録する' do
    before do
      visit root_path
      click_link 'Twitterでログイン'
      visit new_event_path
    end

    describe '正常系' do
      context 'new_event_pathへアクセスしたとき' do
        it 'イベント新規登録画面が表示されること' do
          expect(page).to have_content 'イベントの新規作成'
        end
      end

      context 'イベントの登録に成功したとき' do
        let(:sample_event) { build(:event) }
        before do
          fill_in 'event_name', with: sample_event.name
          fill_in 'event_place', with: sample_event.place
          fill_in 'event_content', with: sample_event.content
          select sample_event.start_time.year, from: 'event_start_time_1i'
          select "#{sample_event.start_time.month}月", from: 'event_start_time_2i'
          select sample_event.start_time.day, from: 'event_start_time_3i'
          select sample_event.start_time.strftime("%H"), from: 'event_start_time_4i'
          select sample_event.start_time.strftime("%M"), from: 'event_start_time_5i'
          select sample_event.end_time.year, from: 'event_end_time_1i'
          select "#{sample_event.end_time.month}月", from: 'event_end_time_2i'
          select sample_event.end_time.day, from: 'event_end_time_3i'
          select sample_event.end_time.strftime("%H"), from: 'event_end_time_4i'
          select sample_event.end_time.strftime("%M"), from: 'event_end_time_5i'
          click_button '作成'
        end

        it '登録したイベントの詳細ページに遷移すること' do
          expect(page).to have_content sample_event.name
        end
      end
    end

    describe '異常系' do
      context 'イベントの登録に失敗したとき' do
        before do
          click_button '作成'
        end

        it 'エラーメッセージが表示されること' do
          expect(page).to have_content "名前を入力してください"
          expect(page).to have_content "場所を入力してください"
          expect(page).to have_content "内容を入力してください"
          expect(page).to have_content "開始時間は終了時間よりも前に設定してください"
        end
      end
    end
  end
end
