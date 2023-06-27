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
const STORAGE_KEY = "pokey.command-server.state";
function getKey(key) {
    return `${STORAGE_KEY}.${key}`;
}
class State {
    constructor(storage) {
        this.storage = storage;
    }
    get(key, defaultValue) {
        return this.storage.get(getKey(key), defaultValue);
    }
    keys() {
        return this.storage
            .keys()
            .filter((key) => key.startsWith(STORAGE_KEY))
            .map((key) => key.substring(STORAGE_KEY.length + 1));
    }
    update(key, value) {
        return __awaiter(this, void 0, void 0, function* () {
            yield this.storage.update(getKey(key), value);
        });
    }
}
exports.default = State;
//# sourceMappingURL=state.js.map