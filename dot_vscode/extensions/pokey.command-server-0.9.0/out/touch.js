"use strict";
// From https://gist.githubusercontent.com/remarkablemark/17c9c6a22a41510b2edfa3041ccca95a/raw/b11f087313b4c6f32733989ee24d65e1b643f007/touch-promise.js
Object.defineProperty(exports, "__esModule", { value: true });
const fs_1 = require("fs");
const touch = (path) => {
    return new Promise((resolve, reject) => {
        const time = new Date();
        fs_1.utimes(path, time, time, (err) => {
            if (err) {
                return fs_1.open(path, "w", (err, fd) => {
                    if (err) {
                        return reject(err);
                    }
                    fs_1.close(fd, (err) => (err ? reject(err) : resolve()));
                });
            }
            resolve();
        });
    });
};
exports.default = touch;
//# sourceMappingURL=touch.js.map