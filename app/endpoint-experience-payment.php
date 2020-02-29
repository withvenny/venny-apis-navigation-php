<?php

    //
    header('Content-Type: application/json');

\Stripe\Stripe::setApiKey('sk_test_mTRBViwNmba7buxiOehiBZu400QVrwfzzN');

\Stripe\Token::create([
  'card' => [
    'number' => $_REQUEST['card'],
    'exp_month' => 2,
    'exp_year' => 2021,
    'cvc' => '314',
  ],
]);

?>
