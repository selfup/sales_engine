  # nil
@customer_repository.customers["1"].updated_at
  # "2012-03-27 14:54:09 UTC"
@customer_repository.customers["2"].updated_at
  # "2012-03-27 14:54:10 UTC"
@customer_repository.customers["20"].updated_at
  # "2012-03-27 14:54:14 UTC"
@customer_repository.customers["20"].first_name
  # "Alessandra"
@customer_repository.customers["2"].first_name
  # "Cecelia"
