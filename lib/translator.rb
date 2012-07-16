class Translator
  def initialize(target)
    @target = target
  end
  
  def read
    @target.read
  end
  
  def write(s)
    @target.write(s)
  end
end
