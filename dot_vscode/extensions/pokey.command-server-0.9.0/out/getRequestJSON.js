"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getRequestJSON = void 0;
function getRequestJSON(req) {
    return new Promise((resolve, reject) => {
        var body = "";
        req.on("data", function (chunk) {
            body += chunk;
        });
        req.on("end", () => resolve(JSON.parse(body)));
    });
}
exports.getRequestJSON = getRequestJSON;
//# sourceMappingURL=getRequestJSON.js.map