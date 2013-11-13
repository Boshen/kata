object FizzBuzz {
  def fizzbuzz(x: Int): String = x match {
    case x if x % 15 == 0 => "FizzBuzz"
    case x if x % 3 == 0 => "Fizz"
    case x if x % 5 == 0 => "Buzz"
    case x if x.toString.exists(s => s == '3' && s != '5') => "Fizz"
    case x if x.toString.exists(s => s == '5' && s != '3') => "Buzz"
    //case x if x.toString.exists(s => s=='3' && s=='5') => ???
    case _ => x.toString
  }

  def main =
    (1 to 100).foreach(x => println(fizzbuzz(x)))
}
