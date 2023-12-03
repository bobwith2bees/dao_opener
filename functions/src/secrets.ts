// Stolen from https://fireship.io/lessons/secret-manager-with-firebase/
//
// Checklist
// Enable Secrets
// Create Secret
// Assign service account Secrets Manager Accessor access
// fn-request-secret@fifthpint-common-dev.iam.gserviceaccount.com

import {HttpsError, onCall} from "firebase-functions/v2/https";
import {logger} from "firebase-functions";
import {SecretManagerServiceClient} from "@google-cloud/secret-manager";

//
// exports.requestSecret = getSecretValue;

const secrets = new SecretManagerServiceClient();
async function getSecretValue(secret: string, projectId: string) {
  // projects/80251260068/secrets/infuraIpfsApiKey/versions/1
  logger.info(`Attempting to read secret at projects/${projectId}/secrets/${secret}/versions/latest`);
  const [version] = await secrets.accessSecretVersion({
    name: `projects/${projectId}/secrets/${secret}/versions/latest`,
  });
  return version.payload?.data?.toString();
}

exports.requestSecret = onCall(
    {
      enforceAppCheck: false, // Reject requests with missing or invalid App Check tokens.
      consumeAppCheckToken: false, // Consume the token after verification.
    },
    (request) => {
      if (!request.auth) {
        logger.warn(`requestSecret called but no authentication available. request.auth: ${request.auth}`);
        throw new HttpsError("unauthenticated", "Request was not authenticated.",);
      }
      // Secret Name
      const secret: string = request.data.secret;
      // Google Project ID
      const projectId: string = request.data.projectId;
      if (!secret) {
        logger.warn("Request does not contain a resource. ${data}");
        throw new HttpsError(
            "invalid-argument",
            "Request missing proper arguments.",
        );
      }
      if (!projectId) {
        logger.warn("Request does not contain a projectId.");
        throw new HttpsError(
            "invalid-argument",
            "Request missing proper arguments.",
        );
      }

      return getSecretValue(secret, projectId);
    });

