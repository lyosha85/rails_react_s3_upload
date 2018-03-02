class CreateDirectUploadUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|
      t.attachment :upload
      t.integer :status, default: 0, null: false
      t.string :direct_upload_url
      t.timestamps
    end
    add_index :documents, :status
  end
end
