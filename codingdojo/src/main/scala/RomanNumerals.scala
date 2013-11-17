object RomanNumerals {

  val romanNumerals = List(1000 -> "M", 900 -> "CM", 500 -> "D",
    400 -> "CD", 100 -> "C", 90 -> "XC",
    50 -> "L", 40 -> "XL", 10 -> "X",
    9 -> "IX", 5 -> "V", 4 -> "IV", 1 -> "I")

  def convert(num: Int): String = {
    var n = num
    romanNumerals.foldLeft("") {
      case (str, (arabic, roman)) =>
        {
          val c = n / arabic;
          n = n - arabic * c;
          str + (roman * c)
        }
    }
  }

  val arabicNumerals = List("CM" -> 900, "M" -> 1000, "CD" -> 400,
    "D" -> 500, "XC" -> 90, "C" -> 100,
    "XL" -> 40, "L" -> 50, "IX" -> 9,
    "X" -> 10, "IV" -> 4, "V" -> 5, "I" -> 1)

  def convert(str: String): Int = {
    var s = str
    arabicNumerals.foldLeft(0) {
      case (num, (roman, arabic)) =>
        {
          val l = s.length;
          s = s.replaceAll(roman, "");
          val c = (l - s.length) / roman.length // Get the frequency
          num + (c * arabic) // Add the arabic numerals up  
        }
    }

  }

}
