module Validator
  def is_in_length?(value)
    value.length.in?(6..16)
  end

  def is_text_in_length?(value)
    value.length.in?(1..120)
  end

end