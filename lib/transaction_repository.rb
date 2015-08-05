require_relative 'transaction'

class TransactionRepository

  attr_reader :transactions

  def initialize(rows, sales_engine)
    @transactions  ||= load_transactions(rows)
    @sales_engine = sales_engine
  end

  def load_transactions(rows)
    @transactions = Hash.new(0)
    rows.map { |row| @transactions[row[:id]] = Transaction.new(row, self) }
    @transactions
  end

end
