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

end
