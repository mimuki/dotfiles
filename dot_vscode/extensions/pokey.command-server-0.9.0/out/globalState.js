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
class GlobalState {
    constructor() {
        this.state = {};
    }
    init() {
        fs_1.mkdirSync(paths_1.getGlobalStatePath(), { recursive: true });
        this.loadSync();
    }
    loadSync() {
        const statePath = paths_1.getGlobalStatePath();
        const stats = fs_1.lstatSync(statePath);
        if (stats.isFile()) {
            this.state = JSON.parse(fs_1.readFileSync(statePath, "utf-8"));
        }
    }
    save() {
        return __awaiter(this, void 0, void 0, function* () {
            const responseFile = yield promises_1.open(paths_1.getGlobalStatePath(), "w");
            try {
                yield fileUtils_1.writeJSON(responseFile, this.state);
            }
            finally {
                yield responseFile.close();
            }
        });
    }
    get(key, defaultValue) {
        const value = this.state[key];
        return value == null ? defaultValue : value;
    }
    keys() {
        return Object.keys(this.state);
    }
    update(key, value) {
        return __awaiter(this, void 0, void 0, function* () {
            this.state[key] = value;
            yield this.save();
        });
    }
}
exports.default = GlobalState;
//# sourceMappingURL=globalState.js.map