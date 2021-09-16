require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(title: '', content: 'テストNG')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: 'テストNG', content: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(title: 'テストOK', content: 'テストOK', expired_at: '2021-05-01 00:00:00')
        expect(task).to be_valid
      end
    end
  end

  describe '検索機能' do
    let!(:task) { FactoryBot.create(:task, title: 'task_check', expired_at: '2021-08-10 00:00:00', status: '完了') }
    let!(:second_task) { FactoryBot.create(:second_task, title: 'sample', expired_at: '2021-08-10 00:00:00', status: '着手中') }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.search_title('task_che')).to include(task)
        expect(Task.search_title('task_che')).not_to include(second_task)
        expect(Task.search_title('task_che').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.search_status('完了')).to include(task)
        expect(Task.search_status('完了').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.search_title('task_che')).to include(task)
        expect(Task.search_title('task_che')).not_to include(second_task)
        expect(Task.search_title('task_che').count).to eq 1
        expect(Task.search_status('完了')).to include(task)
        expect(Task.search_status('完了').count).to eq 1
      end
    end
  end
end
