Sequel.migration do
  change do
    create_table(:statuses) do
      primary_key :id
      Fixnum :entry_id
      column :value, :json, default: Sequel.pg_json({})
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
