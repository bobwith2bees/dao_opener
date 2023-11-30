# Get the project packages defined in package.json
npm install

# For local emulator testing install Firebase tools
# https://firebase.google.com/docs/functions/local-emulator
npm install -g firebase-tools

# Test locally e.g. http://127.0.0.1:5001/fifthpint-common-dev/us-central1/pass
npm run serve

# Deploy
firebase deploy --only functions:pass