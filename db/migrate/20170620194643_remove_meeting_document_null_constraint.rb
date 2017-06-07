class RemoveMeetingDocumentNullConstraint < ActiveRecord::Migration
  def change
    change_column_null(:meeting_documents, :document_id, true)
    add_column(:meeting_documents, :file_en, :string)
    add_column(:meeting_documents, :file_sv, :string)
  end
end
