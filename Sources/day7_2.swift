class Day7_2:Day7_1{
    override var label: String {"Day 7 part 2"}

    override func recursivecheck(targetResult: Int, values:[Int], runningTotal:Int, nextValueIdx: Int) -> Bool{
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
        
        let concat = String(runningTotal) + String(values[nextValueIdx])
        return recursivecheck(targetResult: targetResult, values: values, runningTotal: runningTotal + values[nextValueIdx], nextValueIdx: nextValueIdx+1) ||
                recursivecheck(targetResult: targetResult, values: values, runningTotal: runningTotal * values[nextValueIdx], nextValueIdx: nextValueIdx+1) ||
                recursivecheck(targetResult: targetResult, values: values, runningTotal: concat.int, nextValueIdx: nextValueIdx+1)

    }
}