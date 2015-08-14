#BitPay IPN logger
========================================
## Pre-Setup
1. If you are testing on a local machine bitpay server, please download, install, and run TinyProxy.
2. Run your local bitpay server.

## Configuration
1. Create a paired pem file by running the create_paired_pem.rb ruby script:
```
ruby lib/create_paired_pem.rb
```
Follow the instructions. Be sure to use the MERCHANT facade when paring.
2. Go into config/constants.rb and set your API_URI, ROOT_URL, and PEM_FILE_NAME. Make sure that your PEM_FILE_NAME is the same as the one you just created.

## Running
To run, cd into the root folder and run:
```
ruby main.rb
```
## Use
**Send all IPNs to /receive**
By default, the port that sinatra runs on is 4567. You may change the line in main.rb 'set :port 4567' to a different port.

If you would like to create a random invoice to pay for, you may run the create_random_invoice.rb script to generate a random invoice:
```
ruby lib/create_random_invoice.rb
```
You may pay for the invoice using your own wallet service.

## TODO
- Add UI create a global client starting in main.rb and save a global variable for keeping paired tokens. On / there should be a field where you can enter in your pairing code and automatically pair the app with the bitpay website. (this means proabably refactoring the entire app)
- Add UI to generate a random invoice given a price field, notification URL field,
    - Maybe add a script to automatically pay for an invoice (invoice generator idea)
- Add UI to automatically install, and run TinyProxy on the click of a button, or on start of the app.
    - Make sure that TinyProxy exits properly when Sinatra shuts down.
