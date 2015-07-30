#BitPay IPN logger
========================================
## Pre-Setup
1. If you are testing on a local machine bitpay server, please download, install, and run TinyProxy.

## Configuration
1. Create a paired pem file by running the create_paired_pem.rb ruby script:
`ruby test/create_paired_pem.rb`
Follow the instructions. Be sure to use the MERCHANT facade when paring.
2. Go into config/constants.rb and set your API_URI, ROOT_URL, and PEM_FILE_NAME. Make sure that your PEM_FILE_NAME is the same as the one you just created.

## Running
To run, cd into the folder and run:
`ruby main.rb`
