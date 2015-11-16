Sequel.migration do
  change do
    create_table(:groups) do
      primary_key :id
      String :group
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
