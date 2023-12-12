import Algorithms

struct Day02: AdventDay {
  var data: String

  // Split input data by line
  var entries: [String] {
    data.split(separator: "\n").compactMap { String(describing: $0) }
  }
  
  let gameNumberPattern = /Game (\d+): ((?:\d+ (?:blue|red|green)(?:, |; |))+)/
  let cubePullPattern = /(\d+) (blue|red|green)/

  // Find games that are possible given the maximums
  func part1() -> Any {
    let maxRed = 12
    let maxGreen = 13
    let maxBlue = 14
    
    var possibleGameSum = 0
    
    for entry in entries {
      if let wholeMatch = entry.wholeMatch(of: gameNumberPattern) {
        var possibleGame = true
        let gameNumber = Int(wholeMatch.1)!
        for match in entry.matches(of: cubePullPattern) {
          let amount = Int(match.1)!
          let color = match.2
          
          if amount > maxRed && color == "red" {
            possibleGame = false
            break
          }
          if amount > maxGreen && color == "green" {
            possibleGame = false
            break
          }
          if amount > maxBlue && color == "blue" {
            possibleGame = false
            break
          }
        }
        
        if possibleGame {
          possibleGameSum += gameNumber
        }
      }
    }
    
    return possibleGameSum
  }

  func part2() -> Any {
    var powerSum = 0
    
    for entry in entries {
      var minRed = 0
      var minGreen = 0
      var minBlue = 0
      
      let matchTuples = entry.matches(of: cubePullPattern).map { (Int($0.1)!, String($0.2)) }
      
      // Filter by color and then find the maximum number value in the first column
      minRed = matchTuples.filter({$0.1 == "red"}).max(by: {$0.0 < $1.0})!.0
      minGreen = matchTuples.filter({$0.1 == "green"}).max(by: {$0.0 < $1.0})!.0
      minBlue = matchTuples.filter({$0.1 == "blue"}).max(by: {$0.0 < $1.0})!.0
      
      powerSum += minRed*minGreen*minBlue
    }
    
    return powerSum
  }
}
