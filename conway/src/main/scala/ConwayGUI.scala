import scala.sys.process._
import scala.swing._
import scala.swing.BorderPanel.Position._
import scala.swing.Panel
import scala.util.Random
import Swing._
import java.awt.{ Color, Graphics2D }
import java.awt.geom.AffineTransform
import event._
import util.Random.nextInt

import Conway._

object ConwayGUI extends SimpleSwingApplication {

  val canvas = new Canvas {
    preferredSize = new Dimension(800, 800)
  }

  def top = new MainFrame { // top is a required method
    contents = new BorderPanel {
      layout(canvas) = Center
    }
    size = new Dimension(800, 800)
  }

  override def main(args: Array[String]): Unit = {
    Swing.onEDTWait { startup(args) }
    while (true) {
      canvas.run()
      Thread.sleep(300)
    }
  }
}

class Canvas extends Panel {

  val x = Seq.fill(2000)(nextInt(200))
  val y = Seq.fill(2000)(nextInt(200))
  var grid = Grid((x zip y).map { case (a, b) ⇒ Cell(a, b) }.toSet)

  override def paintComponent(g: Graphics2D) {

    val transfomer = new AffineTransform
    transfomer.scale(4, 4)
    g.setTransform(transfomer)

    g.setColor(Color.white)
    g.clearRect(0, 0, size.width, size.height)

    for (cell <- grid.iterator) {
      g.setColor(Color.black)
      g.fillRect(cell.x, cell.y, 1, 1)
    }

  }

  def run() {
    grid = Grid.next(grid)
    repaint()
  }
}
