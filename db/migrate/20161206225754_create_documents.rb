class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string(:title_sv)
      t.string(:title_en)
      t.text(:description_sv)
      t.text(:description_en)
      t.integer(:category, default: -1, null: false, index: true)
      t.text(:file_sv)
      t.text(:file_en)
      t.date(:revision_date)
      t.timestamps(null: false)
    end
  end
end
