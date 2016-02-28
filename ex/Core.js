
/* global exports, require */
"use strict";

// module Core

exports.print = function (x) {
  return function () {
    console.log("doc: ", x);
  };
}
