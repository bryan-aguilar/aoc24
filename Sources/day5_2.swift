class Day5_2:Day5_1{
    override var label:String {"Day 5 Part 2"}

    override func solve() -> Int {
        var total = 0
        updates.forEach { update in
            if !checkValid(input: update){
                total += fixPage(input: update)
            }
        }
        return total 
    }

    func fixPage(input: [String]) -> Int{
        var input = input
        var beforeValues: Set<String> = []
        var index = 0;
        while index < input.count{
            if let rulesExist = rules[input[index]]{
                let intersect = beforeValues.intersection(rulesExist)
                if intersect.count > 0{
                    // we need to swap current idx with idx - 1
                    // remove values from before value of idx - 1
                    let left = input[index-1]
                    let current = input[index]
                    input[index - 1] = current
                    input[index] = left
                    beforeValues.remove(left)
                    index = index - 1
                    // we need to check from the previous index again in this case. Do not incremement move straight to go
                    continue
                }else{
                 beforeValues.update(with: input[index])
                }
            }else{
                beforeValues.update(with: input[index])
            }
            index += 1
        }
        if !checkValid(input: input) {
            print("woah something went wrong")
        }
        // return middle value
        return input[input.count/2].int
    }


}