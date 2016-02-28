/* global exports, require */
"use strict";

// module UiFi.El

exports.makeTextEl = function (text) {
  return document.createTextNode(text);
}

exports.makeNodeEl = function(tag, children) {
  var element;
  element = document.createElement(tag);

  children.forEach(function (child) {
    element.appendChild(child);
  });

  return element;
}

exports.select_ = function(just, nothing, selector) {
  return function () {
    var el = document.querySelector(selector);
    if (el) { return just(el); } else { return nothing; }
  };
}

exports.selectAll_ = function(selector) {
  return function () {
    var el = document.querySelectorAll(selector);
    if (el) { return just(el); } else { return nothing; }
  };
}

exports.place_ = function(unit, parent, child) {
  return function () {
    parent.appendChild(child);
    return unit;
  };
}
