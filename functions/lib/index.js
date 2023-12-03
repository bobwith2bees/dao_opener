"use strict";
// /**
//  * Import function triggers from their respective submodules:
//  *
//  * import {onCall} from "firebase-functions/v2/https";
//  * import {onDocumentWritten} from "firebase-functions/v2/firestore";
//  *
//  * See a full list of supported triggers at https://firebase.google.com/docs/functions
//  */
//
// // import {onRequest} from "firebase-functions/v2/https";
// // import * as logger from "firebase-functions/logger";
//
// // Start writing functions
// // https://firebase.google.com/docs/functions/typescript
//
// // export const helloWorld = onRequest((request, response) => {
// //   logger.info("Hello logs!", {structuredData: true});
// //   response.send("Hello from Firebase!");
// // });
//
// import {initializeApp} from "firebase-admin/app";
// const requestSecret = require("./secrets");
//
// // Export functions
// exports.requestSecret = requestSecret;
//
// // Do the Firebase thing
// initializeApp();
Object.defineProperty(exports, "__esModule", { value: true });
exports.pass = void 0;
const tslib_1 = require("tslib");
const functions = tslib_1.__importStar(require("firebase-functions"));
const app_1 = require("firebase-admin/app");
const storage_1 = require("firebase-admin/storage");
const generateProofRequest = require("./polygonId");
exports.polygonId = generateProofRequest;
const verifyAuthResponse = require("./polygonId");
exports.polygonId = verifyAuthResponse;
const passkit_generator_1 = require("passkit-generator");
const node_fs_1 = tslib_1.__importDefault(require("node:fs"));
const node_path_1 = tslib_1.__importDefault(require("node:path"));
const node_os_1 = tslib_1.__importDefault(require("node:os"));
/**
 * @see https://firebase.google.com/docs/storage/admin/start#node.js
 */
(0, app_1.initializeApp)({
    storageBucket: "fifthpint-common-dev.appspot.com",
});
const storageRef = (0, storage_1.getStorage)().bucket();
// exports.requestSecret = requestSecret;
exports.pass = functions.https.onRequest(async (request, response) => {
    let modelBasePath;
    if (process.env.FUNCTIONS_EMULATOR === "true") {
        modelBasePath = "./models/";
    }
    else {
        /**
         * Models are cloned on deploy through
         * the commands in `firebase.json` and
         * are uploaded along with our program.
         *
         * When deployed, root folder is the `functions` folder
         */
        modelBasePath = "./models/";
    }
    try {
        if (request.headers["content-type"] !== "application/json") {
            response.status(400);
            response.send({
                error: `Payload with content-type ${request.headers["content-type"]} is not supported. Use "application/json"`,
            });
            return;
        }
        if (!request.body.passModel) {
            response.status(400);
            response.send({
                error: "Unspecified 'passModel' parameter: which model should be used?",
            });
            return;
        }
        if (request.body.passModel.endsWith(".pass")) {
            request.body.passModel = request.body.passModel.replace(".pass", "");
        }
        const newPass = await passkit_generator_1.PKPass.from({
            /**
             * Get relevant pass model from model folder (see passkit-generator/examples/models/)
             * Path seems to get read like the function is in "firebase/" folder and not in "firebase/functions/"
             */
            model: `${modelBasePath}${request.body.passModel}.pass`,
            certificates: {
                // Assigning certificates from certs folder (you will need to provide these yourself)
                wwdr: process.env.WWDR,
                signerCert: process.env.SIGNER_CERT,
                signerKey: process.env.SIGNER_KEY,
                signerKeyPassphrase: process.env.SIGNER_KEY_PASSPHRASE,
            },
        }, {
            serialNumber: request.body.serialNumber,
            description: "DESCRIPTION",
            logoText: request.body.logoText,
            foregroundColor: request.body.textColor,
            backgroundColor: request.body.backgroundColor,
            labelColor: request.body.labelColor,
        });
        if (newPass.type == "boardingPass") {
            if (!request.body.transitType) {
                response.status(400);
                response.send({
                    error: "transitType is required",
                });
                return;
            }
            newPass.transitType = request.body.transitType;
        }
        if (typeof request.body.relevantDate === "string") {
            newPass.setRelevantDate(new Date(request.body.relevantDate));
        }
        if (typeof request.body.expiryDate === "string") {
            newPass.setExpirationDate(new Date(request.body.expiryDate));
        }
        if (request.body.relevantLocationLat &&
            request.body.relevantLocationLong) {
            newPass.setLocations({
                latitude: request.body.relevantLocationLat,
                longitude: request.body.relevantLocationLong,
            });
        }
        if (Array.isArray(request.body.header)) {
            for (let i = 0; i < request.body.header.length; i++) {
                const field = request.body.header[i];
                if (!(field?.label && field.value)) {
                    continue;
                }
                newPass.headerFields.push({
                    key: `header${i}`,
                    label: field.label,
                    value: field.value,
                });
            }
        }
        if (Array.isArray(request.body.primary)) {
            for (let i = 0; i < request.body.primary.length; i++) {
                const field = request.body.primary[i];
                if (!(field?.label && field.value)) {
                    continue;
                }
                newPass.primaryFields.push({
                    key: `primary${i}`,
                    label: field.label,
                    value: newPass.type == "boardingPass"
                        ? field.value.toUpperCase()
                        : field.value,
                });
            }
        }
        if (Array.isArray(request.body.secondary)) {
            for (let i = 0; i < request.body.secondary.length; i++) {
                const field = request.body.secondary[i];
                if (!(field?.label && field.value)) {
                    continue;
                }
                const isElementInLastTwoPositions = i === request.body.secondary.length - 2 ||
                    i === request.body.secondary.length - 1;
                newPass.secondaryFields.push({
                    key: `secondary${i}`,
                    label: field.label,
                    value: field.value,
                    textAlignment: isElementInLastTwoPositions
                        ? "PKTextAlignmentRight"
                        : "PKTextAlignmentLeft",
                });
            }
        }
        if (Array.isArray(request.body.auxiliary)) {
            for (let i = 0; i < request.body.auxiliary.length; i++) {
                const field = request.body.auxiliary[i];
                if (!(field?.label && field.value)) {
                    continue;
                }
                const isElementInLastTwoPositions = i === request.body.auxiliary.length - 2 ||
                    i === request.body.auxiliary.length - 1;
                newPass.auxiliaryFields.push({
                    key: `auxiliary${i}`,
                    label: field.label,
                    value: field.value,
                    textAlignment: isElementInLastTwoPositions
                        ? "PKTextAlignmentRight"
                        : "PKTextAlignmentLeft",
                });
            }
        }
        if (request.body.qrText && request.body.codeType) {
            newPass.setBarcodes({
                message: request.body.qrText,
                format: request.body.codeType,
                messageEncoding: "iso-8859-1",
                altText: request.body.codeAlt?.trim() ?? "",
            });
        }
        // DevNote - Added for hackathon
        if (request.body.nfc) {
            newPass.setNFC({
                encryptionPublicKey: request.body.nfc.encryptionPublicKey,
                message: request.body.nfc.message,
                requiresAuthentication: request.body.nfc.requiresAuthentication,
            });
        }
        const { thumbnailFile, logoFile } = request.body;
        // Downloading thumbnail and logo files from Firebase Storage and adding to pass
        if (newPass.type == "generic" || newPass.type == "eventTicket") {
            if (thumbnailFile) {
                const tempPath1 = node_path_1.default.join(node_os_1.default.tmpdir(), thumbnailFile);
                try {
                    await storageRef
                        .file(`thumbnails/${thumbnailFile}`)
                        .download({ destination: tempPath1 });
                    const buffer = node_fs_1.default.readFileSync(tempPath1);
                    newPass.addBuffer("thumbnail.png", buffer);
                    newPass.addBuffer("thumbnail@2x.png", buffer);
                }
                catch (error) {
                    console.error(error);
                }
            }
        }
        if (logoFile) {
            const tempPath2 = node_path_1.default.join(node_os_1.default.tmpdir(), logoFile);
            try {
                await storageRef
                    .file(`logos/${logoFile}`)
                    .download({ destination: tempPath2 });
                const buffer = node_fs_1.default.readFileSync(tempPath2);
                newPass.addBuffer("logo.png", buffer);
                newPass.addBuffer("logo@2x.png", buffer);
            }
            catch (error) {
                console.error(error);
            }
        }
        const bufferData = newPass.getAsBuffer();
        response.set("Content-Type", newPass.mimeType);
        response.status(200).send(bufferData);
    }
    catch (error) {
        console.log("Error Uploading pass " + error);
        const err = Object.assign({}, ...Object.entries(Object.getOwnPropertyDescriptors(error)).map(([key, descriptor]) => {
            return { [key]: descriptor.value };
        }));
        response.status(500);
        response.send({
            error: err,
        });
    }
});
