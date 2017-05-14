;;; IMPORTS
(require 'cl)

;;; INITIAL STATE

(defconst board-size 9
  "A BOARD consists of 9 squares. 
   A board's squares are arranged in a 3x3 grid.

   0 | 1 | 2 
  -----------
   3 | 4 | 5 
  -----------
   6 | 7 | 8 

  Each square has a contents. A SQUARE contents is one of:
    empty-square | player-1-square | player-2-square.")


(defconst empty-square 0
  "A zero value represents an empty (unmarked) square.")
(defconst player-1-square 1
  "The value 1 represents a square marked by player-1.")
(defconst player-2-square -1
  "The value -1 represents a square marked by player-2")

(defun make-empty-board ()
  "Returns an empty tictactoe board.
   Example: () -> (0 0 0 0 0 0 0 0 0)"
  (make-list board-size empty-square))

;;; Board -> List(List : Squares)
(defun get-rows (board)
  "Returns a list of board rows represented as lists of their square's contents.
   Example: (1 0 -1 0 1 -1 0 0 1) -> ((1 0 -1)(0 1 -1)(0 0 1))"
  (list
   (list (nth 0 board)
         (nth 1 board)
         (nth 2 board))
   (list (nth 3 board)
         (nth 4 board)
         (nth 5 board))
   (list (nth 6 board)
         (nth 7 board)
         (nth 8 board))))

;;; Board -> List(List : Squares)
(defun get-columns (board)
  "Returns a list of board columns represented as lists of their square's contents.
   Example: (1 0 -1 0 1 -1 0 0 1) -> ((1 0 0)(0 1 0)(-1 -1 1))"
  (list
   (list (nth 0 board)
         (nth 3 board)
         (nth 6 board))
   (list (nth 1 board)
         (nth 4 board)
         (nth 7 board))
   (list (nth 2 board)
         (nth 5 board)
         (nth 8 board))))

;;; Board -> List(List : Squares)
(defun get-diagonals (board)
  "Returns a list of board diagnonals represented as lists of their square's contents.
   Example: (1 0 -1 0 1 -1 0 0 1) -> ((1 1 1)(-1 1 0))"
  (list
   (list (nth 0 board)
         (nth 4 board)
         (nth 8 board))
   (list (nth 2 board)
         (nth 4 board)
         (nth 6 board))))


;;; A PLAYER is one of
;;; player-1 | player-2
(defconst player-1 #'(lambda (square) (= square player-1-square))
  "Player-1 is a function that returns true for squares marked by player-1")
(defconst player-2 #'(lambda (square) (= square player-2-square))
  "Player-1 is a function that returns true for squares marked by player-2")


;;; TERMINAL STATES
;;; A finished game is one of:
;;; drawn-game | player-1-wins | player-2-wins


(defun map-player-squares (player get-squares board)
  "A utility function. Given a board representation, maps true to the squares marked by a player.
     Player (Board -> List(List : Squares)) Board ->  List(List : Boolean)
  Example: 
     (map-player-squares player-1 
                         #'get-diagonals 
                        '(1 0 -1 0 1 -1 0 0 1)) 
     -> ((t t t)
         (nil t nil))
"
  (mapcar #'(lambda (x)
              (mapcar player x))
          (funcall get-squares board)))
       
(defun winning-squares (map)
  "A utility function. Given a mapping of true to a player's squares over a board representation returns true if there is a winning condtion.
    List(List : Boolean) -> List Boolean
  Example:
    (winning-squares '((t t t)(nil t nil))) -> t"
  (mapcar #'(lambda (list)
              (every #'identity list))map))

;;; Player Board -> Boolean
(defun winner-p (player board)
  "Returns true if the player has won.
   Example: (winner-p player-1 '(1 0 -1 0 1 -1 0 0 1)) -> t"
  (let
      ((rows
        (map-player-squares player
                             #'get-rows
                             board))
       (columns
        (map-player-squares player
                             #'get-columns
                             board))
       (diagonals
        (map-player-squares player
                             #'get-diagonals
                             board)))
    (or (some #'identity
              (winning-squares rows))
        (some #'identity
              (winning-squares columns))
        (some #'identity
              (winning-squares diagonals)))))

;;; Board -> Boolean
(defun all-squares-filled-p (board)
  "Utility Function. Returns true if no squares are empty.
   Example: (all-squares-filled-p '(1 0 -1 0 1 -1 0 0 1))) -> nil"
  (not (some #'zerop board)))


;;; TERMINAL TEST
(defun game-over-p (board)
  "Example: (game-over-p '(1 0 -1 0 1 -1 0 0 1))) -> 'player-1-wins
   Example: (game-over-p (make-empty-board)) -> nil"
  (cond
   ((winner-p player-1 board) 'player-1-wins)
   ((winner-p player-2 board) 'player-2-wins)
   ((all-squares-filled-p board) 'draw)))

;;; OPERATORS

(defun player-1-choose-square (board)
  "Board -> Board"
  (insert "Status: It is Player-1's turn\n")
  (let* ((empty-squares (find-empty-squares board))
         (message (concat "Player-1 choose square: "
                          (prin1-to-string empty-squares)
                          " : "))
         (choice (read-string message)))
    (setf (nth (read choice) board) player-1-square))
  board)

(defun player-2-choose-square (board)
  "Board -> Board"
  (insert "Status: It is Player-2's turn\n")
  (let* ((empty-squares (find-empty-squares board))
         (message (concat "Player-2 choose square: "
                          (prin1-to-string empty-squares)
                          " : "))
         (choice (read-string message)))
    (setf (nth (read choice) board) player-2-square))
  board)

(defun find-empty-squares (board)
  "Utility function. Returns a list of indexes to a board's empty squares.
   Board -> List:number[0-8]
   Example: (find-empty-squares (make-empty-board))
            -> (0 1 2 3 4 5 6 7 8)
   Example: (find-empty-squares '(1 0 -1 0 1 -1 0 0 1)
            -> (1 3 6 7)"
  (let ((i 0)
        (acc))
    (dolist (element board acc)
      (if (= 0 (nth i board))
          (push i acc))
      (setq i (+ i 1)))
    (reverse acc)))

;;; GAME LOOP
(defun tictactoe-play ()
  (let ((game-outcome (tictactoe-main (make-empty-board))))
    (cond
     ((eq game-outcome 'player-1-wins)
      (insert "Game Over: Player-1 Wins"))
     ((eq game-outcome 'player-2-wins)
       (insert "Game Over: Player-2 Wins"))
     ((eq game-outcome 'draw)
       (insert "Game Over: It is a draw")))
       game-outcome))

(defun tictactoe-main (board)
  (board->text board)
  (if (game-over-p board)
      (game-over-p board)
    (let
        ((board-sum (apply #'+ board)))
      (cond
       ((= board-sum 0)
         (tictactoe-main (player-1-choose-square board)))
       ((= board-sum 1)
        (tictactoe-main (player-2-choose-square board)))))))


;;; USER INTERFACE

(defun square->text (square index)
  "Utility function. Converts a square to the correct text value."
  (cond
   ((eq square -1) " o ")
   ((eq square 1)  " x ")
   (t (concat " " (prin1-to-string index) " "))))

(defun row->text (row i)
  "Utility function. Converts board row to its text representation"
  (concat
   (square->text (nth 0 row) i)
   "|"
   (square->text (nth 1 row) (+ i 1))
   "|"
   (square->text (nth 2 row) (+ i 2))))

(defun board->text (board)
  "Utility function. Converts a board to its text representation."
  (let* ((brd (get-rows board))
         (separator "\n-----------\n")
         (row1 (row->text (nth 0 brd) 0))
         (row2 (row->text (nth 1 brd) 3))
         (row3 (row->text (nth 2 brd) 6)))
    (erase-buffer)
    (insert "Playing TicTacToe\n\n")
    (insert row1)
    (insert separator)
    (insert row2)
    (insert separator)
    (insert row3)
    (insert "\n\n")))

(defun setup ()
  (get-buffer-create "tictactoe")
  (set-buffer "tictactoe"))
