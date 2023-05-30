//
//  ViewController.swift
//  Multithreading_13 GCD Dispatch Barrier
//
//  Created by Дмитрий Гусев on 30.05.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

//        var array = [Int]()
//
//        for i in 0...9 {
//            array.append(i)
//        }
//        print(array)
//        print(array.count)

        
//        var array = [Int]()
//
//        DispatchQueue.concurrentPerform(iterations: 10) { index in
//            array.append(index)
//        }
//        print(array)
//        print(array.count)
        
        
        let arraySafe = SafeArray<Int>()
        
        DispatchQueue.concurrentPerform(iterations: 10) { index in
            arraySafe.append(index)
        }
        
        print(arraySafe.valueArray)

    }


}

class SafeArray<T> {
    private var array = [T]()
    private let queue = DispatchQueue(label: "The Swift Developer", attributes: .concurrent)
    
    
    public func append(_ value: T ) {
        queue.async(flags: .barrier) {
            self.array.append(value)
        }
    }
    
    public var valueArray: [T] {
        var result = [T]()
        
        queue.sync {
            result = self.array
        }
        
        return result
    }
}
