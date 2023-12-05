import Algorithms

struct Day01: AdventDay {
  var data: String

  // Split input data by line
  var entries: [String] {
    data.split(separator: "\n").compactMap { String(describing: $0) }
  }

  // Find first and last number
  func part1() -> Any {
    var sum = 0

    for entry in entries {
      var firstDigit = 0
      var lastDigit = 0

      // Iterate front to back
      for character in entry {
        if character.isNumber {
          firstDigit = Int(String(character)) ?? 0
          break
        }
      }

      // Iterate back to front
      for character in entry.reversed() {
        if character.isNumber {
          lastDigit = Int(String(character)) ?? 0
          break
        }
      }

      sum += firstDigit * 10 + lastDigit
    }

    return sum
  }

  // Find first and last number including those that are spelled out
  func part2() -> Any {
    var sum = 0

    let numberSpellingMap = [
      "one": 1,
      "two": 2,
      "three": 3,
      "four": 4,
      "five": 5,
      "six": 6,
      "seven": 7,
      "eight": 8,
      "nine": 9,
    ]

    for entry in entries {
      let firstDigit = findFirstNumber(in: entry, with: numberSpellingMap)
      let lastDigit = findFirstNumber(
        in: String(entry.reversed()), with: reverseKeys(of: numberSpellingMap))

      sum += firstDigit * 10 + lastDigit
    }

    return sum
  }

  func findFirstNumber(in entry: String, with numberSpellingMap: [String: Int]) -> Int {
    /// The idea here is to iterate by character and match it to the corresponding index of a number spelling.
    /// That index is tracked by 'spellingIndex'. The comparisons are done in a filter of a copy of the numberSpellingMap
    /// so as to 'drop' any number spellings that don't match the current sequence. Once a sequence has no matches,
    /// the code rewinds to make sure no data is skipped.

    var spellingIndex = 0
    var numberSpellings = numberSpellingMap.keys.sorted()

    for entryIndex in stride(from: 0, to: entry.count, by: 1) {
      let entryCharacter = entry[entry.index(entry.startIndex, offsetBy: entryIndex)]
      if entryCharacter.isNumber { return Int(String(entryCharacter))! }

      numberSpellings = numberSpellings.filter({
        let stringIndex = $0.index($0.startIndex, offsetBy: spellingIndex)
        return $0[stringIndex] == entryCharacter
      })

      if numberSpellings.count == 0 {
        // Repopulate no matter what
        numberSpellings = numberSpellingMap.keys.sorted()
        // Don't need to rewind if we just started counting
        if spellingIndex == 0 { continue }

        let stride = stride(from: entryIndex - (spellingIndex - 1), through: entryIndex, by: 1)
        spellingIndex = 0

        for rewindIndex in stride {
          let rewindCharacter = entry[entry.index(entry.startIndex, offsetBy: rewindIndex)]

          numberSpellings = numberSpellings.filter({
            let stringIndex = $0.index($0.startIndex, offsetBy: spellingIndex)
            return $0[stringIndex] == rewindCharacter
          })
          spellingIndex += 1
        }

        continue
      } else if numberSpellings.count == 1 && numberSpellings[0].count == spellingIndex + 1 {
        return numberSpellingMap[numberSpellings[0]]!
      }

      spellingIndex += 1
    }

    return 0
  }

  func reverseKeys<T>(of dictionary: [String: T]) -> [String: T] {
    var reversedKeyDictionary: [String: T] = [:]

    for entry in dictionary {
      reversedKeyDictionary[String(entry.key.reversed())] = entry.value
    }

    return reversedKeyDictionary
  }
}
