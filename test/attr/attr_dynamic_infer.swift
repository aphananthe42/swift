// RUN: %swift-ide-test -print-ast-typechecked -source-filename=%s -print-implicit-attrs | FileCheck %s

@objc class Super {}

// CHECK: extension Super {
extension Super {
  // CHECK:  @objc dynamic func foo
  func foo() { }

  // CHECK: @objc dynamic var prop: Super
  var prop: Super {
    // CHECK: @objc dynamic get
    get { return Super() }
    // CHECK: @objc dynamic set
    set { }
  }

  // CHECK: @objc dynamic subscript (sup: Super) -> Super
  subscript (sup: Super) -> Super {
    // CHECK: @objc dynamic get
    get { return sup }
    // CHECK: @objc dynamic set
    set { }
  }
}


@objc class Sub : Super { }

// CHECK: extension Sub
extension Sub {
  // CHECK: @objc override final func foo
  override func foo() { }

  // CHECK: @objc override final var prop: Super
  override var prop: Super {
    // CHECK: @objc override final get
    get { return Super() }
    // CHECK: @objc override final set
    set { }
  }

  // CHECK: @objc override final subscript (sup: Super) -> Super
  override subscript (sup: Super) -> Super {
    // CHECK: @objc override final get
    get { return sup }
    // CHECK: @objc override final set
    set { }
  }
}
