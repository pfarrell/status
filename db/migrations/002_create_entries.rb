Sequel.migration do
  change do
    create_table(:entries) do
      primary_key :id
      Fixnum :group_id
      column :value, :json, default: Sequel.pg_json({})
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
