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
exports.deactivate = exports.activate = void 0;
const vscode = require("vscode");
const Parser = require("web-tree-sitter");
const path = require("path");
const errors_1 = require("./errors");
// Be sure to declare the language in package.json and include a minimalist grammar.
const languages = {
    agda: { module: "tree-sitter-agda" },
    c: { module: "tree-sitter-c" },
    clojure: { module: "tree-sitter-clojure" },
    cpp: { module: "tree-sitter-cpp" },
    csharp: { module: "tree-sitter-c-sharp" },
    css: { module: "tree-sitter-css" },
    elm: { module: "tree-sitter-elm" },
    go: { module: "tree-sitter-go" },
    haskell: { module: "tree-sitter-haskell" },
    html: { module: "tree-sitter-html" },
    java: { module: "tree-sitter-java" },
    javascript: { module: "tree-sitter-javascript" },
    javascriptreact: { module: "tree-sitter-javascript" },
    json: { module: "tree-sitter-json" },
    jsonc: { module: "tree-sitter-json" },
    latex: { module: "tree-sitter-latex" },
    markdown: { module: "tree-sitter-markdown" },
    php: { module: "tree-sitter-php" },
    python: { module: "tree-sitter-python" },
    ruby: { module: "tree-sitter-ruby" },
    rust: { module: "tree-sitter-rust" },
    scala: { module: "tree-sitter-scala" },
    scm: { module: "tree-sitter-query" },
    scss: { module: "tree-sitter-scss" },
    shellscript: { module: "tree-sitter-bash" },
    sparql: { module: "tree-sitter-sparql" },
    typescript: { module: "tree-sitter-typescript" },
    typescriptreact: { module: "tree-sitter-tsx" },
    xml: { module: "tree-sitter-html" },
    yaml: { module: "tree-sitter-yaml" },
};
// For some reason this crashes if we put it inside activate
const initParser = Parser.init(); // TODO this isn't a field, suppress package member coloring like Go
// Called when the extension is first activated by user opening a file with the appropriate language
function activate(context) {
    return __awaiter(this, void 0, void 0, function* () {
        console.debug("Activating tree-sitter...");
        // Parse of all visible documents
        const trees = {};
        /**
         * Load the parser model for a given language
         * @param languageId The vscode language id of the language to load
         * @returns a promise resolving to boolean an indicating whether the language could be loaded
         */
        function loadLanguage(languageId) {
            return __awaiter(this, void 0, void 0, function* () {
                const language = languages[languageId];
                if (language == null)
                    return false;
                if (language.parser != null)
                    return true;
                const absolute = path.join(context.extensionPath, "parsers", language.module + ".wasm");
                const wasm = path.relative(process.cwd(), absolute);
                const lang = yield Parser.Language.load(wasm);
                const parser = new Parser();
                parser.setLanguage(lang);
                language.parser = parser;
                return true;
            });
        }
        function open(document) {
            return __awaiter(this, void 0, void 0, function* () {
                const uriString = document.uri.toString();
                if (uriString in trees)
                    return;
                if (!(yield loadLanguage(document.languageId)))
                    return;
                const language = languages[document.languageId];
                const t = language.parser.parse(document.getText()); // TODO don't use getText, use Parser.Input
                trees[uriString] = t;
            });
        }
        function openIfLanguageLoaded(document) {
            const uriString = document.uri.toString();
            if (uriString in trees)
                return null;
            const language = languages[document.languageId];
            if (language == null)
                return null;
            if (language.parser == null)
                return null;
            const t = language.parser.parse(document.getText()); // TODO don't use getText, use Parser.Input
            trees[uriString] = t;
            return t;
        }
        // NOTE: if you make this an async function, it seems to cause edit anomalies
        function edit(edit) {
            const language = languages[edit.document.languageId];
            if (language == null || language.parser == null)
                return;
            updateTree(language.parser, edit);
        }
        function updateTree(parser, edit) {
            if (edit.contentChanges.length == 0)
                return;
            const old = trees[edit.document.uri.toString()];
            for (const e of edit.contentChanges) {
                const startIndex = e.rangeOffset;
                const oldEndIndex = e.rangeOffset + e.rangeLength;
                const newEndIndex = e.rangeOffset + e.text.length;
                const startPos = edit.document.positionAt(startIndex);
                const oldEndPos = edit.document.positionAt(oldEndIndex);
                const newEndPos = edit.document.positionAt(newEndIndex);
                const startPosition = asPoint(startPos);
                const oldEndPosition = asPoint(oldEndPos);
                const newEndPosition = asPoint(newEndPos);
                const delta = {
                    startIndex,
                    oldEndIndex,
                    newEndIndex,
                    startPosition,
                    oldEndPosition,
                    newEndPosition,
                };
                old.edit(delta);
            }
            const t = parser.parse(edit.document.getText(), old); // TODO don't use getText, use Parser.Input
            trees[edit.document.uri.toString()] = t;
        }
        function asPoint(pos) {
            return { row: pos.line, column: pos.character };
        }
        function close(document) {
            delete trees[document.uri.toString()];
        }
        function colorAllOpen() {
            return __awaiter(this, void 0, void 0, function* () {
                for (const editor of vscode.window.visibleTextEditors) {
                    yield open(editor.document);
                }
            });
        }
        function openIfVisible(document) {
            if (vscode.window.visibleTextEditors.some((editor) => editor.document.uri.toString() === document.uri.toString())) {
                return open(document);
            }
        }
        context.subscriptions.push(vscode.window.onDidChangeVisibleTextEditors(colorAllOpen));
        context.subscriptions.push(vscode.workspace.onDidChangeTextDocument(edit));
        context.subscriptions.push(vscode.workspace.onDidCloseTextDocument(close));
        context.subscriptions.push(vscode.workspace.onDidOpenTextDocument(openIfVisible));
        // Don't wait for the initial color, it takes too long to inspect the themes and causes VSCode extension host to hang
        function activateLazily() {
            return __awaiter(this, void 0, void 0, function* () {
                yield initParser;
                colorAllOpen();
            });
        }
        activateLazily();
        function getTreeForUri(uri) {
            const ret = trees[uri.toString()];
            if (typeof ret === "undefined") {
                const document = vscode.workspace.textDocuments.find((textDocument) => textDocument.uri.toString() === uri.toString());
                if (document == null) {
                    throw new Error(`Document ${uri} is not open`);
                }
                const ret = openIfLanguageLoaded(document);
                if (ret != null) {
                    return ret;
                }
                const languageId = document.languageId;
                if (languageId in languages) {
                    throw new errors_1.LanguageStillLoadingError(languageId);
                }
                else {
                    throw new errors_1.UnsupportedLanguageError(languageId);
                }
            }
            return ret;
        }
        return {
            loadLanguage,
            getTree(document) {
                return getTreeForUri(document.uri);
            },
            getNodeAtLocation(location) {
                return getTreeForUri(location.uri).rootNode.descendantForPosition({
                    row: location.range.start.line,
                    column: location.range.start.character,
                });
            },
        };
    });
}
exports.activate = activate;
// this method is called when your extension is deactivated
function deactivate() { }
exports.deactivate = deactivate;
//# sourceMappingURL=extension.js.map