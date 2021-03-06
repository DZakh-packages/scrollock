let {test, describe, beforeEach, fail} = module(Jest)
let {mock} = module(Jest.JestJs)
let {expect} = module(Jest.Expect)

mock("body-scroll-lock")

describe("Test Core", () => {
  describe("When the onBodyScrollLock callback is passed", () => {
    let mockOnBodyScrollLockRef = ref(None)
    let scrollockCoreRef = ref(None)
    let targetElement1Ref = ref(None)

    beforeEach(() => {
      let mockOnBodyScrollLock = Jest.JestJs.fn(() => ())

      mockOnBodyScrollLockRef := Some(mockOnBodyScrollLock)
      scrollockCoreRef :=
        Some(
          Core.make({
            onBodyScrollLock: Some(mockOnBodyScrollLock->Jest.MockJs.fn),
            onBodyScrollUnlock: None,
            onLockTargetsAdd: None,
            onLockTargetsRemove: None,
          }),
        )
      targetElement1Ref := Some(Webapi.Dom.Document.createElement("div", Webapi.Dom.document))
    })

    test("Isn't called right after creation", () => {
      switch (mockOnBodyScrollLockRef.contents, scrollockCoreRef.contents) {
      | (Some(mockOnBodyScrollLock), Some(_)) =>
        expect(mockOnBodyScrollLock->Jest.MockJs.calls->Js.Array2.length)->Jest.Expect.toBe(0, _)
      | (_, _) => fail("Prepare stage failed")
      }
    })

    test("Is called after first lock", () => {
      switch (
        mockOnBodyScrollLockRef.contents,
        scrollockCoreRef.contents,
        targetElement1Ref.contents,
      ) {
      | (Some(mockOnBodyScrollLock), Some(scrollockCore), Some(targetElement1)) => {
          scrollockCore->Core.lock([targetElement1])

          expect(mockOnBodyScrollLock->Jest.MockJs.calls->Js.Array2.length)->Jest.Expect.toBe(1, _)
        }
      | (_, _, _) => fail("Prepare stage failed")
      }
    })

    test("Isn't called once again after unlock", () => {
      switch (
        mockOnBodyScrollLockRef.contents,
        scrollockCoreRef.contents,
        targetElement1Ref.contents,
      ) {
      | (Some(mockOnBodyScrollLock), Some(scrollockCore), Some(targetElement1)) => {
          scrollockCore->Core.lock([targetElement1])
          scrollockCore->Core.unlock([targetElement1])

          expect(mockOnBodyScrollLock->Jest.MockJs.calls->Js.Array2.length)->Jest.Expect.toBe(1, _)
        }
      | (_, _, _) => fail("Prepare stage failed")
      }
    })

    test("Is called once again after second lock", () => {
      switch (
        mockOnBodyScrollLockRef.contents,
        scrollockCoreRef.contents,
        targetElement1Ref.contents,
      ) {
      | (Some(mockOnBodyScrollLock), Some(scrollockCore), Some(targetElement1)) => {
          scrollockCore->Core.lock([targetElement1])
          scrollockCore->Core.unlock([targetElement1])
          scrollockCore->Core.lock([targetElement1])

          expect(mockOnBodyScrollLock->Jest.MockJs.calls->Js.Array2.length)->Jest.Expect.toBe(2, _)
        }
      | (_, _, _) => fail("Prepare stage failed")
      }
    })

    test("Isn't called multiple times after locking multiple elements", () => {
      switch (
        mockOnBodyScrollLockRef.contents,
        scrollockCoreRef.contents,
        targetElement1Ref.contents,
      ) {
      | (Some(mockOnBodyScrollLock), Some(scrollockCore), Some(targetElement1)) => {
          let targetElement2 = Webapi.Dom.Document.createElement("div", Webapi.Dom.document)

          scrollockCore->Core.lock([targetElement1])
          scrollockCore->Core.lock([targetElement2])

          expect(mockOnBodyScrollLock->Jest.MockJs.calls->Js.Array2.length)->Jest.Expect.toBe(1, _)
        }
      | (_, _, _) => fail("Prepare stage failed")
      }
    })

    test("Is called once again after clearing multiple locks and locking again", () => {
      switch (
        mockOnBodyScrollLockRef.contents,
        scrollockCoreRef.contents,
        targetElement1Ref.contents,
      ) {
      | (Some(mockOnBodyScrollLock), Some(scrollockCore), Some(targetElement1)) => {
          let targetElement2 = Webapi.Dom.Document.createElement("div", Webapi.Dom.document)

          scrollockCore->Core.lock([targetElement1])
          scrollockCore->Core.lock([targetElement2])
          scrollockCore->Core.clear
          scrollockCore->Core.lock([targetElement1])

          expect(mockOnBodyScrollLock->Jest.MockJs.calls->Js.Array2.length)->Jest.Expect.toBe(2, _)
        }
      | (_, _, _) => fail("Prepare stage failed")
      }
    })
  })

  describe("When the onBodyScrollUnlock callback is passed", () => {
    let mockOnBodyScrollUnlockRef = ref(None)
    let scrollockCoreRef = ref(None)
    let targetElement1Ref = ref(None)

    beforeEach(() => {
      let mockOnBodyScrollUnlock = Jest.JestJs.fn(() => ())

      mockOnBodyScrollUnlockRef := Some(mockOnBodyScrollUnlock)
      scrollockCoreRef :=
        Some(
          Core.make({
            onBodyScrollLock: None,
            onBodyScrollUnlock: Some(mockOnBodyScrollUnlock->Jest.MockJs.fn),
            onLockTargetsAdd: None,
            onLockTargetsRemove: None,
          }),
        )
      targetElement1Ref := Some(Webapi.Dom.Document.createElement("div", Webapi.Dom.document))
    })

    test("Isn't called right after creation", () => {
      switch (mockOnBodyScrollUnlockRef.contents, scrollockCoreRef.contents) {
      | (Some(mockOnBodyScrollUnlock), Some(_)) =>
        expect(mockOnBodyScrollUnlock->Jest.MockJs.calls->Js.Array2.length)->Jest.Expect.toBe(0, _)
      | (_, _) => fail("Prepare stage failed")
      }
    })

    test("Isn't called after lock", () => {
      switch (
        mockOnBodyScrollUnlockRef.contents,
        scrollockCoreRef.contents,
        targetElement1Ref.contents,
      ) {
      | (Some(mockOnBodyScrollUnlock), Some(scrollockCore), Some(targetElement1)) => {
          scrollockCore->Core.lock([targetElement1])

          expect(mockOnBodyScrollUnlock->Jest.MockJs.calls->Js.Array2.length)->Jest.Expect.toBe(
            0,
            _,
          )
        }
      | (_, _, _) => fail("Prepare stage failed")
      }
    })

    test("Is called after unlock", () => {
      switch (
        mockOnBodyScrollUnlockRef.contents,
        scrollockCoreRef.contents,
        targetElement1Ref.contents,
      ) {
      | (Some(mockOnBodyScrollUnlock), Some(scrollockCore), Some(targetElement1)) => {
          scrollockCore->Core.lock([targetElement1])
          scrollockCore->Core.unlock([targetElement1])

          expect(mockOnBodyScrollUnlock->Jest.MockJs.calls->Js.Array2.length)->Jest.Expect.toBe(
            1,
            _,
          )
        }
      | (_, _, _) => fail("Prepare stage failed")
      }
    })

    test("Is called after clear", () => {
      switch (
        mockOnBodyScrollUnlockRef.contents,
        scrollockCoreRef.contents,
        targetElement1Ref.contents,
      ) {
      | (Some(mockOnBodyScrollUnlock), Some(scrollockCore), Some(targetElement1)) => {
          scrollockCore->Core.lock([targetElement1])
          scrollockCore->Core.clear

          expect(mockOnBodyScrollUnlock->Jest.MockJs.calls->Js.Array2.length)->Jest.Expect.toBe(
            1,
            _,
          )
        }
      | (_, _, _) => fail("Prepare stage failed")
      }
    })

    test("Is called after clearing multiple locks", () => {
      switch (
        mockOnBodyScrollUnlockRef.contents,
        scrollockCoreRef.contents,
        targetElement1Ref.contents,
      ) {
      | (Some(mockOnBodyScrollUnlock), Some(scrollockCore), Some(targetElement1)) => {
          let targetElement2 = Webapi.Dom.Document.createElement("div", Webapi.Dom.document)

          scrollockCore->Core.lock([targetElement1])
          scrollockCore->Core.lock([targetElement2])
          scrollockCore->Core.clear

          expect(mockOnBodyScrollUnlock->Jest.MockJs.calls->Js.Array2.length)->Jest.Expect.toBe(
            1,
            _,
          )
        }
      | (_, _, _) => fail("Prepare stage failed")
      }
    })

    test("Is called once again after second unlock", () => {
      switch (
        mockOnBodyScrollUnlockRef.contents,
        scrollockCoreRef.contents,
        targetElement1Ref.contents,
      ) {
      | (Some(mockOnBodyScrollUnlock), Some(scrollockCore), Some(targetElement1)) => {
          scrollockCore->Core.lock([targetElement1])
          scrollockCore->Core.unlock([targetElement1])
          scrollockCore->Core.lock([targetElement1])
          scrollockCore->Core.unlock([targetElement1])

          expect(mockOnBodyScrollUnlock->Jest.MockJs.calls->Js.Array2.length)->Jest.Expect.toBe(
            2,
            _,
          )
        }
      | (_, _, _) => fail("Prepare stage failed")
      }
    })

    test("Isn't called after locking multiple elements and unlocking some of them", () => {
      switch (
        mockOnBodyScrollUnlockRef.contents,
        scrollockCoreRef.contents,
        targetElement1Ref.contents,
      ) {
      | (Some(mockOnBodyScrollUnlock), Some(scrollockCore), Some(targetElement1)) => {
          let targetElement2 = Webapi.Dom.Document.createElement("div", Webapi.Dom.document)

          scrollockCore->Core.lock([targetElement1])
          scrollockCore->Core.lock([targetElement2])
          scrollockCore->Core.unlock([targetElement2])

          expect(mockOnBodyScrollUnlock->Jest.MockJs.calls->Js.Array2.length)->Jest.Expect.toBe(
            0,
            _,
          )
        }
      | (_, _, _) => fail("Prepare stage failed")
      }
    })

    test("Isn't called after unlocking while body scroll isn't locked", () => {
      switch (
        mockOnBodyScrollUnlockRef.contents,
        scrollockCoreRef.contents,
        targetElement1Ref.contents,
      ) {
      | (Some(mockOnBodyScrollUnlock), Some(scrollockCore), Some(targetElement1)) => {
          scrollockCore->Core.unlock([targetElement1])

          expect(mockOnBodyScrollUnlock->Jest.MockJs.calls->Js.Array2.length)->Jest.Expect.toBe(
            0,
            _,
          )
        }
      | (_, _, _) => fail("Prepare stage failed")
      }
    })
  })

  describe("When the onLockTargetsAdd callback is passed", () => {
    let mockOnLockTargetsAddRef = ref(None)
    let scrollockCoreRef = ref(None)
    let targetElement1Ref = ref(None)

    beforeEach(() => {
      let mockOnLockTargetsAdd = Jest.JestJs.fn(_ => ())

      mockOnLockTargetsAddRef := Some(mockOnLockTargetsAdd)
      scrollockCoreRef :=
        Some(
          Core.make({
            onBodyScrollLock: None,
            onBodyScrollUnlock: None,
            onLockTargetsAdd: Some(mockOnLockTargetsAdd->Jest.MockJs.fn),
            onLockTargetsRemove: None,
          }),
        )
      targetElement1Ref := Some(Webapi.Dom.Document.createElement("div", Webapi.Dom.document))
    })

    test("Isn't called right after creation", () => {
      switch (mockOnLockTargetsAddRef.contents, scrollockCoreRef.contents) {
      | (Some(mockOnLockTargetsAdd), Some(_)) =>
        expect(mockOnLockTargetsAdd->Jest.MockJs.calls->Js.Array2.length)->Jest.Expect.toBe(0, _)
      | (_, _) => fail("Prepare stage failed")
      }
    })

    test("Is called once after lock call", () => {
      switch (
        mockOnLockTargetsAddRef.contents,
        scrollockCoreRef.contents,
        targetElement1Ref.contents,
      ) {
      | (Some(mockOnLockTargetsAdd), Some(scrollockCore), Some(targetElement1)) => {
          scrollockCore->Core.lock([targetElement1])

          expect(mockOnLockTargetsAdd->Jest.MockJs.calls->Js.Array2.length)->Jest.Expect.toBe(1, _)
        }
      | (_, _, _) => fail("Prepare stage failed")
      }
    })

    test("Is called once after lock call with multiple targetElements", () => {
      switch (
        mockOnLockTargetsAddRef.contents,
        scrollockCoreRef.contents,
        targetElement1Ref.contents,
      ) {
      | (Some(mockOnLockTargetsAdd), Some(scrollockCore), Some(targetElement1)) => {
          let targetElement2 = Webapi.Dom.Document.createElement("div", Webapi.Dom.document)

          scrollockCore->Core.lock([targetElement1, targetElement2])

          expect(mockOnLockTargetsAdd->Jest.MockJs.calls->Js.Array2.length)->Jest.Expect.toBe(1, _)
        }
      | (_, _, _) => fail("Prepare stage failed")
      }
    })

    test("Is called with provided targetElements", () => {
      switch (
        mockOnLockTargetsAddRef.contents,
        scrollockCoreRef.contents,
        targetElement1Ref.contents,
      ) {
      | (Some(mockOnLockTargetsAdd), Some(scrollockCore), Some(targetElement1)) => {
          let targetElement2 = Webapi.Dom.Document.createElement("div", Webapi.Dom.document)

          scrollockCore->Core.lock([targetElement1, targetElement2])

          expect((mockOnLockTargetsAdd->Jest.MockJs.calls)[0])->Jest.Expect.toEqual(
            [targetElement1, targetElement2],
            _,
          )
        }
      | (_, _, _) => fail("Prepare stage failed")
      }
    })

    test(
      "Is called with the only instance of targetElement if there are multiple same instances in the lock function",
      () => {
        switch (
          mockOnLockTargetsAddRef.contents,
          scrollockCoreRef.contents,
          targetElement1Ref.contents,
        ) {
        | (Some(mockOnLockTargetsAdd), Some(scrollockCore), Some(targetElement1)) => {
            scrollockCore->Core.lock([targetElement1, targetElement1])

            expect((mockOnLockTargetsAdd->Jest.MockJs.calls)[0])->Jest.Expect.toEqual(
              [targetElement1],
              _,
            )
          }
        | (_, _, _) => fail("Prepare stage failed")
        }
      },
    )

    test("Isn't called the second time if the targetElement is already locked", () => {
      switch (
        mockOnLockTargetsAddRef.contents,
        scrollockCoreRef.contents,
        targetElement1Ref.contents,
      ) {
      | (Some(mockOnLockTargetsAdd), Some(scrollockCore), Some(targetElement1)) => {
          scrollockCore->Core.lock([targetElement1])
          scrollockCore->Core.lock([targetElement1])

          expect(mockOnLockTargetsAdd->Jest.MockJs.calls->Js.Array2.length)->Jest.Expect.toBe(1, _)
        }
      | (_, _, _) => fail("Prepare stage failed")
      }
    })
  })

  describe("When the onLockTargetsRemove callback is passed", () => {
    let mockOnLockTargetsRemoveRef = ref(None)
    let scrollockCoreRef = ref(None)
    let targetElement1Ref = ref(None)

    beforeEach(() => {
      let mockOnLockTargetsRemove = Jest.JestJs.fn(_ => ())

      mockOnLockTargetsRemoveRef := Some(mockOnLockTargetsRemove)
      scrollockCoreRef :=
        Some(
          Core.make({
            onBodyScrollLock: None,
            onBodyScrollUnlock: None,
            onLockTargetsAdd: None,
            onLockTargetsRemove: Some(mockOnLockTargetsRemove->Jest.MockJs.fn),
          }),
        )
      targetElement1Ref := Some(Webapi.Dom.Document.createElement("div", Webapi.Dom.document))
    })

    test("Isn't called right after creation", () => {
      switch (mockOnLockTargetsRemoveRef.contents, scrollockCoreRef.contents) {
      | (Some(mockOnLockTargetsRemove), Some(_)) =>
        expect(mockOnLockTargetsRemove->Jest.MockJs.calls->Js.Array2.length)->Jest.Expect.toBe(0, _)
      | (_, _) => fail("Prepare stage failed")
      }
    })

    test("Is called once after unlock call", () => {
      switch (
        mockOnLockTargetsRemoveRef.contents,
        scrollockCoreRef.contents,
        targetElement1Ref.contents,
      ) {
      | (Some(mockOnLockTargetsRemove), Some(scrollockCore), Some(targetElement1)) => {
          scrollockCore->Core.lock([targetElement1])
          scrollockCore->Core.unlock([targetElement1])

          expect(mockOnLockTargetsRemove->Jest.MockJs.calls->Js.Array2.length)->Jest.Expect.toBe(
            1,
            _,
          )
        }
      | (_, _, _) => fail("Prepare stage failed")
      }
    })

    test("Is called once after unlock call with multiple targetElements", () => {
      switch (
        mockOnLockTargetsRemoveRef.contents,
        scrollockCoreRef.contents,
        targetElement1Ref.contents,
      ) {
      | (Some(mockOnLockTargetsRemove), Some(scrollockCore), Some(targetElement1)) => {
          let targetElement2 = Webapi.Dom.Document.createElement("div", Webapi.Dom.document)

          scrollockCore->Core.lock([targetElement1, targetElement2])
          scrollockCore->Core.unlock([targetElement1, targetElement2])

          expect(mockOnLockTargetsRemove->Jest.MockJs.calls->Js.Array2.length)->Jest.Expect.toBe(
            1,
            _,
          )
        }
      | (_, _, _) => fail("Prepare stage failed")
      }
    })

    test("Is called once after clear call of multiple targetElements", () => {
      switch (
        mockOnLockTargetsRemoveRef.contents,
        scrollockCoreRef.contents,
        targetElement1Ref.contents,
      ) {
      | (Some(mockOnLockTargetsRemove), Some(scrollockCore), Some(targetElement1)) => {
          let targetElement2 = Webapi.Dom.Document.createElement("div", Webapi.Dom.document)

          scrollockCore->Core.lock([targetElement1, targetElement2])
          scrollockCore->Core.clear

          expect(mockOnLockTargetsRemove->Jest.MockJs.calls->Js.Array2.length)->Jest.Expect.toBe(
            1,
            _,
          )
        }
      | (_, _, _) => fail("Prepare stage failed")
      }
    })

    test("Is called with provided targetElements to unlock", () => {
      switch (
        mockOnLockTargetsRemoveRef.contents,
        scrollockCoreRef.contents,
        targetElement1Ref.contents,
      ) {
      | (Some(mockOnLockTargetsRemove), Some(scrollockCore), Some(targetElement1)) => {
          let targetElement2 = Webapi.Dom.Document.createElement("div", Webapi.Dom.document)

          scrollockCore->Core.lock([targetElement1, targetElement2])
          scrollockCore->Core.unlock([targetElement1, targetElement2])

          expect((mockOnLockTargetsRemove->Jest.MockJs.calls)[0])->Jest.Expect.toEqual(
            [targetElement1, targetElement2],
            _,
          )
        }
      | (_, _, _) => fail("Prepare stage failed")
      }
    })

    test("Is called with all locked targetElements after clear", () => {
      switch (
        mockOnLockTargetsRemoveRef.contents,
        scrollockCoreRef.contents,
        targetElement1Ref.contents,
      ) {
      | (Some(mockOnLockTargetsRemove), Some(scrollockCore), Some(targetElement1)) => {
          let targetElement2 = Webapi.Dom.Document.createElement("div", Webapi.Dom.document)

          scrollockCore->Core.lock([targetElement1, targetElement2])
          scrollockCore->Core.clear

          expect((mockOnLockTargetsRemove->Jest.MockJs.calls)[0])->Jest.Expect.toEqual(
            [targetElement1, targetElement2],
            _,
          )
        }
      | (_, _, _) => fail("Prepare stage failed")
      }
    })

    test(
      "Is called with the only instance of targetElement if there are multiple same instances in the unlock function",
      () => {
        switch (
          mockOnLockTargetsRemoveRef.contents,
          scrollockCoreRef.contents,
          targetElement1Ref.contents,
        ) {
        | (Some(mockOnLockTargetsRemove), Some(scrollockCore), Some(targetElement1)) => {
            scrollockCore->Core.lock([targetElement1])
            scrollockCore->Core.unlock([targetElement1, targetElement1])

            expect((mockOnLockTargetsRemove->Jest.MockJs.calls)[0])->Jest.Expect.toEqual(
              [targetElement1],
              _,
            )
          }
        | (_, _, _) => fail("Prepare stage failed")
        }
      },
    )

    test("Isn't called the second time if the targetElement is already unlocked", () => {
      switch (
        mockOnLockTargetsRemoveRef.contents,
        scrollockCoreRef.contents,
        targetElement1Ref.contents,
      ) {
      | (Some(mockOnLockTargetsRemove), Some(scrollockCore), Some(targetElement1)) => {
          scrollockCore->Core.lock([targetElement1])
          scrollockCore->Core.unlock([targetElement1])
          scrollockCore->Core.unlock([targetElement1])

          expect(mockOnLockTargetsRemove->Jest.MockJs.calls->Js.Array2.length)->Jest.Expect.toBe(
            1,
            _,
          )
        }
      | (_, _, _) => fail("Prepare stage failed")
      }
    })
  })
})
