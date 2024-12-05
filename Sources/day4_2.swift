class Day4_2:Day4_1{
    override var label:String {"Day 4 part 2"}
    let MAS = "MAS"
    let SAM = "SAM"


    override func pipeline() throws -> Int {
        var total = 0
        input = try read().map({Array($0)})
        // search inner bounds only since its an X
        for row in 1..<input.count-1{
            for col in 1..<input[0].count-1{
                if input[row][col] == "A"{
                    total += check(source: (row,col)).intValue
                }
            }

        }
        return total
    }

    func check(source: (Int, Int)) -> Bool{
        let s1 = String(input[source.0 + upLeft.0][source.1+upLeft.1]) + String(input[source.0][source.1]) +  String(input[source.0 + downRight.0][source.1 + downRight.1])
        let s2 = String(input[source.0 + upRight.0][source.1+upRight.1]) + String(input[source.0][source.1]) + String(input[source.0 + downLeft.0][source.1 + downLeft.1])
        if (s1 == MAS || s1 == SAM) && (s2 == MAS || s2 == SAM){
            return true
        }
        return false
    }
}