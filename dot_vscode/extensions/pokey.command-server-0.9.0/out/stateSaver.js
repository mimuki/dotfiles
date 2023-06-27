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
const fs_1 = require("fs");
const promises_1 = require("fs/promises");
const fileUtils_1 = require("./fileUtils");
const paths_1 = require("./paths");
const path_1 = require("path");
function writeState(memento, stateDirPath) {
    return memento.keys().map((key) => __awaiter(this, void 0, void 0, function* () {
        const responseFile = yield promises_1.open(path_1.join(stateDirPath, key), "w");
        try {
            yield fileUtils_1.writeJSON(responseFile, memento.get(key));
        }
        finally {
            yield responseFile.close();
        }
    }));
}
class StateSaver {
    constructor(globalState, workspaceState) {
        this.globalState = globalState;
        this.workspaceState = workspaceState;
    }
    init() {
        fs_1.mkdirSync(paths_1.getGlobalStateDirPath(), { recursive: true });
        fs_1.mkdirSync(paths_1.getWorkspaceStateDirPath(), { recursive: true });
    }
    save() {
        return __awaiter(this, void 0, void 0, function* () {
            const globalStatePromises = writeState(this.globalState, paths_1.getGlobalStateDirPath());
            const workspaceStatePromises = writeState(this.workspaceState, paths_1.getWorkspaceStateDirPath());
            yield Promise.all([...globalStatePromises, ...workspaceStatePromises]);
        });
    }
}
exports.default = StateSaver;
//# sourceMappingURL=stateSaver.js.map