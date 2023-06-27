"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.writeResponse = exports.readRequest = void 0;
const promises_1 = require("fs/promises");
const constants_1 = require("./constants");
const paths_1 = require("./paths");
const fileUtils_1 = require("./fileUtils");
/**
 * Reads the JSON-encoded request from the request file, unlinking the file
 * after reading.
 * @returns A promise that resolves to a Response object
 */
function readRequest() {
    return __awaiter(this, void 0, void 0, function* () {
        const requestPath = paths_1.getRequestPath();
        const stats = yield promises_1.stat(requestPath);
        const request = JSON.parse(yield promises_1.readFile(requestPath, "utf-8"));
        if (Math.abs(stats.mtimeMs - new Date().getTime()) > constants_1.VSCODE_COMMAND_TIMEOUT_MS) {
            throw new Error("Request file is older than timeout; refusing to execute command");
        }
        return request;
    });
}
exports.readRequest = readRequest;
/**
 * Writes the response to the response file as JSON.
 * @param file The file to write to
 * @param response The response object to JSON-encode and write to disk
 */
function writeResponse(file, response) {
    return __awaiter(this, void 0, void 0, function* () {
        yield fileUtils_1.writeJSON(file, response);
    });
}
exports.writeResponse = writeResponse;
//# sourceMappingURL=io.js.map