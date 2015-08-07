//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by hsjay on 8/3/15.
//  Copyright (c) 2015 hsjay. All rights reserved.
//

import Foundation

class CalculatorBrain {
    private enum Op{
        //枚举类型可以和数据、操作关联起来
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
    }
    //定义栈，栈中存放的内容是Op
    //var opStack = Array<Op>()
    private var opStack = [Op]()
    
    //建立字典Dictinoary<key, Op>可以通过key值找到操作Op
    //var knowOps = Dictionary<String, Op>()
    private var knowOps = [String: Op]()
    
    init() {
        knowOps["×"] = Op.BinaryOperation("×", *)
        knowOps["÷"] = Op.BinaryOperation("÷") {$1 / $0}
        knowOps["+"] = Op.BinaryOperation("+", +)
        knowOps["-"] = Op.BinaryOperation("-") {$1 - $0}
        knowOps["√"] = Op.UnaryOperation("√", sqrt)
    }
    
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps:[Op]) {
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            println("evaluate")
            switch op {
            //case Op.Operand(<#Double#>):
            //let operate表示用operate获得值
            case .Operand(let operand):
                println("operand=\(operand)")
                return (operand, remainingOps)
                //下划线表示“我不关心这个
            case .UnaryOperation(_, let operation):
                let operationEvaluation = evaluate(remainingOps)
                if let operand = operationEvaluation.result {
                    return (operation(operand), operationEvaluation.remainingOps)
                }
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(remainingOps)
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    }
                }
            }
        }
        return (nil, ops)
    }
    
    func evaluate() -> Double? {
        let (result, remainder) : (Double?, [Op]) = evaluate(opStack)
        //let res = evaluate(opStack)
        println("result=\(result)")
        return result
    }
    
    //将操作放入栈中
    func pushOperrand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        //println("operand=\(operand)")
        return evaluate()
    }
    
    //一元运算，当输入操作符时开始计算
    func performOperation(symbol:String) -> Double? {
        if let operation = knowOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
    }
}