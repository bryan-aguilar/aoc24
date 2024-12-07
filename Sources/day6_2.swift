class Day6_2:Day6_1{
    override var label:String {"day 6 part 2"}
    var totalParadoxes = 0

    struct Point: Hashable {
        let row: Int
        let col: Int
    }
    struct PointPartTwo: Hashable{
        let row: Int
        let col: Int
        let char: String
    }
    var previousPositionState: Dictionary<Point,Set<String>> = [:]
    var pointsVisited: Set<Point> = []

    override func markAndMove(previousPos: (Int, Int), nextPosition:(Int,Int)){
        if !isInBound(coordToCheck: nextPosition){
            return
        }

        if !(nextPosition == startingPos){
            pointsVisited.update(with: Point(row: nextPosition.0, col: nextPosition.1))
        }

        input[nextPosition.0][nextPosition.1] = input[previousPos.0][previousPos.1]
        
        markAndMove(previousPos: nextPosition, nextPosition: rotateUntilUnobstructed(position: nextPosition))
    }

    var seenInPartTwo:Set<PointPartTwo> = []
    func createsParadox(previousPos: (Int, Int), nextPosition:(Int,Int)) -> Bool{
        if !isInBound(coordToCheck: nextPosition){
            return false 
        }

        if seenInPartTwo.contains(PointPartTwo(row: nextPosition.0, col: nextPosition.1, char: input[nextPosition.0][nextPosition.1])){
            return true
        }
        
        input[nextPosition.0][nextPosition.1] = input[previousPos.0][previousPos.1]

        return createsParadox(previousPos: nextPosition, nextPosition: rotateUntilUnobstructed(position: nextPosition))

    }

    func calculateForParadoxes() throws -> Int {
        var total = 0
        for newObstruction in pointsVisited{
            defer{
                seenInPartTwo.removeAll()
            }
            input[newObstruction.row][newObstruction.col] = "#"
            total += createsParadox(previousPos: startingPos, nextPosition: startingPos).intValue
            try parseInput()
        }
        return total
    }


    override func solve() throws -> Int {
        // find all walked points
        markAndMove(previousPos: startingPos, nextPosition: startingPos)

        return try calculateForParadoxes()
    }
}