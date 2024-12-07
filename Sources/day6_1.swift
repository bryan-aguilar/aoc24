class Day6_1:IDay{
    var label: String {"Day 6 Part 1"}
    var path: String {"six"}
    var startingPos: (Int,Int) = (0,0)
    var input: [[String]] = [[]]
    var instructions = [
        ("^", Directions.up), 
        (">", Directions.right),
        ("v", Directions.down),
        ("<", Directions.left)
    ]

    func solve() throws -> Int{
        markAndMove(previousPos: startingPos , nextPosition: startingPos)
        return findUnique()
    }

    func findStartingPosition(){
        for row in 0..<input.count{
            for col in 0..<input[0].count{
                switch input[row][col]{
                    case "^","<",">","v":
                        startingPos = (row,col)
                    default:
                        continue
                }
            }
        }
    }

    func findUnique() -> Int{
        var total = 0
        input.forEach({line in 
            for char in line{
                switch char {
                    case "^","<",">","v":
                        total += 1
                    default:
                        total += 0
                }
            }
        })
        return total
    }


    func isObstructed(position: (Int,Int)) -> Bool{
        if !isInBound(coordToCheck: position) {
            return false
        }
        if input[position.0][position.1] == "#"{
            return true
        }
        
        return false
    }

    // returns next position to move to 
    func rotateUntilUnobstructed(position: (Int,Int)) -> (Int,Int){
        if !isInBound(coordToCheck: position) {
            fatalError()
        }
        repeat{
            switch input[position.0][position.1]{
                case "^":
                    if isObstructed(position: position + Directions.up){
                        input[position.0][position.1] = ">"
                    }else{
                        return position + Directions.up
                    }
                case ">":
                    if isObstructed(position: position + Directions.right){
                        input[position.0][position.1] = "v"
                    }else{
                        return position + Directions.right
                    }
                case "v":
                    if isObstructed(position: position + Directions.down){
                        input[position.0][position.1] = "<"
                    }else{
                        return position + Directions.down
                    }
                case "<":
                    if isObstructed(position: position + Directions.left){
                        input[position.0][position.1] = "^"
                    }else{
                        return position + Directions.left
                    }
                default:
                    fatalError("we shouldn't hit this")
            }
        }while true
    }

    func isInBound(coordToCheck: (Int,Int)) -> Bool{
        if coordToCheck.0 < 0 || coordToCheck.0 >= input.count{
            return false
        }
        if coordToCheck.1 < 0 || coordToCheck.1 >= input[0].count{
            return false
        }
        return true
    }

    func markAndMove(previousPos: (Int, Int), nextPosition:(Int,Int)){
        if !isInBound(coordToCheck: nextPosition){
            return
        }else{
            input[nextPosition.0][nextPosition.1] = input[previousPos.0][previousPos.1]
        }
        markAndMove(previousPos: nextPosition, nextPosition: rotateUntilUnobstructed(position: nextPosition))
    }

    func parseInput() throws{
        try read().forEach({
            input.append($0.split(separator: "").map({String($0)}))
        })
        // probably a better way to do this but lets just remove the default empty array
        input.removeFirst()
    }

    func pipeline() throws -> Int {
        try parseInput()
        findStartingPosition()
        return try solve()
    }


}