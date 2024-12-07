import Algorithms

class Day7_1:IDay{
    var label: String {"Day 7 Part 1"}

    var path: String { "seven"}
    var results: [Int] = []
    var values: [[Int]] = []

    func parseInput() throws{
        try read().forEach({line in
            let resultValue = line.splitOnce(":")
            results.append(resultValue.0.int)
            values.append(resultValue.1.split(separator: " ").map({$0.stringValue.int}))
        })
    }
    func pipeline() throws -> Int {
        try parseInput()
        return solveAttempt2()
    }


    func solveAttempt2() -> Int{
        var total = 0
        for i in 0..<results.count{
            let result = results[i]
            var values = values[i]
            let firstValue = values.removeFirst()
            if recursivecheck(targetResult: result, values: values, runningTotal: firstValue, nextValueIdx: 0) {
                total += result
            }
        }
        return total
    }

    // I'm going to leave this in here because everyone should see that I tried the very brute force solution first.
    // ...this did not work and was taking way way way too long.
    func solve() -> Int{
        var total = 0
        lineLoop: for i in 0..<results.count{
            print("on \(i)")
            let result = results[i]
            let values = values[i]
            let permutations = createPermutations(withCount: values.count-1)

            // check min value greater than result
            let minValue = values.reduce(0) { partialResult, next in
                partialResult + next
            }
            if minValue > result {continue}
            if minValue == result {total += result; continue;}

            // // check max < result
            let maxValue = values.reduce(1) { partialResult, next in
                partialResult * next
            }
            if maxValue < result{ continue }
            if maxValue == result{total += result; continue;}

            permCheck: for perm in permutations{
                var runningTotal = values[0]
                for j in 1..<values.count{
                    switch perm[j-1]{
                        case "+":
                            runningTotal += values[j]
                        case "*":
                            runningTotal *= values[j]
                        default:
                            fatalError("this shouldn't happen")
                    }
                    if runningTotal > result{
                        continue permCheck
                    }
                }
                if result == runningTotal{
                    total += result
                    break permCheck
                }
            }
        }

        return total
    }

    func recursivecheck(targetResult: Int, values:[Int], runningTotal:Int, nextValueIdx: Int) -> Bool{
        // base cases
        // if greater than expected result
        if runningTotal > targetResult{
            return false
        }
        if(nextValueIdx == values.count){
            if targetResult == runningTotal{
                return true
            }else{
                return false
            }
        }

        // what do we want to do
        // recurisve call return running total
        // return recurse(runningTotal + nextValue, nextValueIdx++) || return recurse(runningTotal * nextValue, nextValueIdx)
        // 
        return recursivecheck(targetResult: targetResult, values: values, runningTotal: runningTotal + values[nextValueIdx], nextValueIdx: nextValueIdx+1) ||
                recursivecheck(targetResult: targetResult, values: values, runningTotal: runningTotal * values[nextValueIdx], nextValueIdx: nextValueIdx+1)

    }



    func createPermutations(withCount: Int) -> Set<[String]>{
        var combos: [String] = []
        for i in 0..<withCount{
            combos.append("+")
        }
        for i in 0..<withCount{
            combos.append("*")
        }
        var comboSet: Set<[String]> = []
        combos.permutations(ofCount: withCount).forEach({ comboSet.update(with: $0)})
        return comboSet
    }


}