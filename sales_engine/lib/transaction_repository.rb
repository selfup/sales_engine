require_relative 'transaction'
require_relative 'all_repos'

class TransactionRepository
  include AllRepos

  attr_reader :repository, :sales_engine

  def initialize(rows, sales_engine)
    @repository   ||= load_transactions(rows)
    @sales_engine ||= sales_engine
  end

  def load_transactions(rows)
    @repository = Hash.new(0)
    rows.map { |row| @repository[row[:id].to_i] = Transaction.new(row, self) }
    @repository
  end

  def find_by_invoice_id(invoice_id)
    all.detect{|transaction| transaction.invoice_id == invoice_id}
  end

  def find_all_by_invoice_id(invoice_id)
    all.select{|transaction| transaction.invoice_id == invoice_id}
  end

  def find_by_credit_card_number(card_number)
    all.detect{|transaction| transaction.credit_card_number == card_number}
  end

  def find_all_by_credit_card_number(card_number)
    all.select{|transaction| transaction.credit_card_number == card_number}
  end

  def find_by_result(result)
    all.detect{|transaction| transaction.result == result}
  end

  def find_all_by_result(result)
    all.select{|transaction| transaction.result == result}
  end

  # def charge(payment_data, invoice_id)
  #   credit_card_number = payment_data[:credit_card_number]
  #   credit_card_expiration_date = payment_data[:credit_card_expiration_date]
  #   result = payment_data[:result]
  #   new_transaction = Transaction.new(
  #       {id: next_id,
  #        invoice_id: invoice_id,
  #        credit_card_number: credit_card_number,
  #        credit_card_expiration_date: credit_card_expiration_date,
  #        result: result,
  #        created_at: Time.now.strftime("%c %d, %Y"),
  #        updated_at: Time.now.strftime("%c %d, %Y")},
  #        self)
  #   records << new_transaction
  # end
  #
  # def next_id
  #   if records.last.nil?
  #     1
  #   else
  #     records.last.id.next
  #   end
  # end

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end

end
