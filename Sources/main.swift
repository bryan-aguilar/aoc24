// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation


let input = getInput(day: "one.txt")!

let lines = input.components(separatedBy: "\n")
var left: [Int] = []
var right: [Int] = []


for line in lines{
    let nums = line.components(separatedBy: "   ")
    let l = NumberFormatter().number(from: nums[0])
    let r = NumberFormatter().number(from: nums[1])
    if let l = l?.intValue{
        left.append(l)
    }else{
        fatalError()
    }
    if let r = r?.intValue{
        right.append(r)
    }else{
        fatalError()
    }
}

d1p2(left: left, right: right)




func getInput(day: String) -> String?{
    let resourceDirStr = FileManager.default.currentDirectoryPath + "/resources/"
    let curdir = URL(fileURLWithPath: resourceDirStr + day)
    do{
        let fileContents = try String(contentsOf: curdir)
        return fileContents
    }catch{
        print(error)
    }
    return nil
}

func d1p1(left: [Int], right: [Int]){
    var left = left
    var right = right
    left.sort()
    right.sort()
    var total = 0;
    for i in 0..<left.count{
        total += abs(left[i] - right[i])
    }
    //print("d1p1: \(total)")
}

func d1p2(left: [Int], right:[Int]){
    let left = left.sorted();
    let right = right.sorted()

    var rightDic : Dictionary<Int, Int> = [:]
    for value in right{
        if let curCount = rightDic[value]{
            rightDic[value] = curCount + 1
        }else{
            rightDic[value] = 1
        }
    }
    var total = 0;
    for value in left{
        if let numAppearances = rightDic[value]{
            total += (value * numAppearances)
        }
    }
    print(total)
}
