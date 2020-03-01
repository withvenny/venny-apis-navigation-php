<?php

    //
    header('Content-Type: application/json');

    //
    \Stripe\Stripe::setApiKey('sk_test_mTRBViwNmba7buxiOehiBZu400QVrwfzzN');

    //
    switch ($_REQUEST['type']) {

        //
        case 'authentication':

            $ch = \Stripe\Charge::retrieve(
                $_REQUEST['charge'],
                ['api_key' => 'sk_test_mTRBViwNmba7buxiOehiBZu400QVrwfzzN']
            );
            $ch->capture(); // Uses the same API Key.

            echo $ch;

        //
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

        //
        case 'retrievetoken':
            
            $retrievetoken = \Stripe\Token::retrieve(
            $_REQUEST['token']
            );

            echo $retrievetoken;

            break;

        //
        case 'createCharge':

            // `source` is obtained with Stripe.js; see https://stripe.com/docs/payments/accept-a-payment-charges#web-create-token
            $createCharge = \Stripe\Charge::create([
            'amount' => 2000,
            'currency' => 'usd',
            'source' => 'tok_visa',
            'description' => 'My First Test Charge (created for API docs)',
            ]);

            echo $createCharge;

            break;

        //
        case 'retrieveCharge':

            $retrieveCharge = \Stripe\Charge::retrieve(
                $_REQUEST['charge']
            );

            
            echo $retrieveCharge;

            break;

        //
        case 'updateCharge':

            $updateCharge = \Stripe\Charge::update(
                $_REQUEST['charge'],
                ['metadata' => ['order_id' => $_REQUEST['order_id']]]
            );
            
            echo $updateCharge;

            break;

        //
        case 'captureCharge':

            $captureCharge = \Stripe\Charge::retrieve(
                $_REQUEST['charge']
            );
            $charge->capture();

            echo $captureCharge;

            break;

        //
        case 'listCharges':

            if(isset($_REQUEST['limit'])){$limit=$_REQUEST['limit'];}else{$limit=10;}
            if(isset($_REQUEST['customer_id'])){$customer_id=$_REQUEST['customer_id'];}else{$customer_id='cus_GpBMkNJMrtktdF';}

            $listCharges = \Stripe\Charge::all([
                'limit' => $limit,
                'customer' => $customer_id
            ]);

            echo $listCharges;

            break;

        //
        case 'createCustomer':

            //
            $customer = \Stripe\Customer::create([
                'email' => $_REQUEST['email'],
                'name' => $_REQUEST['name'],
                'description' => $_REQUEST['description']
            ]);

            echo $customer;

            break;

        //
        case 'retrieveCustomer':
            $retrieveCustomer = \Stripe\Customer::retrieve(
                $_REQUEST['customer_id']
            );

            echo $retrieveCustomer;

            break;

        //
        case 'createIntent':

            $intent = \Stripe\SetupIntent::create([
                //'customer' => $customer->id
                'customer' => $_REQUEST['customer_id'],
                'payment_method_types' => ['card'],
            ]);

            echo $intent;
            
            break;

        //
        case 'retrieveIntent':

            $retrieveIntent = \Stripe\SetupIntent::retrieve(
                $_REQUEST['intent_id']
            );

            echo $retrieveIntent;
            
            break;

        //
        case 'updateIntent':

            $updateIntent = \Stripe\SetupIntent::update(
                $_REQUEST['intent_id'],
                ['metadata' => ['user_id' => $_REQUEST['user_id']]]
            );

            echo $updateIntent;
            
            break;

        //
        case 'confirmIntent':

            //
            $setup_intent = \Stripe\SetupIntent::retrieve(
                $_REQUEST['intent_id']
            );
            
            //
            $setup_intent->confirm([
                'payment_method' => 'pm_card_visa',
            ]);

            echo $setup_intent;
            
            break;

        //
        case 'createPaymentIntent':

            if(isset($_REQUEST['amount'])){$amount=$_REQUEST['amount'];}else{$amount=8383;}
            if(isset($_REQUEST['customer_id'])){$customer_id=$_REQUEST['customer_id'];}else{$customer_id=8383;}
            if(isset($_REQUEST['off_session'])){$off_session=$_REQUEST['off_session'];}else{$off_session=true;}
            
            $createPaymentIntent = \Stripe\PaymentIntent::create([
                'amount' => $amount,
                'currency' => 'usd',
                'payment_method_types' => ['card'],
                'description' => 'Trying something interesting...',
                'customer' => $customer_id,
                //'off_session' => $off_session
            ]);

            echo $createPaymentIntent;
    
            break;

        //
        case 'retrievePaymentIntent':

            //
            $retrievePaymentIntent = \Stripe\PaymentIntent::retrieve(
                $_REQUEST['payment_intent']
            );

            echo $retrievePaymentIntent;
    
            break;

            //
        case 'updatePaymentIntent':

            //
            $updatePaymentIntent = \Stripe\PaymentIntent::update(
                $_REQUEST['payment_intent'],
                [
                    'metadata' => ['order_id' => '6735'],
                    'description' => 'This is the description of updating payment intent...',
                    'customer' => $_REQUEST['customer_id']
                ]
            );

            echo $updatePaymentIntent;
    
            break;

        //
        case 'confirmPaymentIntent':

            // To create a PaymentIntent for confirmation, see our guide at: https://stripe.com/docs/payments/payment-intents/creating-payment-intents#creating-for-automatic
            $payment_intent = \Stripe\PaymentIntent::retrieve(
                $_REQUEST['payment_intent']
            );
            $payment_intent->confirm([
                'payment_method' => $_REQUEST['card'],
            ]);

            echo $payment_intent;
        
            break;

        //
        case 'capturePaymentIntent':
            
            // To create a requires_capture PaymentIntent, see our guide at: https://stripe.com/docs/payments/capture-later
            $payment_intent = \Stripe\PaymentIntent::retrieve(
                $_REQUEST['payment_intent']
            );

            $payment_intent->capture();

            echo $payment_intent;

            break;

    }

?>