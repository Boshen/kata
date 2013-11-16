import org.scalatest._
import FizzBuzz._

class FizzBuzzTest extends FunSpec {

  describe("Fizz Buzz") {

    it("non-multiples of 3 and 5") {
      def sieve(s: Stream[Int]): Stream[Int] = {
        s.head #:: sieve(s.tail.filter(_ % s.head != 0))
      }

      val primes = sieve(Stream.from(2))
      for (i <- primes.take(10).toList)
        if (!i.toString.exists(s => s == '3' || s == '5'))
          assert(fizzbuzz(i) == i.toString)
    }

    it("multiples of 3 but not 15") {
      for (i <- Range(3, 301, 3))
        if (i % 15 != 0)
          assert(fizzbuzz(i) == "Fizz")
    }

    it("multiples of 5 but not 15") {
      for (i <- Range(5, 501, 5))
        if (i % 15 != 0)
          assert(fizzbuzz(i) == "Buzz")
    }

    it("multiples of 15 only") {
      for (i <- Range(15, 1501, 15))
        if (i % 3 != 0 && i % 5 != 0)
          assert(fizzbuzz(i) == "FizzBuzz")
    }

    it("has 3 in digit") {
      for (i <- List(103, 23, 34))
        assert(fizzbuzz(i) == "Fizz")
    }

    it("has 5 in digit") {
      for (i <- List(151, 59, 752))
        assert(fizzbuzz(i) == "Buzz")
    }

  }

  /* 
   * The new requirements:
   * A number is fizz if it is divisible by 3 or if it has a 3 in it
   * A number is buzz if it is divisible by 5 or if it has a 5 in it
   * cannot be met because numbers that contain both 3 and 5 can either be fizz or buzz
  */

  /*
  describe("has both 3 and 5 in digit") {
    for ( i <- List(53, 957653) )
      assert(fizzbuzz(i) == i.toString)
  }
  */
}
