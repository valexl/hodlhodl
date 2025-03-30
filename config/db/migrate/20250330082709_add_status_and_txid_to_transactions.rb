# frozen_string_literal: true

ROM::SQL.migration do
  change do
    alter_table :transactions do
      add_column :status, String, default: "pending"
      add_column :txid, String
    end
  end
end