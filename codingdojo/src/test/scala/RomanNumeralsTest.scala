import org.scalatest._
import RomanNumerals._

class RomanNumeralsTest extends FunSpec {

    val tests = List(1 -> "I", 2 -> "II", 3 -> "III",
      4 -> "IV", 5 -> "V", 6 -> "VI",
      7 -> "VII", 8 -> "VIII", 9 -> "IX",
      10 -> "X", 49 -> "XLIX", 50 -> "L",
      99 -> "XCIX", 100 -> "C", 400 -> "CD",
      900 -> "CM", 1000 -> "M", 2679 -> "MMDCLXXIX")

  describe("Arabic to Roman Numerals") {

    it("no conversion for non-positive numbers") {
      assert(convert(0) == "")
      assert(convert(-1) == "")
    }

    tests.foreach { case (k, v) =>
        it(s"convert $k to $v") {
          assert(convert(k) == v)
        }
    }

  }

  describe("Roman Numerals to Arabic") {

    tests.foreach { case (k, v) =>
        it(s"convert $v to $k") {
          assert(convert(v) == k)
        }
    }

  }

}
