// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Caml_option from "rescript/lib/es6/caml_option.js";
import * as ScrollLockController$ScrollLockController from "../ScrollLockController.bs.js";
import * as ScrollLockController_Helpers$ScrollLockController from "../ScrollLockController_Helpers.bs.js";

import './style.css';
;

var scrollLockController = ScrollLockController$ScrollLockController.make(undefined, undefined, undefined, undefined, undefined);

function enableLockButton(lockButtonEl) {
  var scrollableNodeList = document.querySelectorAll(".js-modal-with-scroll");
  var onLockButtonClick = function (param) {
    scrollableNodeList.forEach(function (scrollableNode, _idx) {
          var scrollableEl = ScrollLockController_Helpers$ScrollLockController.convertNodeToElement(scrollableNode);
          if (scrollableEl !== undefined) {
            return ScrollLockController$ScrollLockController.lock(scrollLockController, [Caml_option.valFromOption(scrollableEl)]);
          }
          
        });
    
  };
  lockButtonEl.addEventListener("click", onLockButtonClick);
  
}

function enableUnlockButton(unlockButtonEl) {
  var scrollableNodeList = document.querySelectorAll(".js-modal-with-scroll");
  var onUnlockButtonClick = function (param) {
    scrollableNodeList.forEach(function (scrollableNode, _idx) {
          var scrollableEl = ScrollLockController_Helpers$ScrollLockController.convertNodeToElement(scrollableNode);
          if (scrollableEl !== undefined) {
            return ScrollLockController$ScrollLockController.unlock(scrollLockController, [Caml_option.valFromOption(scrollableEl)]);
          }
          
        });
    
  };
  unlockButtonEl.addEventListener("click", onUnlockButtonClick);
  
}

var __x = document;

var lockButtonEl = __x.querySelector(".js-lock-button");

if (!(lockButtonEl == null)) {
  enableLockButton(lockButtonEl);
}

var __x$1 = document;

var unlockButtonEl = __x$1.querySelector(".js-unlock-button");

if (!(unlockButtonEl == null)) {
  enableUnlockButton(unlockButtonEl);
}

export {
  scrollLockController ,
  enableLockButton ,
  enableUnlockButton ,
  
}
/*  Not a pure module */
