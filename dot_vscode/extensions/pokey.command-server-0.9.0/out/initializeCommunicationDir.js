"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.initializeCommunicationDir = void 0;
const fs_1 = require("fs");
const constants_1 = require("constants");
const paths_1 = require("./paths");
const os_1 = require("os");
function initializeCommunicationDir() {
    const communicationDirPath = paths_1.getCommunicationDirPath();
    console.debug(`Creating communication dir ${communicationDirPath}`);
    fs_1.mkdirSync(communicationDirPath, { recursive: true, mode: 0o770 });
    const stats = fs_1.lstatSync(communicationDirPath);
    const info = os_1.userInfo();
    if (!stats.isDirectory() ||
        stats.isSymbolicLink() ||
        stats.mode & constants_1.S_IWOTH ||
        // On Windows, uid < 0, so we don't worry about it for simplicity
        (info.uid >= 0 && stats.uid !== info.uid)) {
        throw new Error(`Refusing to proceed because of invalid communication dir ${communicationDirPath}`);
    }
}
exports.initializeCommunicationDir = initializeCommunicationDir;
//# sourceMappingURL=initializeCommunicationDir.js.map