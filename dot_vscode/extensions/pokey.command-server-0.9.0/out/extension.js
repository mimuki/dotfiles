"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.deactivate = exports.activate = void 0;
const vscode = require("vscode");
const commandRunner_1 = require("./commandRunner");
const initializeCommunicationDir_1 = require("./initializeCommunicationDir");
const signal_1 = require("./signal");
function activate(context) {
    initializeCommunicationDir_1.initializeCommunicationDir();
    const commandRunner = new commandRunner_1.default();
    let focusedElementType;
    context.subscriptions.push(vscode.commands.registerCommand("command-server.runCommand", (focusedElementType_) => {
        focusedElementType = focusedElementType_;
        return commandRunner.runCommand();
    }), vscode.commands.registerCommand("command-server.getFocusedElementType", () => focusedElementType !== null && focusedElementType !== void 0 ? focusedElementType : null));
    return {
        /**
         * The type of the focused element in vscode at the moment of the command being executed.
         */
        getFocusedElementType: () => focusedElementType,
        /**
         * These signals can be used as a form of IPC to indicate that an event has
         * occurred.
         */
        signals: {
            /**
             * This signal is emitted by the voice engine to indicate that a phrase has
             * just begun execution.
             */
            prePhrase: signal_1.getInboundSignal("prePhrase"),
        },
    };
}
exports.activate = activate;
// this method is called when your extension is deactivated
function deactivate() { }
exports.deactivate = deactivate;
//# sourceMappingURL=extension.js.map