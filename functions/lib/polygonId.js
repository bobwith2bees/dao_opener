"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const tslib_1 = require("tslib");
const https_1 = require("firebase-functions/v2/https");
const firebase_functions_1 = require("firebase-functions");
const js_iden3_auth_1 = require("@iden3/js-iden3-auth");
// import {Verifier} from "@iden3/js-iden3-auth/dist/types/auth/auth";
const js_jsonld_merklization_1 = require("@iden3/js-jsonld-merklization");
const node_path_1 = tslib_1.__importDefault(require("node:path"));
/// Polygon Verification Begin
const ethStateResolver = new js_iden3_auth_1.resolver.EthStateResolver(process.env.WEB3_RPC_URL, process.env.POLYGON_ID_VERIFIER_CONTRACT);
const resolvers = {
    ['polygon:mumbai']: ethStateResolver,
};
const schemaLoader = (0, js_jsonld_merklization_1.getDocumentLoader)({
    ipfsNodeURL: process.env.IPFS_URL,
});
//Polygon Verification
// Standard Firebase Function call
exports.generateProofRequest = (0, https_1.onCall)({
    enforceAppCheck: false,
    consumeAppCheckToken: false, // Consume the token after verification.
}, (request) => {
    if (!request.auth) {
        firebase_functions_1.logger.warn(`generateProofRequest called but no authentication available. request.auth: ${request.auth}`);
        //throw new HttpsError("unauthenticated", "Request was not authenticated.",);
    }
    // Define the arguments
    const type = request.data.type ?? "MembershipCredential";
    const ldContext = request.data.ldContext ?? "ipfs://QmV2B1xLRUZfb2zLUg4xM3tVYJgUg1R9E7jGz6Hf6em2Ui";
    const sender = request.data.sender;
    const sessionId = request.data.sessionId ?? "1";
    const circuitId = request.data.circuitId ?? "credentialAtomicQuerySigV2";
    // Spot chech the arguments and log warnings for now
    if (!request.data.type) {
        firebase_functions_1.logger.warn("Request does not contain a credential schema type. ${data}");
        //         throw new HttpsError(
        //             "invalid-argument",
        //             "Request missing proper arguments.",
        //         );
    }
    if (!request.data.ldContext) {
        firebase_functions_1.logger.warn("Request does not contain a JSON-LD context in ldContext.");
    }
    if (!request.data.sessionId) {
        firebase_functions_1.logger.warn("Request does not contain a session id in sessionId.");
    }
    firebase_functions_1.logger.info(`generateProofRequest - type ${type}, ldContext: ${ldContext}, sender ${sender}, circuitId ${circuitId}, sessionId: ${sessionId}`);
    const authRequest = js_iden3_auth_1.auth.createAuthorizationRequestWithMessage('test flow', // reason
    'Prove your membership in a DAO', // message
    sender, // sender
    'http://example.com/callback?sessionId=${sessionId}');
    const proofRequest = {
        id: 1,
        circuitId: circuitId,
        query: {
            allowedIssuers: ['*'],
            context: ldContext,
            credentialSubject: {
                PartOfTheDAO: {
                    $gt: 0,
                },
            },
            skipClaimRevocationCheck: true,
            type: type,
        },
    };
    // authRequest.body.scope = [...scope, proofRequest];
    authRequest.body.scope = [proofRequest];
    // Write your code above!
    firebase_functions_1.logger.info(`generateProofRequest - ${authRequest}`);
    return authRequest;
});
// Standard Firebase Function call
exports.verifyAuthResponse = (0, https_1.onCall)({
    enforceAppCheck: false,
    consumeAppCheckToken: false, // Consume the token after verification.
}, async (request) => {
    if (!request.auth) {
        firebase_functions_1.logger.warn(`verifyAuthResponse called but no authentication available. request.auth: ${request.auth}`);
        //throw new HttpsError("unauthenticated", "Request was not authenticated.",);
    }
    // Define the arguments
    const authRequest = request.data.authRequest;
    const tokenStr = request.data.tokenStr;
    // Spot check the arguments and log warnings for now
    if (!request.data.authRequest) {
        firebase_functions_1.logger.warn("Request does not contain the original authRequest (workaround)");
        //         throw new HttpsError(
        //             "invalid-argument",
        //             "Request missing proper arguments.",
        //         );
    }
    if (!request.data.tokenStr) {
        firebase_functions_1.logger.warn("Request does not contain the tokenStr");
    }
    firebase_functions_1.logger.info(`verifyAuthResponse - authRequest ${authRequest}, \ntokenStr: ${tokenStr}`);
    // DevNote This is not cost efficient.
    firebase_functions_1.logger.info(`verifyAuthResponse - create verifier instance`);
    const verifier = await js_iden3_auth_1.auth.Verifier.newVerifier({
        stateResolver: resolvers,
        circuitsDir: node_path_1.default.join(__dirname, './testdata'),
        documentLoader: schemaLoader
    });
    firebase_functions_1.logger.info(`verifyAuthResponse - call FullVerify`);
    let authResponse;
    authResponse = await verifier.fullVerify(tokenStr, authRequest);
    firebase_functions_1.logger.info(`verifyAuthResponse - ${authRequest}`);
    return authRequest;
});
