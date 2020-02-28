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

?>
