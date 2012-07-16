class Writer
  def initialize(target)
    @target = target
  end
  
  def write(s)
    @target.write(s)
  end
end
