import io.Source
object Main extends App {
  val longs = Source.stdin.getLines().flatMap(
    _.split(" ").filter(!_.isEmpty).map(_.toLong)).toArray
  println(longs.reverse.map(t => "%.4f".format(math.sqrt(t))).mkString("\n"))
}
