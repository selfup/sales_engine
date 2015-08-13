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

  def charge(card_number, expiration, result, inv_id)
    id = @repository.values.length + 1
    data = {:id => id, :invoice_id => inv_id,
            :credit_card_number => card_number,
            :credit_card_expiration_date => expiration,
            :result => result, :created_at => Time.new().to_s,
            :updated_at => Time.new().to_s}
    @repository[id] = Transaction.new(data, self)
  end

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end

end
