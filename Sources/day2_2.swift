class Day2_2:IDay{
    var label: String = "Day 2 Part 2"

    var path: String = "two"

    func checkIncreasing(l: Int, r: Int) -> Bool{
        return l < r
    }

    func checkDecreasing(l: Int, r: Int) -> Bool{
        return l > r
    }

    func checkDifference(l: Int, r: Int) -> Bool{
        let diff = abs(l - r)
        return diff < 1 || diff > 3
    }

    func checkLine(input: [Int]) -> Bool{
        // check whole line before doing incremental check
        if(check(input: input)){return true}

        // brute force and check each one until one returns true
        for i in  0..<input.count{
            var inputCopy = input
            inputCopy.remove(at: i)
            if check(input: inputCopy) { return true}
        }
        return false
    }
    func check(input: [Int]) -> Bool{
        let inc = falsyCheck(input: input, falseCheck: checkIncreasing(l:r:))
        let dec = falsyCheck(input: input, falseCheck: checkDecreasing(l:r:))
        let dif = falsyCheck(input: input, falseCheck: checkDifference(l:r:))
        return (inc || dec) && dif
    }

    func falsyCheck(input: [Int], falseCheck: (Int,Int) -> Bool) -> Bool{
            for i in 1..<input.count{
                if falseCheck(input[i], input[i-1]){return false}
            }
            return true
    }

    func pipeline() throws -> Int {
        var total = 0;
        try read().forEach { line in
            let vals: [Int] = line.split(separator: " ").map({$0.stringValue.int})
            if checkLine(input: vals) {total += 1}
        }
        return total
    }
}