class day3_1:IDay{
    var label: String = "Day 3 Part 1"

    var path: String = "three"
    
    func pipeline() throws -> Int {
        let pattern: Regex<(Substring, Substring, Substring)> = /mul\((\d\d?\d?),(\d\d?\d?)\)/
        let input = try read();
        return input.reduce(0,{total, inputLine in
            total + inputLine.matches(of: pattern).reduce(0, {x,y in
             x + (y.output.1.stringValue.int * y.output.2.stringValue.int)
             })
        })
    }

    
}