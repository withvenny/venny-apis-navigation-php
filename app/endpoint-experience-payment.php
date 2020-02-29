<?php

// Set your secret key. Remember to switch to your live secret key in production!
// See your keys here: https://dashboard.stripe.com/account/apikeys
\Stripe\Stripe::setApiKey('sk_test_mTRBViwNmba7buxiOehiBZu400QVrwfzzN');

\Stripe\PaymentIntent::create([
  'amount' => 1000,
  'currency' => 'usd',
  'payment_method_types' => ['card'],
  'receipt_email' => 'jenny.rosen@example.com',
]);

$ch = \Stripe\Charge::retrieve(
    "ch_1GHJRGEp9b2l1tcUAcotCgom",
    ['api_key' => 'sk_test_mTRBViwNmba7buxiOehiBZu400QVrwfzzN'],
  );
  $ch->capture(); // Uses the same API Key.

$ch = \Stripe\Charge::retrieve(
    "ch_1GHJRGEp9b2l1tcUAcotCgom",
    ['stripe_account' => 'acct_1DaaWEEp9b2l1tcU'],
  );
  $ch->capture(); // Uses the same account.

  \Stripe\Charge::retrieve([
    'id' => 'ch_1GHJRGEp9b2l1tcUAcotCgom',
    'expand' => ['customer', 'invoice.subscription'],
  ]);

?>
