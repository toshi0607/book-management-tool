class Form::Book < Book
  REGISTRABLE_ATTRIBUTES = %i(register title description genre memo)
  attr_accessor :register
end