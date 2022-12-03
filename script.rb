#class for the whole board game
class Game
  attr_accessor :child_nodes, :coordinates, :parent

  def initialize(coordinates, goal_square, parent = nil, child_nodes = [], board = draw_board)
    @coordinates = coordinates
    @goal_square = goal_square
    @parent = parent
    @child_nodes = child_nodes
    @child_nodes.push([@coordinates[0] + 1, @coordinates[1] + 2],[@coordinates[0] - 1, @coordinates[1] + 2],[@coordinates[0] + 1, @coordinates[1] - 2],[@coordinates[0] - 1, @coordinates[1] - 2],[@coordinates[0] + 2, @coordinates[1] + 1],[@coordinates[0] + 2, @coordinates[1] - 1],[@coordinates[0] - 2, @coordinates[1] + 1],[@coordinates[0] - 2, @coordinates[1] - 1])
    @child_nodes.select! { |child_node| board.include?(child_node) }
  end

  def draw_board
    array = [0,1,2,3,4,5,6,7]
    board = []
    array.each do |num|
      array.each do |n|
        square = [num,n]
        board.push(square)
      end
    end
    board
  end

  def knight_moves(queue = [self], board = draw_board)
    return "You're already there" if @coordinates == @goal_square

    return 'Invalid positions' unless board.include?(@coordinates) && board.include?(@goal_square)

    cur_square = queue.shift
    return display_path(cur_square) if cur_square.child_nodes.include?(@goal_square)

    cur_square.child_nodes.each do |child_node|
      child = Game.new(child_node, @goal_square, cur_square)
      queue.push(child)
    end
    knight_moves(queue)
  end

  def display_path(node, num_of_edges = 1, array = [])
    loop do
      array.unshift(node.coordinates)
      node = node.parent
      break if node.nil?

      num_of_edges += 1
    end
    puts "You made it in #{num_of_edges} moves! Here's your path:"
    array.each { |square| p square }
    p @goal_square
  end
end
new_game = Game.new([0,0],[7,7])
new_game.knight_moves