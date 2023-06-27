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
const promises_1 = require("fs/promises");
const minimatch_1 = require("minimatch");
const vscode = require("vscode");
const io_1 = require("./io");
const paths_1 = require("./paths");
const regex_1 = require("./regex");
class CommandRunner {
    constructor() {
        this.reloadConfiguration = this.reloadConfiguration.bind(this);
        this.runCommand = this.runCommand.bind(this);
        this.reloadConfiguration();
        vscode.workspace.onDidChangeConfiguration(this.reloadConfiguration);
    }
    reloadConfiguration() {
        const allowList = vscode.workspace
            .getConfiguration("command-server")
            .get("allowList");
        this.allowRegex = regex_1.any(...allowList.map((glob) => new minimatch_1.Minimatch(glob).makeRe()));
        const denyList = vscode.workspace
            .getConfiguration("command-server")
            .get("denyList");
        this.denyRegex =
            denyList.length === 0
                ? null
                : regex_1.any(...denyList.map((glob) => new minimatch_1.Minimatch(glob).makeRe()));
        this.backgroundWindowProtection = vscode.workspace
            .getConfiguration("command-server")
            .get("backgroundWindowProtection");
    }
    /**
     * Reads a command from the request file and executes it.  Writes information
     * about command execution to the result of the command to the response file,
     * If requested, will wait for command to finish, and can also write command
     * output to response file.  See also documentation for Request / Response
     * types.
     */
    runCommand() {
        return __awaiter(this, void 0, void 0, function* () {
            const responseFile = yield promises_1.open(paths_1.getResponsePath(), "wx");
            let request;
            try {
                request = yield io_1.readRequest();
            }
            catch (err) {
                yield responseFile.close();
                throw err;
            }
            const { commandId, args, uuid, returnCommandOutput, waitForFinish } = request;
            const warnings = [];
            try {
                if (!vscode.window.state.focused) {
                    if (this.backgroundWindowProtection) {
                        throw new Error("This editor is not active");
                    }
                    else {
                        warnings.push("This editor is not active");
                    }
                }
                if (!commandId.match(this.allowRegex)) {
                    throw new Error("Command not in allowList");
                }
                if (this.denyRegex != null && commandId.match(this.denyRegex)) {
                    throw new Error("Command in denyList");
                }
                const commandPromise = vscode.commands.executeCommand(commandId, ...args);
                let commandReturnValue = null;
                if (returnCommandOutput) {
                    commandReturnValue = yield commandPromise;
                }
                else if (waitForFinish) {
                    yield commandPromise;
                }
                yield io_1.writeResponse(responseFile, {
                    error: null,
                    uuid,
                    returnValue: commandReturnValue,
                    warnings,
                });
            }
            catch (err) {
                yield io_1.writeResponse(responseFile, {
                    error: err.message,
                    uuid,
                    warnings,
                });
            }
            yield responseFile.close();
        });
    }
}
exports.default = CommandRunner;
//# sourceMappingURL=commandRunner.js.map