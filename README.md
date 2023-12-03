# DAO Opener

A new Flutter project.

## Getting Started

FlutterFlow projects are built to run on the Flutter _stable_ release.

# IOS FlutterFlow issue
https://github.com/FlutterFlow/flutterflow-issues/issues/1766



# Creating a credential
DAOMembership
Schema: https://schema-builder.polygonid.me/schemas/60cdb980-55c2-4ee4-a6ca-9caad489cede
JSON-LD Context: ipfs://QmV2B1xLRUZfb2zLUg4xM3tVYJgUg1R9E7jGz6Hf6em2Ui
* Used in the proof requests
JSON schema URL: ipfs://QmeWR5QsDM3vSLLGryYH6shtYzCDYMPsLi3SiXGiuPHAmd
* Used to import into the issuer ui

## Import Credential Schema
* Navigate to https://issuer-ui.polygonid.me/schemas
* Import Scheme
* Url to Json Schema 
* * DAO Membership Schema URL: ipfs://QmeWR5QsDM3vSLLGryYH6shtYzCDYMPsLi3SiXGiuPHAmd
* * MembershipCredential -> Preview import -> Import (Duplicate error ok)

## Build Credential
* Navigate to https://ui.34.117.139.46.nip.io/schemas  (hosted https://issuer-ui.polygonid.me/schemas )
* Select DAOMembership
* * Spot check hash ed3d872056a5dbb516623dce8ddd26d9
* Issue Credential
* Direct issue (Selected by default)
* Paste did for wallet. 
* * e.g. did:polygonid:polygon:mumbai:2qGZqUP2LtnCubFS8MCF125qf67Kd8gkyWa4nU2qqu 
* Next Steps
* DAO name
** Mansplain DAO
* Is this person part of the DAO
* 1 (the number)
* Signature-based (SIG) should be selected by default
* Credential expiration (Leave alone)

# Load credential
* Navigate to https://issuer-ui.polygonid.me/credentials/issued
* Find the most recent credential with 1 day expiration
* * More Info
* Verify Issued to identifier is correct from above (did:polygonid:polygon:mumbai:2qGZqUP2LtnCubFS8MCF125qf67Kd8gkyWa4nU2qqu)
* Navigate using QR code Link

* On App 
* Navigate to Polygon Screen
* Tap QR code Scanner Button 
* Scan QR code
* * QR text will appear in the text box
* Tap Request credential button

# Verify Credential
* Navigate to https://verifier.polygonid.me/   (broken: https://verifier-demo.polygonid.me/  ) 
* Select Custom from the dropdown box
* Click Sign In button
* Circuit ID - Credential Atomic Signature (Default)
* URl (JSON-LD Context) ipfs://QmV2B1xLRUZfb2zLUg4xM3tVYJgUg1R9E7jGz6Hf6em2Ui
* Type: MembershipCredential
* Issuer: * 
* Field: PartOfTheDAO
* Operator: GT
* Value: 0
* To: did:polygonid:polygon:mumbai:2qGZqUP2LtnCubFS8MCF125qf67Kd8gkyWa4nU2qqu


{
"circuitId": "credentialAtomicQuerySigV2",
"id": 1701306738,
"query": {
"allowedIssuers": [
"*"
],
"context": "ipfs://QmV2B1xLRUZfb2zLUg4xM3tVYJgUg1R9E7jGz6Hf6em2Ui",
"credentialSubject": {
"PartOfTheDAO": {
"$gt": 0
}
},
"skipClaimRevocationCheck": true,
"type": "MembershipCredential"
}
}


authenticateCredential -
I/flutter (27812): {
I/flutter (27812):   "id": "c478f715-7bf1-4125-9e0b-dd43c3ece378",
I/flutter (27812):   "typ": "application/iden3comm-plain-json",
I/flutter (27812):   "type": "https://iden3-communication.io/authorization/1.0/request",
I/flutter (27812):   "thid": "c478f715-7bf1-4125-9e0b-dd43c3ece378",
I/flutter (27812):   "body": {
I/flutter (27812):     "callbackUrl": "https://self-hosted-demo-backend-platform.polygonid.me/api/callback?sessionId=474628",
I/flutter (27812):     "reason": "test flow",
I/flutter (27812):     "scope": [
I/flutter (27812):       {
I/flutter (27812):         "id": 10,
I/flutter (27812):         "circuitId": "credentialAtomicQuerySigV2",
I/flutter (27812):         "query": {
I/flutter (27812):           "allowedIssuers": [
I/flutter (27812):             "*"
I/flutter (27812):           ],
I/flutter (27812):           "context": "ipfs://QmV2B1xLRUZfb2zLUg4xM3tVYJgUg1R9E7jGz6Hf6em2Ui",
I/flutter (27812):           "credentialSubject": {
I/flutter (27812):             "PartOfTheDAO": {
I/flutter (27812):               "$gt": 0
I/flutter (27812):             }
I/flutter (27812):           },
I/flutter (27812):           "skipClaimRevocationCheck": true,
I/flutter (27812):           "type": "MembershipCredential"
I/flutter (27812):         }
I/flutter (27812):       }
I/flutter (27812):     ]
I/flutter (27812):   },
I/flutter (27812):   "from": "did:polygonid:polygon:mumbai:2qLhNLVmoQS7pQtpMeKHDqkTcENBZUj1nkZiRNPGgV",
I/flutter (27812):   "to": "did:polygonid:polygon:mumbai:2qGZqUP2LtnCubFS8MCF125qf67Kd8gkyWa4nU2qqu"
I/flutter (27812): }

Other Notes:
- Really need to have approved sets of tools that are known compatible.  Solution kits.   GCP lagging a month is a dealbreaker when things are moving fast.
- URL Schema vs LD Schema consistency across apps with error checking is a must.


# FlutterFlow Sync problems
* IOS losing config settings and requiringn workaround
* ImageNotification Signing Settings - select team from Xcode
* Build Phases reorder to avoid bug (Anything with Embed has to go before copy scripts)
* All the Firebase functions since their functions were too restrictive to use.


# Passkit Generator
* https://github.com/alexandercerutti/passkit-generator/tree/master/examples/firebase
