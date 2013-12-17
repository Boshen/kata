import scala.sys.process._
import util.Random.nextInt
import akka.actor.{ Actor, ActorSystem, Props }

object Conway {

  case class Cell(x: Int, y: Int)
  case class View(minx: Int, miny: Int, maxx: Int, maxy: Int)

  object Grid {
    def next(grid: Grid): Grid =
      Grid(grid.neighbours.iterator.filter(grid.shouldLive(_)).toSet, grid.view)
  }

  case class Grid(private val cells: Set[Cell], view: Option[View] = None) {

    def addCell(other: Cell): Grid =
      Grid(cells + other, view)

    def isAlive(cell: Cell): Boolean =
      cells contains cell

    def iterator =
      cells.iterator

    def neighboursCount(cell: Cell): Int =
      cells.filterNot { c ⇒
        (c.x == cell.x && c.y == cell.y) ||
          math.abs(c.x - cell.x) > 1 ||
          math.abs(c.y - cell.y) > 1
      }.size

    def neighbours: Grid = {
      def block1D(i: Int) =
        List(i - 1, i, i + 1)

      def block2D(p: Cell) =
        for (x ← block1D(p.x); y ← block1D(p.y)) yield Cell(x, y)

      Grid((cells flatMap block2D).toSet)
    }

    def shouldLive(cell: Cell): Boolean = {
      (isAlive(cell), neighboursCount(cell)) match {
        case (true, 2 | 3) ⇒ true
        case (true, _) ⇒ false
        case (false, 3) ⇒ true
        case (false, _) ⇒ false
      }
    }

    override def toString = {
      if (cells.isEmpty)
        ""
      else {
        val minx = if (view.isEmpty) cells.minBy(_.x).x else view.get.minx
        val maxx = if (view.isEmpty) cells.maxBy(_.x).x else view.get.maxx
        val miny = if (view.isEmpty) cells.minBy(_.y).y else view.get.miny
        val maxy = if (view.isEmpty) cells.maxBy(_.y).y else view.get.maxy

        val sb = StringBuilder.newBuilder
        for (x ← minx to maxx) {
          sb.append("\n")
          for (y ← miny to maxy)
            sb.append(if (this isAlive Cell(x, y)) "o" else " ")
        }
        sb.toString
      }
    }
  }

  case class Run(grid: Grid)
  class Simulator extends Actor {
    def receive = {
      case Run(oldGrid) ⇒
        val newGrid = Grid.next(oldGrid)
        if (oldGrid.toString == newGrid.toString) {
          println(newGrid)
          println("Stable state. Press any key to abort!")
          context.system.shutdown()
        } else {
          "clear".!
          println(newGrid)
          Thread.sleep(200)
          self ! Run(newGrid)
        }
    }
  }

  def main(args: Array[String]) {
    val system = ActorSystem("Conway")
    val simulator = system.actorOf(Props(classOf[Simulator]), "Simulator")
    val x = Seq.fill(200)(nextInt(30))
    val y = Seq.fill(200)(nextInt(30))
    val view = Some(View(0, 0, 10, 10))
    val grid = Grid((x zip y).map { case (a, b) ⇒ Cell(a, b) }.toSet, view)
    simulator ! Run(grid)
    readLine()
    system.shutdown()
  }

b
