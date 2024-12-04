class Day4_1:IDay{
    var label: String {"Day 4 Part 1"}
    var path: String = "four"
    var searchKeys: [Character] { ["X","M","A","S"]}
    let up = (0,-1)
    let down = (0,1)
    let right = (1,0)
    let left = (-1,0)
    let upLeft = (-1,-1)
    let upRight = (1,-1)
    let downLeft = (-1,1)
    let downRight = (1,1)
    var input: [[String.Element]] = [[]]

    func pipeline() throws -> Int {
        var total = 0
        input = try read().map({Array($0)})
        for row in 0..<input.count{
            for col in 0..<input[0].count{
                if input[row][col] == searchKeys[0]{
                    total += search(start: (row,col), direction: up, targetIdx: 1).intValue
                    total += search(start: (row,col), direction: upLeft, targetIdx: 1).intValue
                    total += search(start: (row,col), direction: upRight, targetIdx: 1).intValue
                    total += search(start: (row,col), direction: right, targetIdx: 1).intValue
                    total += search(start: (row,col), direction: left, targetIdx: 1).intValue
                    total += search(start: (row,col), direction: down, targetIdx: 1).intValue
                    total += search(start: (row,col), direction: downRight, targetIdx: 1).intValue
                    total += search(start: (row,col), direction: downLeft, targetIdx: 1).intValue
                }
            }

        }
        return total
    }

    // targetidx should always be at least 1
    // start is the location of the previous match
    // direction is the direction we need to move
    // base cases are if targetidx is length of search keys which is success
    // or if we go out of bounds 
    func search(start:(Int,Int), direction: (Int,Int), targetIdx: Int) -> Bool{
        if targetIdx == searchKeys.count{
            return true
        }
        let targetRow = start.0 + direction.0
        let targetCol = start.1 + direction.1
        if targetRow < 0 || targetRow >= input.count{
            return false
        }
        if targetCol < 0 || targetCol >= input[0].count{
            return false
        }
        if input[targetRow][targetCol] == searchKeys[targetIdx]{
            return search(start: (targetRow,targetCol), direction: direction, targetIdx: targetIdx + 1)
        }
        return false
    }

    
}