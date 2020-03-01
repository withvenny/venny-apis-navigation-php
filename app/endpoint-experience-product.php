<?php

    //  
    header('Content-Type: application/json');

    //
    \Stripe\Stripe::setApiKey('sk_test_mTRBViwNmba7buxiOehiBZu400QVrwfzzN');

    //
    switch ($_REQUEST['function']) {

        //
        case 'createProduct':

            if(isset($_REQUEST['name'])){$name=$_REQUEST['name'];}else{$name='Venny Product';}
            if(isset($_REQUEST['type'])){$type=$_REQUEST['type'];}else{$type='good';}
            if(isset($_REQUEST['description'])){$description=$_REQUEST['description'];}else{$description='Another omfortable cotton t-shirt';}

            //
            $createProduct = \Stripe\Product::create([
                'name' => $name,
                'type' => $type,
                'description' => $description,
                'attributes' => ['size', 'gender'],
            ]);

            echo $createProduct;

            break;

        //
        case 'retrieveProduct':

            //
            $retrieveProduct = \Stripe\Product::retrieve(
                $_REQUEST['product_id']
            );

            echo $retrieveProduct;

            break;

    }

?>