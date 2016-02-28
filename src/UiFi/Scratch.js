/* global exports, require */
"use strict";

// module UiFi.Scratch

exports.print = function (x) {
  return function () {
    console.log("doc: ", x);
  };
}

exports.makeTextEl = function (text) {
  return document.createTextNode(text);
}

exports.makeNodeEl = function(tag) {
  return function(children) {
    var element;
    element = document.createElement(tag);

    children.forEach(function (child) {
      element.appendChild(child);
    });

    return element;
  };
}

exports.select_ = function(just) {
  return function (nothing) {
    return function (selector) {
      var el = document.querySelector(selector);
      if (el) { return just(el); } else { return nothing; }
    };
  };
}

exports.place_ = function(parent) {
  return function (child) {
    return function () { parent.appendChild(child); };
  };
}
