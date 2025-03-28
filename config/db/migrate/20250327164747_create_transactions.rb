# frozen_string_literal: true

ROM::SQL.migration do
  # Add your migration here.
  #
  # See https://guides.hanamirb.org/v2.2/database/migrations/ for details.
  change do
    create_table :transactions do
      primary_key :id
      column :uid, String, null: false, unique: true
      column :amount_usdt, Integer, null: false
      column :recipient_address, String, null: false
      column :exchange_fee_btc, Float, null: false
      column :network_fee_btc, Float, null: false
      column :estimated_btc, Float, null: false
      column :rate_btc, Float, null: false
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
    add_index :transactions, :uid, unique: true
  end
end
