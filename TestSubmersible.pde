/**
 * Test submersible that can be used to test the game.
 */
class TestSubmersible extends Submersible {
  private boolean sonarCompleted;
  private int dCol;
  private int dRow;
  private int lateralMove;

  /**
   * Creates a new test submersible.
   *
   * @param name the name of the new submersible
   * @param col the column of the submersible
   * @param row the row of the submersible
   */
  public TestSubmersible(String name, int col, int row) {
    super(name, col, row);
    this.sonarCompleted = false;
    this.dCol = 0;
    this.dRow = 1;
    this.lateralMove = 0;
  }

  /**
   * @override
   */
  public ElementRequest update() {
    if (this.sonarCompleted) {
      this.sonarCompleted = false;
      return new MoveRequest(dCol, dRow);
    } else {
      this.sonarCompleted = true;
      return new SonarRequest();
    }
  }

  /**
   * @override
   */
  public void reportSonarResults(IReadonlyCell[][] scanResults) {
    if (this.lateralMove != 0) {
      this.dCol = 0;
      this.dRow = this.lateralMove;
      this.lateralMove = 0;
    } else if (scanResults[1][2] == null) {
      this.lateralMove = -1;
      this.dCol = 1;
      this.dRow = 0;
    } else if (scanResults[1][0] == null) {
      this.lateralMove = 1;
      this.dCol = 1;
      this.dRow = 0;
    }


    for (int colIndex = 0; colIndex < scanResults.length; colIndex++) {
      for (int rowIndex = 0; rowIndex < scanResults[colIndex].length; rowIndex++) {
        IReadonlyCell cell = scanResults[colIndex][rowIndex];
        if (cell != null) {
          print(" (" + colIndex + ", " + rowIndex + ") " + cell.hasPlayer());
        } else {
          print (" (" + colIndex + ", " + rowIndex + ") NA   ");
        }
      }
      println("");
    }
    println("--");
  }
}
