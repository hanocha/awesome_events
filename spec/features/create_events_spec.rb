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
        before do
          fill_in 'event_name', with: 'testname'
          fill_in 'event_place', with: 'testplace'
          fill_in 'event_content', with: 'testcontent'
          select '2016', from: 'event_start_time_1i'
          select '6月', from: 'event_start_time_2i'
          select '6', from: 'event_start_time_3i'
          select '00', from: 'event_start_time_4i'
          select '00', from: 'event_start_time_5i'
          select '2017', from: 'event_end_time_1i'
          select '6月', from: 'event_end_time_2i'
          select '6', from: 'event_end_time_3i'
          select '00', from: 'event_end_time_4i'
          select '00', from: 'event_end_time_5i'
          click_button '作成'
        end

        it '登録したイベントの詳細ページに遷移すること' do
          expect(page).to have_content 'testname'
          expect(page).to have_content 'testplace'
          expect(page).to have_content 'testcontent'
          expect(page).to have_content '2016-06-06 00:00:00 +0900'
          expect(page).to have_content '2017-06-06 00:00:00 +0900'
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
