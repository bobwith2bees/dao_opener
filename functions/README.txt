# Get the project packages defined in package.json
npm install

# For local emulator testing install Firebase tools
# https://firebase.google.com/docs/functions/local-emulator
npm install -g firebase-tools

# Follow Passkit instructions for certificats and set them in functions/.env
* https://github.com/alexandercerutti/passkit-generator
* https://github.com/alexandercerutti/passkit-generator/wiki/Generating-Certificates
* see: https://github.com/alexandercerutti/passkit-generator/blob/master/examples/firebase/functions/.env

# Test locally e.g. http://127.0.0.1:5001/fifthpint-common-dev/us-central1/pass

* npm run serve

# Deploy
* firebase deploy --only functions:pass