module Exceptions
  class RecipeBundleError < StandardError; end
  class OrderError < StandardError; end
  class PaymentError < StandardError; end
  class RecipeError < StandardError; end
  class NotFoundError < StandardError; end
end