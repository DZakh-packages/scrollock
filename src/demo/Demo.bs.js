// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Caml_option from "rescript/lib/es6/caml_option.js";
import * as ScrollLockController$ScrollLockController from "../ScrollLockController.bs.js";
import * as ScrollLockController__helpers$ScrollLockController from "../ScrollLockController__helpers.bs.js";

import './style.css';
;

function enableLockButton(lockButtonEl) {
  var scrollableNodeList = document.querySelectorAll(".js-modal-with-scroll");
  var onLockButtonClick = function (param) {
    scrollableNodeList.forEach(function (scrollableNode, _idx) {
          var scrollableEl = ScrollLockController__helpers$ScrollLockController.convertNodeToElement(scrollableNode);
          if (scrollableEl !== undefined) {
            return ScrollLockController$ScrollLockController.lock(Caml_option.valFromOption(scrollableEl));
          }
          
        });
    
  };
  lockButtonEl.addEventListener("click", onLockButtonClick);
  
}

function enableUnlockButton(unlockButtonEl) {
  var scrollableNodeList = document.querySelectorAll(".js-modal-with-scroll");
  var onUnlockButtonClick = function (param) {
    scrollableNodeList.forEach(function (scrollableNode, _idx) {
          var scrollableEl = ScrollLockController__helpers$ScrollLockController.convertNodeToElement(scrollableNode);
          if (scrollableEl !== undefined) {
            return ScrollLockController$ScrollLockController.unlock(Caml_option.valFromOption(scrollableEl));
          }
          
        });
    
  };
  unlockButtonEl.addEventListener("click", onUnlockButtonClick);
  
}

var lockButtonEl = document.querySelector(".js-lock-button");

if (!(lockButtonEl == null)) {
  enableLockButton(lockButtonEl);
}

var unlockButtonEl = document.querySelector(".js-unlock-button");

if (!(unlockButtonEl == null)) {
  enableUnlockButton(unlockButtonEl);
}

export {
  enableLockButton ,
  enableUnlockButton ,
  
}
/*  Not a pure module */
