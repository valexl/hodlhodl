require "bitcoin"
require "dry/monads"

module Hodlhodl
  module UseCases
    module Transactions
      class BroadcastBtcTransaction
        include Deps[
          "gateways.mempool_gateway",
          "gateways.utxo_gateway"
        ]
        include Dry::Monads[:result]

        def call(recipient_address:, send_amount:, fee:, sender_address:, wif:)
          Bitcoin.chain_params = :signet unless Bitcoin.chain_params.network == :signet

          utxos = utxo_gateway.call(sender_address)
          return Failure(:no_utxo_available) if utxos.empty?

          utxo = utxos.first
          utxo_txid = utxo[:txid]
          utxo_vout = utxo[:vout]
          utxo_value = utxo[:value]

          change_amount = utxo_value - send_amount - fee
          return Failure(:invalid_tx) if change_amount < 0

          tx = build_unsigned_tx(recipient_address, send_amount, sender_address, change_amount, utxo_txid, utxo_vout)
          sign_tx!(tx, sender_address, utxo_value, wif)

          raw_tx_hex = tx.to_hex
          txid = tx.txid

          return Success(txid) if mempool_gateway.call(raw_tx_hex)

          Failure(:broadcast_failed)
        end

        private

        def build_unsigned_tx(recipient_address, send_amount, sender_address, change_amount, utxo_txid, utxo_vout)
          tx = Bitcoin::Tx.new
          outpoint = Bitcoin::OutPoint.from_txid(utxo_txid, utxo_vout)
          tx.in << Bitcoin::TxIn.new(out_point: outpoint)

          tx.out << Bitcoin::TxOut.new(
            value: send_amount,
            script_pubkey: Bitcoin::Script.parse_from_addr(recipient_address)
          )

          tx.out << Bitcoin::TxOut.new(
            value: change_amount,
            script_pubkey: Bitcoin::Script.parse_from_addr(sender_address)
          )

          tx
        end

        def sign_tx!(tx, sender_address, utxo_value, wif)
          key = Bitcoin::Key.from_wif(wif)
          script_pubkey = Bitcoin::Script.parse_from_addr(sender_address)

          sighash = tx.sighash_for_input(0, script_pubkey, sig_version: :witness_v0, amount: utxo_value)
          signature = key.sign(sighash) + [Bitcoin::SIGHASH_TYPE[:all]].pack("C")

          tx.in[0].script_witness.stack << signature
          tx.in[0].script_witness.stack << key.pubkey.htb
        end
      end
    end
  end
end
