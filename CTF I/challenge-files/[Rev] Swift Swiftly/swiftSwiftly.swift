print("Enter secret password: ")
let userInput : String = readLine()!
let startIndex = userInput.index(userInput.startIndex, offsetBy:"flag{".count)
let endIndex = userInput.index(userInput.endIndex, offsetBy: -2)
let input = userInput[startIndex...endIndex]
if (checkPassword(password:String(input))) {
    print("Access granted.")
} else {
    print("Access denied!")
}

// You'll never be able to crack this password! After all, I never typed it out...

func checkPassword(password:String) -> Bool {
    let arr = Array(password)
    return password.count == 31 &&
      arr[0]  == "s" &&
      arr[29] == "o" &&
      arr[4]  == "t" &&
      arr[2]  == "i" &&
      arr[23] == "r" &&
      arr[3]  == "f" &&
      arr[17] == "a" &&
      arr[1]  == "w" &&
      arr[7]  == "s" &&
      arr[10] == "w" &&
      arr[5]  == "_" &&
      arr[9]  == "a" &&
      arr[11] == "e" &&
      arr[15] == "e" &&
      arr[8]  == "_" &&
      arr[12] == "s" &&
      arr[20] == "_" &&
      arr[14] == "m" &&
      arr[6]  == "i" &&
      arr[24] == "a" &&
      arr[18] == "n" &&
      arr[13] == "o" &&
      arr[19] == "d" &&
      arr[21] == "a" &&
      arr[16] == "_" &&
      arr[27] == "_" &&
      arr[30] == "o" &&
      arr[25] == "y" &&
      arr[22] == "r" &&
      arr[28] == "t" &&
      arr[26] == "s"
}
