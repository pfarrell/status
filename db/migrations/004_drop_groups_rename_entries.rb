Sequel.migration do
  change do
    drop_table(:groups)
    rename_table(:entries, :groups)
  end
end
