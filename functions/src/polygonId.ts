import {HttpsError, onCall} from "firebase-functions/v2/https";
import {logger} from "firebase-functions";
import {
  auth,
  resolver,
  protocol,
} from "@iden3/js-iden3-auth";
// import {Verifier} from "@iden3/js-iden3-auth/dist/types/auth/auth";
import { getDocumentLoader } from '@iden3/js-jsonld-merklization';
import path from "node:path";

/**
 * Declaring our .env contents
 * @see https://firebase.google.com/docs/functions/config-env?gen=2nd#deploying_multiple_sets_of_environment_variables
 */

declare global {
  namespace NodeJS {
    interface ProcessEnv {
      WWDR: string;
      SIGNER_CERT: string;
      SIGNER_KEY: string;
      SIGNER_KEY_PASSPHRASE: string;
      WEB3_RPC_URL: string;
      IPFS_URL: string;
      POLYGON_ID_VERIFIER_CONTRACT: string;

      // reserved, but we use it to discriminate emulator from deploy
      FUNCTIONS_EMULATOR: "true" | "false" | undefined;
    }
  }
}

/// Polygon Verification Begin
const ethStateResolver = new resolver.EthStateResolver(
  process.env.WEB3_RPC_URL,
  process.env.POLYGON_ID_VERIFIER_CONTRACT,
);

const resolvers: resolver.Resolvers = {
  ['polygon:mumbai']: ethStateResolver,
};

const schemaLoader = getDocumentLoader({
  ipfsNodeURL: process.env.IPFS_URL,
});

//Polygon Verification


// Standard Firebase Function call
exports.generateProofRequest = onCall(
  {
    enforceAppCheck: false, // Reject requests with missing or invalid App Check tokens.
    consumeAppCheckToken: false, // Consume the token after verification.
  },
  (request) => {
    if (!request.auth) {
      logger.warn(`generateProofRequest called but no authentication available. request.auth: ${request.auth}`);
      //throw new HttpsError("unauthenticated", "Request was not authenticated.",);
    }
    // Define the arguments
    const type = request.data.type ?? "MembershipCredential";
    const ldContext = request.data.ldContext ?? "ipfs://QmV2B1xLRUZfb2zLUg4xM3tVYJgUg1R9E7jGz6Hf6em2Ui";
    const sender = request.data.sender;
    const sessionId = request.data.sessionId ?? "1";
    const circuitId = request.data.circuitId ?? "credentialAtomicQuerySigV2"

    // Spot chech the arguments and log warnings for now
    if (!request.data.type) {
      logger.warn("Request does not contain a credential schema type. ${data}");
//         throw new HttpsError(
//             "invalid-argument",
//             "Request missing proper arguments.",
//         );
    }
    if (!request.data.ldContext) {
      logger.warn("Request does not contain a JSON-LD context in ldContext.");
    }
    if (!request.data.sessionId) {
      logger.warn("Request does not contain a session id in sessionId.");
    }

    logger.info(`generateProofRequest - type ${type}, ldContext: ${ldContext}, sender ${sender}, circuitId ${circuitId}, sessionId: ${sessionId}`);

    const authRequest = auth.createAuthorizationRequestWithMessage(
      'test flow', // reason
      'Prove your membership in a DAO', // message
      sender, // sender
      'http://example.com/callback?sessionId=${sessionId}', // callback url
    );

    const proofRequest: protocol.ZeroKnowledgeProofRequest = {
      id: 1,
      circuitId: circuitId,
      query: {
        allowedIssuers: ['*'],
        context: ldContext, // LD Context for schema
        credentialSubject: {
          PartOfTheDAO: {
            $gt: 0,
          },
        },
        skipClaimRevocationCheck : true,
        type: type,
      },
    };
    // authRequest.body.scope = [...scope, proofRequest];
    authRequest.body.scope = [proofRequest];
    // Write your code above!

    logger.info(`generateProofRequest - ${authRequest}`);
    return authRequest;
  }
);


// Standard Firebase Function call
exports.verifyAuthResponse = onCall(
  {
    enforceAppCheck: false, // Reject requests with missing or invalid App Check tokens.
    consumeAppCheckToken: false, // Consume the token after verification.
  },
  async (request) => {
    if (!request.auth) {
      logger.warn(`verifyAuthResponse called but no authentication available. request.auth: ${request.auth}`);
      //throw new HttpsError("unauthenticated", "Request was not authenticated.",);
    }
    // Define the arguments
    const authRequest = request.data.authRequest;
    const tokenStr = request.data.tokenStr;

    // Spot check the arguments and log warnings for now
    if (!request.data.authRequest) {
      logger.warn("Request does not contain the original authRequest (workaround)");
//         throw new HttpsError(
//             "invalid-argument",
//             "Request missing proper arguments.",
//         );
    }
    if (!request.data.tokenStr) {
      logger.warn("Request does not contain the tokenStr");
    }

    logger.info(`verifyAuthResponse - authRequest ${authRequest}, \ntokenStr: ${tokenStr}`);

    // DevNote This is not cost efficient.
    logger.info(`verifyAuthResponse - create verifier instance`);
    const verifier = await auth.Verifier.newVerifier({
        stateResolver: resolvers,
        circuitsDir: path.join(__dirname, './testdata'),
        documentLoader: schemaLoader
      }
    );

    logger.info(`verifyAuthResponse - call FullVerify`);
    let authResponse: protocol.AuthorizationResponseMessage;
    authResponse = await verifier.fullVerify(tokenStr, authRequest);

    logger.info(`verifyAuthResponse - ${authRequest}`);
    return authRequest;
  }
);