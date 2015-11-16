Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id
      String :username
      String :email
      String :name
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
