require_relative 'block_translator'

class VerifyTranslator < BlockTranslator
  def initialize(target, target2, block_size)

    # TODO: support dual targets

    @target = target
    @block_size = block_size
  end

  def read_block
    super
  end
  
  def write_block(s)
    super(s)
  end
end