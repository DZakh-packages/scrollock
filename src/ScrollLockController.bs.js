// Generated by ReScript, PLEASE EDIT WITH CARE

import * as BodyScrollLock from "body-scroll-lock";

function lock(el) {
  BodyScrollLock.disableBodyScroll(el, {
        reserveScrollBarGap: true
      });
  
}

function unlock(el) {
  BodyScrollLock.enableBodyScroll(el);
  
}

export {
  lock ,
  unlock ,
  
}
/* body-scroll-lock Not a pure module */
