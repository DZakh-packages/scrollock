// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Curry from "rescript/lib/es6/curry.js";
import * as BodyScrollLock from "body-scroll-lock";
import * as ScrollLockController_Helpers$ScrollLockController from "./ScrollLockController_Helpers.bs.js";

function make(onBodyScrollLock, onBodyScrollUnlock, param) {
  var locks = ScrollLockController_Helpers$ScrollLockController.LocksSet.make(undefined);
  var isLocked = ScrollLockController_Helpers$ScrollLockController.TrackedValue.make((function (newIsLocked) {
          if (newIsLocked) {
            if (onBodyScrollLock !== undefined) {
              return Curry._1(onBodyScrollLock, undefined);
            } else {
              return ;
            }
          } else if (onBodyScrollUnlock !== undefined) {
            return Curry._1(onBodyScrollUnlock, undefined);
          } else {
            return ;
          }
        }), false);
  return {
          locks: locks,
          isLocked: isLocked
        };
}

function lock(entity, targetElement) {
  ScrollLockController_Helpers$ScrollLockController.LocksSet.add(entity.locks, targetElement);
  ScrollLockController_Helpers$ScrollLockController.TrackedValue.set(entity.isLocked, (function (param) {
          return true;
        }));
  BodyScrollLock.disableBodyScroll(targetElement, {
        reserveScrollBarGap: true
      });
  
}

function unlock(entity, targetElement) {
  ScrollLockController_Helpers$ScrollLockController.LocksSet.remove(entity.locks, targetElement);
  ScrollLockController_Helpers$ScrollLockController.TrackedValue.set(entity.isLocked, (function (param) {
          return false;
        }));
  BodyScrollLock.enableBodyScroll(targetElement);
  
}

export {
  make ,
  lock ,
  unlock ,
  
}
/* body-scroll-lock Not a pure module */
