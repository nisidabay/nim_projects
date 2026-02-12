type
  CardDetails = object
    card: string
    serial_number: string

  PaypalDetails = object
    username: string
    password: string

  PaymentMethodType = object
    CreditCard: CardDetails
    DebitCard: CardDetails
    Paypal: PaypalDetails

let
  paypal = PaymentMethodType.Paypal(username: "bob@gmail.com",
      password: "Password")
  credit_card = PaymentMethodType.CreditCard(card: "Visa",
      serial_number: "1234")
  debit_card = PaymentMethodType.DebitCard(card: "OpenBank",
      serial_number: "2222")

echo paypal
echo credit_card
echo debit_card

