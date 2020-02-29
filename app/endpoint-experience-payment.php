<?php

    //
    header('Content-Type: application/json');

\Stripe\Stripe::setApiKey('sk_test_mTRBViwNmba7buxiOehiBZu400QVrwfzzN');

switch ($_REQUEST['type']) {

    case 'authentication':

        $ch = \Stripe\Charge::retrieve(
            $_REQUEST['charge'],
            ['api_key' => 'sk_test_mTRBViwNmba7buxiOehiBZu400QVrwfzzN']
          );
          $ch->capture(); // Uses the same API Key.

          echo $ch;

    case 'token':
        $token = \Stripe\Token::create([
            'card' => [
            'number' => $_REQUEST['card'],
            'exp_month' => 2,
            'exp_year' => 2021,
            'cvc' => '314',
            ],
        ]);

        echo $token;

        break;

        case 'retrievetoken':
        $retrievetoken = \Stripe\Token::retrieve(
        $_REQUEST['token']
        );

        echo $retrievetoken;

        break;

    case 'charge':

        // `source` is obtained with Stripe.js; see https://stripe.com/docs/payments/accept-a-payment-charges#web-create-token
        $charge = \Stripe\Charge::create([
          'amount' => 2000,
          'currency' => 'usd',
          'source' => 'tok_visa',
          'description' => 'My First Test Charge (created for API docs)',
        ]);

        echo $charge;

        break;

    }

?>
