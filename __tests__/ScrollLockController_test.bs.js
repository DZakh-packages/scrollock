// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Jest from "@glennsl/bs-jest/src/jest.bs.js";
import * as Curry from "rescript/lib/es6/curry.js";
import * as ScrollLockController$ScrollLockController from "../src/ScrollLockController.bs.js";

jest.mock("body-scroll-lock");

Jest.describe("ScrollLockController", (function (param) {
        Jest.test("Locks are empty after create", (function (param) {
                var controls = ScrollLockController$ScrollLockController.create(undefined);
                return Jest.Expect.toBe(true, Jest.Expect.expect(Curry._1(controls.isEmpty, undefined)));
              }));
        Jest.test("Locks aren't empty after lock", (function (param) {
                var div = document.createElement("div");
                var controls = ScrollLockController$ScrollLockController.create(undefined);
                Curry._1(controls.lock, div);
                return Jest.Expect.toBe(false, Jest.Expect.expect(Curry._1(controls.isEmpty, undefined)));
              }));
        return Jest.test("Locks are empty after lock and unlock", (function (param) {
                      var div = document.createElement("div");
                      var controls = ScrollLockController$ScrollLockController.create(undefined);
                      Curry._1(controls.lock, div);
                      Curry._3(controls.unlock, div, undefined, undefined);
                      return Jest.Expect.toBe(true, Jest.Expect.expect(Curry._1(controls.isEmpty, undefined)));
                    }));
      }));

export {
  
}
/*  Not a pure module */
