class Day2_1:IDay{
    var label: String = "Day 2 Part 1"

    var path: String = "two"

    func checkIncreasing(input: String) -> Bool{
        let vals = input.split(separator: " ")
        for i in 1..<vals.count{
            if String(vals[i]).int <= String(vals[i-1]).int {return false}
        }
        return true
    }

    func checkDecreasing(input: String) -> Bool{
        let vals = input.split(separator: " ")
        for i in 1..<vals.count{
            if String(vals[i]).int >= String(vals[i-1]).int {return false}
        }
        return true
    }

    func checkDifference(input: String) -> Bool{
                let vals = input.split(separator: " ")
        for i in 1..<vals.count{
            let diff = abs(String(vals[i]).int - String(vals[i-1]).int)
            if(diff < 1 || diff > 3) {return false};
        }
        return true
    }

    func pipeline() throws -> Int {
        var total = 0;
        try read().forEach { line in
            if(checkIncreasing(input: line) || checkDecreasing(input: line)) && checkDifference(input: line){
                total += 1
            }
        }
        return total
    }
}