class Day3_2:IDay{
    let label: String = "Day 3 part 2"
    let path = "three";
    let fullPattern = /(mul\(\d\d?\d?,\d\d?\d?\)|don't\(\)|do\(\))/
    let dontPattern = /don't\(\)/
    let doPattern = /do\(\)/
    let mulPattern = /mul\((\d\d?\d?),(\d\d?\d?)\)/

    func pipeline() throws -> Int {

        var doDont = true
        return try read().reduce(0,{runningTotal, line in 
        runningTotal + line.matches(of: fullPattern).reduce(0,{linetotal, match in 
            if match.output.0.firstMatch(of: doPattern) != nil {
                doDont = true
                return linetotal
            }
            if match.output.0.firstMatch(of: dontPattern) != nil {
                doDont = false
                return linetotal
            }
            if let m = match.output.0.firstMatch(of: mulPattern){
                if doDont{
                    return linetotal + (m.output.1.stringValue.int * m.output.2.stringValue.int)
                }else{
                    return linetotal
                }
            }
            return linetotal
        })})
    }   
}