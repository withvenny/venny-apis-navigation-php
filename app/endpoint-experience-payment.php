<?php

\Stripe\Stripe::setApiKey("sk_test_mTRBViwNmba7buxiOehiBZu400QVrwfzzN");

\Stripe\Charge::create([
  "amount" => 2000,
  "currency" => "usd",
  "source" => "tok_mastercard", // obtained with Stripe.js
  "metadata" => ["order_id" => "6735"]
]);

?>
