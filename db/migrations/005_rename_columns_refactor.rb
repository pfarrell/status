Sequel.migration do
  change do
     alter_table(:groups){drop_column :group_id}
     alter_table(:statuses){rename_column :entry_id, :group_id}
  end
end
