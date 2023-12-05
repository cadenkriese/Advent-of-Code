import XCTest

@testable import AdventOfCode

final class Day01Tests: XCTestCase {
  // Test data provided, with a large number added after since they did not cover all the edge cases
  let testData = """
    1abc2
    pqr3stu8vwx
    a1b2c3d4e5f
    treb7uchet
    one2
    eightwo
    oneight
    61ppgrkmkfhteightone
    7sixsevenrfour
    jfz1
    ninembtmtkgbctlfive45cjzzrmgcscfbcgeight
    two1nine
    eightwothree
    abcone2threexyz
    xtwone3four
    4nineeightseven2
    zoneight234
    7pqrstsixteen
    thvdkddeerhteerhtmhjrfgvdhneveslvkldvznmbzptflowt1
    foneight3fsbhdqzr5twojbsdnntwohd9seven
    rgxjrsldrfmzq25szhbldzqhrhbjpkbjlsevenseven
    """

  func testPart1() throws {
    let challenge = Day01(data: testData)
    XCTAssertEqual(challenge.part1() as! Int, 642)
  }

  func testPart2() throws {
    let challenge = Day01(data: testData)
    XCTAssertEqual(challenge.part2() as! Int, 834)
  }
}
