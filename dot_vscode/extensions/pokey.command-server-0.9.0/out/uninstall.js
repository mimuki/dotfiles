"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const paths_1 = require("./paths");
const rimraf_1 = require("rimraf");
function main() {
    rimraf_1.sync(paths_1.getCommunicationDirPath(), { disableGlob: true });
}
main();
//# sourceMappingURL=uninstall.js.map