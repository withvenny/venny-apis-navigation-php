<?php

    //
    header('Content-Type: application/json');

\Stripe\Stripe::setApiKey('sk_test_mTRBViwNmba7buxiOehiBZu400QVrwfzzN');

switch ($_REQUEST['type']) {

    case 'authentication':

        $ch = \Stripe\Charge::retrieve(
            "ch_1GHJRGEp9b2l1tcUAcotCgom",
            ['api_key' => 'sk_test_mTRBViwNmba7buxiOehiBZu400QVrwfzzN'],
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

        }

?>
