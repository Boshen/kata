import org.scalatest._
import Matchers._
import org.mockito.Mockito._
import org.mockito.Matchers._

class ConwayTest extends FunSpec {
  import Conway._

  describe("Cell") {
    it("should have x, y coordinates") {
      val cell = Cell(1, 2)
      cell.x should be(1)
      cell.y should be(2)
    }
  }

  describe("Matrix") {
    it("contains a set of living cells") {
      val grid = Grid(Set(Cell(0, 0), Cell(1, 1), Cell(1, 1)))
      grid.isAlive(Cell(0, 0)) should be(true)
      grid.isAlive(Cell(1, 1)) should be(true)
      grid.isAlive(Cell(2, 2)) should be(false)
    }

    it("finds the number of alive neighbouring cells for a given cell") {
      val grid = Grid(Set(Cell(0, 0)))
      grid.neighboursCount(Cell(1, 0)) should be(1)
      grid.neighboursCount(Cell(0, 1)) should be(1)
      grid.neighboursCount(Cell(0, 0)) should be(0)
      grid.neighboursCount(Cell(2, 0)) should be(0)
      grid.neighboursCount(Cell(0, 2)) should be(0)
      val grid1 = Grid(Set(Cell(0, 0), Cell(0, 1), Cell(0, 2),
        Cell(1, 0), Cell(1, 1), Cell(1, 2),
        Cell(2, 0), Cell(2, 1), Cell(2, 2)))
      grid1.neighboursCount(Cell(1, 1)) should be(8)
    }

    it("generates all neighbours for a grid for analysis") {
      val grid = Grid(Set(Cell(0, 0), Cell(0, 1), Cell(0, 2),
        Cell(1, 0), Cell(1, 1), Cell(1, 2),
        Cell(2, 0), Cell(2, 1), Cell(2, 2)))
      Grid(Set(Cell(1, 1))).neighbours should be(grid)
    }

    it("kills a living cell when it is surrounded by less than 2 living cells") {
      Grid(Set(Cell(1, 1))).shouldLive(Cell(0, 0)) should be(false)
      Grid(Set(Cell(0, 0), Cell(1, 1))).shouldLive(Cell(0, 0)) should be(false)
    }

    it("keeps a living cell when it is surrounded by 2 or 3 living cells") {
      Grid(Set(Cell(0, 0), Cell(0, 1), Cell(1, 1))).shouldLive(Cell(0, 0)) should be(true)
      Grid(Set(Cell(0, 0), Cell(0, 1), Cell(1, 0), Cell(1, 1))).shouldLive(Cell(0, 0)) should be(true)
    }

    it("kills a living cell when it is surrounded by more than 3 living cells") {
      Grid(Set(Cell(-1, 0), Cell(0, 0), Cell(0, 1), Cell(1, 0), Cell(1, 1))).shouldLive(Cell(0, 0)) should be(false)
    }

    it("spawns a dead cell when it is surrounded by 3 living cells") {
      Grid(Set(Cell(-1, 0), Cell(0, 1), Cell(1, 0), Cell(1, 1))).shouldLive(Cell(0, 0)) should be(false)
      Grid(Set(Cell(0, 1), Cell(1, 0), Cell(1, 1))).shouldLive(Cell(0, 0)) should be(true)
    }

    it("prints the cells") {
      val grid = Grid(Set(Cell(0, 0), Cell(1, 1)))
      grid.toString should be("\no \n o")
      Grid(Set()).toString should be("")
    }

    it("sets the view") {
      val grid = Grid(Set(Cell(0, 0), Cell(1, 1)), Some(View(0,0,0,0)))
      grid.toString should be("\no")
    }
  }

  describe("Simulation") {
    it("returns a new grid after an iteration") {
      Grid.next(Grid(Set())) shouldBe a[Grid]
      val view = Some(View(0,0,0,0))
      Grid.next(Grid(Set(), view)).view should be (view)
    }

    it("goes to the next iteration") {
      val iter1 = Grid(Set(Cell(0, 0), Cell(0, 1), Cell(0, 2),
        Cell(1, 0), Cell(1, 1), Cell(1, 2),
        Cell(2, 0), Cell(2, 1), Cell(2, 2)))
      val iter2 = Grid(Set(Cell(0, 0), Cell(-1, 1), Cell(0, 2),
        Cell(1, -1), Cell(3, 1),
        Cell(2, 0), Cell(1, 3), Cell(2, 2)))
      Grid.next(iter1) should be(iter2)
    }

  }

}
