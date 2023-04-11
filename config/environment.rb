# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

ENV['JWT_SECRET']="ksmndlakmdl;an9312219312-491lksaasdwnpna;ind08h12p3;mkd"
ENV['TEST_TOKEN']="eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6ImFndW5nQGdtYWlsLmNvbSIsIm5hbWUiOiJBZ3VuZyBXaWpheWEiLCJ1c2VybmFtZSI6ImFndW5nLXciLCJpYXQiOjE2Nzc1MDU5NzR9.MsiORZAL-tJMIrqJIEYygQng2pKIY_b1Ez2nkPxDudQ"
ENV['ORDER_BASE_URL']="https://api.durianpay.id/v1/orders"
ENV['PAYMENT_BASE_URL']="https://links.durianpay.id/payment/"
ENV['DURIAN_PAY_API_KEY']="dp_test_EqPsPVqzAnjljVYp"