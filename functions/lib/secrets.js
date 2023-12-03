"use strict";
// Stolen from https://fireship.io/lessons/secret-manager-with-firebase/
//
// Checklist
// Enable Secrets
// Create Secret
// Assign service account Secrets Manager Accessor access
// fn-request-secret@fifthpint-common-dev.iam.gserviceaccount.com
Object.defineProperty(exports, "__esModule", { value: true });
const https_1 = require("firebase-functions/v2/https");
const firebase_functions_1 = require("firebase-functions");
const secret_manager_1 = require("@google-cloud/secret-manager");
//
// exports.requestSecret = getSecretValue;
const secrets = new secret_manager_1.SecretManagerServiceClient();
async function getSecretValue(secret, projectId) {
    // projects/80251260068/secrets/infuraIpfsApiKey/versions/1
    firebase_functions_1.logger.info(`Attempting to read secret at projects/${projectId}/secrets/${secret}/versions/latest`);
    const [version] = await secrets.accessSecretVersion({
        name: `projects/${projectId}/secrets/${secret}/versions/latest`,
    });
    return version.payload?.data?.toString();
}
exports.requestSecret = (0, https_1.onCall)({
    enforceAppCheck: false,
    consumeAppCheckToken: false, // Consume the token after verification.
}, (request) => {
    if (!request.auth) {
        firebase_functions_1.logger.warn(`requestSecret called but no authentication available. request.auth: ${request.auth}`);
        throw new https_1.HttpsError("unauthenticated", "Request was not authenticated.");
    }
    // Secret Name
    const secret = request.data.secret;
    // Google Project ID
    const projectId = request.data.projectId;
    if (!secret) {
        firebase_functions_1.logger.warn("Request does not contain a resource. ${data}");
        throw new https_1.HttpsError("invalid-argument", "Request missing proper arguments.");
    }
    if (!projectId) {
        firebase_functions_1.logger.warn("Request does not contain a projectId.");
        throw new https_1.HttpsError("invalid-argument", "Request missing proper arguments.");
    }
    return getSecretValue(secret, projectId);
});
