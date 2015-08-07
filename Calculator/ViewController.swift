//
//  ViewController.swift
//  Calculator
//
//  Created by hsjay on 8/2/15.
//  Copyright (c) 2015 hsjay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber: Bool = false
    
    var brain = CalculatorBrain()

    //从数字键盘中获取数字，并显示在UILabel变量display中
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit;
        }
        else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }

    //定义函数，用于点击＋、—、＊、／符号时的事件处理
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result;
            } else {
                displayValue = 0
            }
        }
        /*
        switch operation {
        //swift支持直接传递函数
        case "×": performOperation(multiply)
        //将函数放在行式参数的位置，这种方法叫做闭包
        case "÷": performOperation({(op1: Double, op2: Double) -> Double in
            return op2 / op1
            })
        //swift支持类型推断，可以不指定参数类型
        case "+": performOperation({(op1, op2) in return op1 + op2 })
        //swift可以识别函数需要返回值，可以去掉return关键词
        case "−": performOperation({(op1, op2) in op2 - op1 })
        //swift还可以自动为参数命名，可以不用参数列表
        case "÷": performOperation({ $1 / $0 })
        //如果performOperation的参数最后一个是函数，则函数可以写在括号外面，其他参数在括号内
        case "÷": performOperation() { $1 / $0 }
        //如果只有一个参数，可以连括号都不要
        case "÷": performOperation { $1 / $0 }
        case "√": performOperation { sqrt($0) }
        default:break
        }*/
    }
/*
    //定义函数，函数的参数是另一个函数，括号中是函数的参数类型，箭头后是返回值类型
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast() , operandStack.removeLast())
            enter()
        }
    }
    
    private func performOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }

    func multiply(op1: Double, op2: Double) -> Double {
        return op1 * op2
    }
*/
    //按下enter键，读取用户输入的数据到数组operandStack中
    //var operandStack : Array<Double> = Array<Double>()
//    var operandStack = Array<Double>()
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        println("nnnmm")
        if let result = brain.pushOperrand(displayValue) {
            displayValue = result
            println("displayValue=\(displayValue)")
        } else {
            displayValue = 0
        }
        
//        operandStack.append(displayValue)
//        println("operandStack=\(operandStack)")
    }
    
    var displayValue : Double {
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            //userIsInTheMiddleOfTypingANumber = false
        }
    }
}

