import Foundation

class Day5_1:IDay{
    var label: String { "Day 5 Part 1"}

    var path: String = "five"
    var rules: Dictionary<String, Set<String>> = [:]
    var updates: [[String]] = [[]]
    let rulePattern = /(\d\d\|\d\d)/

    func pipeline() throws -> Int {
        try parseInput()
        return solve()
    }

    func solve() -> Int{
        var total = 0
        updates.forEach { update in
            if checkValid(input: update){
                total += update[update.count / 2].int
            }
        }
        return total
    }

    func checkValid(input: [String]) -> Bool{
        var previouslySeen: Set<String> = []
        for currentValue in input{
            if let exists = rules[currentValue]{
                let intersectSet = previouslySeen.intersection(exists)
                
                if(intersectSet.count > 0){
                    return false
                }
            }
            previouslySeen.update(with: currentValue)
        }
        return true
    }

    func parseInput() throws{
        try read().forEach { line in
            if line.contains(rulePattern){
                let parts = line.split(separator: "|").map({String($0)})
                if var currentRules = rules[parts[0]] {
                    currentRules.update(with: parts[1])
                    rules[parts[0]] = currentRules
                }else{
                    rules[parts[0]] = [parts[1]]
                }
            }else{
                updates.append(line.split(separator: ",").map({String($0)}))
            }
        }
        updates = updates.filter({$0.count != 0})
    }


}