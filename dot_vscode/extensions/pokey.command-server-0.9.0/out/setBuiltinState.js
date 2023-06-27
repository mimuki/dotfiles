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
exports.updateTerminalState = exports.setBuiltinState = void 0;
const vscode_1 = require("vscode");
const constants_1 = require("./constants");
function setBuiltinState(workspaceState, globalState) {
    return __awaiter(this, void 0, void 0, function* () {
        const focus = workspaceState.get(constants_1.FOCUS_KEY);
        const editors = vscode_1.window.visibleTextEditors.map(serializeTextEditor);
        const activeEditor = vscode_1.window.activeTextEditor == null
            ? null
            : serializeTextEditor(vscode_1.window.activeTextEditor);
        yield workspaceState.update(constants_1.VISIBLE_EDITORS_KEY, editors);
        yield workspaceState.update(constants_1.ACTIVE_EDITOR_KEY, activeEditor);
        yield workspaceState.update(constants_1.FOCUSED_EDITOR_KEY, focus === constants_1.EDITOR_FOCUSED ? activeEditor : null);
        yield workspaceState.update(constants_1.FOCUSED_TERMINAL_KEY, focus === constants_1.TERMINAL_FOCUSED
            ? workspaceState.get(constants_1.ACTIVE_TERMINAL_KEY)
            : null);
    });
}
exports.setBuiltinState = setBuiltinState;
function updateTerminalState(workspaceState, globalState) {
    return __awaiter(this, void 0, void 0, function* () {
        const terminals = yield Promise.all(vscode_1.window.terminals.map(serializeTerminal));
        const activeTerminal = vscode_1.window.activeTerminal == null
            ? null
            : yield serializeTerminal(vscode_1.window.activeTerminal);
        yield workspaceState.update(constants_1.TERMINALS_KEY, terminals);
        yield workspaceState.update(constants_1.ACTIVE_TERMINAL_KEY, activeTerminal);
    });
}
exports.updateTerminalState = updateTerminalState;
function serializeTextEditor(textEditor) {
    return { document: serializeDocument(textEditor.document) };
}
function serializeDocument(document) {
    const { uri, isUntitled, isDirty, fileName, languageId, version } = document;
    return {
        uri: uri.toString(),
        isUntitled,
        isDirty,
        fileName,
        languageId,
        version,
    };
}
function serializeTerminal(terminal) {
    return __awaiter(this, void 0, void 0, function* () {
        const { name } = terminal;
        return { name, processId: yield terminal.processId };
    });
}
//# sourceMappingURL=setBuiltinState.js.map