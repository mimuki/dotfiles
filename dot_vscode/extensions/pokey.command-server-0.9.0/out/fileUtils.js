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
exports.writeJSON = void 0;
/**
 * Writes stringified JSON.
 * Appends newline so that other side knows when it is done
 * @param path Output path
 * @param body Body to stringify and write
 */
function writeJSON(file, body) {
    return __awaiter(this, void 0, void 0, function* () {
        yield file.write(`${JSON.stringify(body)}\n`);
    });
}
exports.writeJSON = writeJSON;
//# sourceMappingURL=fileUtils.js.map