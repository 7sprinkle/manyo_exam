require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:basic_user) { FactoryBot.create(:basic_user) }
  let!(:task) { FactoryBot.create(:task, user:basic_user) }
  let!(:second_task) { FactoryBot.create(:second_task, user: basic_user) }
  before do
    visit new_session_path
    fill_in 'session[email]', with: 'basic_email@gmail.com'
    fill_in 'session[password]', with:'basicuser'
    click_button 'ログイン'
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
      visit new_task_path
      fill_in 'task[title]', with: 'test_title'
      fill_in 'task[content]', with: 'test_content'
      fill_in 'task[expired_at]', with: '2021-08-11 00:00:00'.to_date
      find('.field_status').set('着手中')
      find('.field_priority').set('中')
      click_button '送信'
      expect(page).to have_content 'test_title'
      expect(page).to have_content 'test_content'
      expect(page).to have_content '着手中'
      expect(page).to have_content '中'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content 'test_title'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task = FactoryBot.create(:task, user:basic_user, title: 'new')
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'new'
      end
    end
    context 'タスクが終了期限の降順に並んでいる場合' do
      it '終了期限が遠いタスクが一番上に表示される' do
        task = FactoryBot.create(:task, user:basic_user, title: 'limit_far', expired_at:'2021-09-12 00:00:00')
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'limit_far'
      end
    end
    context '優先順位ソートというリンクを押した場合' do
      it '優先順位の高い順に並び替えられたタスク一覧が表示される' do
        task = FactoryBot.create(:task, user:basic_user, title: 'priority_high', priority:'高')
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'priority_high'
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        visit task_path(task.id)
        expect(page).to have_content 'test_title'
      end
    end
  end

  describe '検索機能' do
    before do
      FactoryBot.create(:task, user:basic_user, title: 'task')
      FactoryBot.create(:second_task, user:basic_user, title: 'sample')
      visit tasks_path
    end
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        fill_in 'search_title', with: 'task'
        click_button '検索'
        expect(page).to have_content 'task'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        select '未着手', from: 'search_status'
        click_button '検索'
        expect(page).to have_content '未着手'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        fill_in 'search_title', with: 'task'
        select '未着手', from: 'search_status'
        click_button '検索'
        expect(page).to have_content 'task'
        expect(page).to have_content '未着手'
      end
    end
  end
end