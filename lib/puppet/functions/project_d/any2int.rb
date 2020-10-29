Puppet::Functions.create_function(:'project_d::any2int') do
  dispatch :bool_to_int do
    param 'Boolean', :bool
  end
  dispatch :string_to_int do
    param 'String', :string
  end
  dispatch :int_to_int do
    param 'Integer', :integer
  end

  def bool_to_int(bool)
    bool ? 0 : 1
  end

  def string_to_int(string)
    string.to_i
  end

  def int_to_int(integer)
    integer
  end
end
