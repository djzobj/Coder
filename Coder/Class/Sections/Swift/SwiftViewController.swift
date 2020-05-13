//
//  SwiftViewController.swift
//  Coder
//
//  Created by 张得军 on 2019/10/24.
//  Copyright © 2019 张得军. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

protocol someProtocol: NSObject {
   func testFunc()
}

extension someProtocol {
    func testFunc() {
        print("")
    }
}

public typealias Handler<T> = (T) -> ()

typealias SomeClosureType = (String) -> (Void)

class ReverseInterator<T> : IteratorProtocol {
    typealias Element = T
    var array: [Element]
    var currentIndex = 0
    
    init(array: [Element]) {
        self.array = array
        currentIndex = array.count - 1
    }
    
    func next() -> Element? {
        if currentIndex < 0 {
            return nil
        } else {
            let element = array[currentIndex]
            currentIndex -= 1
            return element
        }
    }
}

struct ReverseSquence<T>: Sequence {
    var array: [T]
    init(array: [T]) {
        self.array = array;
    }
    typealias Interator = ReverseInterator<T>
    func makeIterator() -> ReverseInterator<T> {
        return ReverseInterator(array: self.array)
    }
}

struct Vector2D {
   var x:CGFloat = 0
   var y:CGFloat = 0
    
    static func +(left:Vector2D,right:Vector2D) -> Vector2D {
       Vector2D(x: left.x + right.x, y: left.y + right.y)
    }
}

protocol Food { }

protocol Animal {
    associatedtype F: Food
    func eat(_ food: F)
}

struct Meat: Food { }

struct Grass: Food { }

struct Tiger: Animal {
    func eat(_ food: Meat) {
        
    }
}

class ClassA: NSObject {
    @objc dynamic var a = 0;
    var b: Int {
        get {
            print("get")
            return 10
        }
        set{
            print("set")
        }
    }
}

class ClassB: ClassA {
    override var b: Int {
        willSet {
           print("willSet")
        }
        didSet {
            print("didSet")
        }
    }
}

extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}

struct MyCar {
    var color = UIColor.blue
    mutating func changeColor() {
        color = UIColor.red
    }
}

class SingletonClass {
    static let shareInstance = SingletonClass();
}

class SwiftViewController: UIViewController, someProtocol {
    
    weak var delegate: someProtocol?
    var aObj: ClassB!
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white;
        aObj = ClassB()
        aObj.addObserver(self, forKeyPath: "a", options: .new, context: nil)
        aObj.a = 10
        aObj.b = 1
        escapingClosure { (data) in
            print("逃逸闭包返回结果：\(data)");
        }
        for item in ReverseSquence(array: ["x", "j", "k", "l"]) {
            print(item)
        }
        var a = 10
        inoutParam(a: &a)
        print("inout参数：\(a)")
        print("IntSubscript:\(12345678[0])")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated);
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "a" {
            print("a的值发生变化了")
        }
    }
    
    func escapingClosure(closure: @escaping (Any) -> Void) {
        DispatchQueue.global().async {
            closure("xxxxxx")
        }
    }
    
    func inoutParam(a:inout Int) {
        a = 20;
    }
    
//    func isDangerous(animal: Animal) -> Bool {
//        if animal is Tiger {
//            return true;
//        }
//        return false
//    }
    func isDangerous<T: Animal>(animal: T) -> Bool {
        if animal is Tiger {
            return true;
        }
        return false
    }
    
}
