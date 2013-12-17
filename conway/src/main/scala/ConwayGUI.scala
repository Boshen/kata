import scala.sys.process._
import scala.swing._
import scala.swing.BorderPanel.Position._
import scala.swing.Panel
import scala.util.Random.nextInt

import java.awt.{ Color, Graphics2D }
import java.awt.geom.AffineTransform
import javax.swing.SwingUtilities
//import java.awt.event._
import scala.swing.event._

import Swing._
import Conway._

object ConwayGUI extends SimpleSwingApplication {

  def top = new MainFrame {
    val canvas = new Canvas {
      preferredSize = new Dimension(800, 800)
    }
    contents = new BorderPanel {
      layout(canvas) = Center
    }
    size = new Dimension(800, 800)
    listenTo(canvas.mouse.clicks)
    reactions += {
      case m: MouseClicked =>
        if (SwingUtilities.isLeftMouseButton(m.peer)) {
          val point = canvas.transfomer.inverseTransform(m.point, null)
          canvas.add(Cell(point.getX().toInt, point.getY().toInt))
          canvas.repaint()
        }
        if (SwingUtilities.isRightMouseButton(m.peer)) {
          canvas.run()
        }
    }
  }

  override def main(args: Array[String]): Unit = {
    Swing.onEDTWait {
      startup(args)
    }
    //while (true) {
    //  canvas.run()
    //  Thread.sleep(300)
    //}
  }
}

class Canvas extends Panel {

  val x = Seq.fill(0)(nextInt(200))
  val y = Seq.fill(0)(nextInt(200))
  var grid = Grid((x zip y).map { case (a, b) ⇒ Cell(a, b) }.toSet)
  val transfomer = new AffineTransform
  transfomer.scale(10, 10)

  override def paintComponent(g: Graphics2D) {
    super.paintComponent(g)

    g.setTransform(transfomer)

    g.setColor(Color.white)
    g.clearRect(0, 0, size.width, size.height)

    for (cell <- grid.iterator) {
      g.setColor(Color.black)
      g.fillRect(cell.x, cell.y, 1, 1)
    }

  }

  def add(c: Cell) {
    grid = grid addCell c
  }

  def run() {
    grid = Grid.next(grid)
    repaint()
  }
}
