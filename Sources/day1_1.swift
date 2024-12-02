class Day1_1: IDay{
    let label = "Day 1 Part 1"

    var path = "one"
    var ll: [Int] = []
    var rl: [Int] = []

    func parseLine(_ line:String){
         let (l,r) = line.splitOnce(" ")
         ll.append(l.int)
         rl.append(r.int)
    }

    func pipeline() throws -> Int {
        try read().forEach({parseLine($0)})
        ll.sort()
        rl.sort()
        return zip(rl, ll).map({abs($0-$1)}).sum
    }

}