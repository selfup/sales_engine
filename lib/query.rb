module Query

  def all
    @repository.values
  end

  def random
    @repository.values.sample
  end

  def find_by_id(id)
    @repository[id]
  end

  def find_by_merchant_name(name)
  end

  def find_by_first_name(name)
    customer = all.select{|value| value.first_name.downcase == name.downcase}
    customer[0]
  end

  def find_by_last_name(name)
    customer = all.select{|value| value.last_name.downcase == name.downcase}
    customer[0]
  end

end
