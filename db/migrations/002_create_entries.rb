Sequel.migration do
  change do
    create_table(:entries) do
      primary_key :id
      Fixnum :group_id
      String :name
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
