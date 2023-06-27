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
exports.getInboundSignal = void 0;
const promises_1 = require("fs/promises");
const path_1 = require("path");
const paths_1 = require("./paths");
class InboundSignal {
    constructor(path) {
        this.path = path;
    }
    /**
     * Gets the current version of the signal. This version string changes every
     * time the signal is emitted, and can be used to detect whether signal has
     * been emitted between two timepoints.
     * @returns The current signal version or null if the signal file could not be
     * found
     */
    getVersion() {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                return (yield promises_1.stat(this.path)).mtimeMs.toString();
            }
            catch (err) {
                if (err.code !== "ENOENT") {
                    throw err;
                }
                return null;
            }
        });
    }
}
function getInboundSignal(name) {
    const signalDir = paths_1.getSignalDirPath();
    const path = path_1.join(signalDir, name);
    return new InboundSignal(path);
}
exports.getInboundSignal = getInboundSignal;
//# sourceMappingURL=signal.js.map