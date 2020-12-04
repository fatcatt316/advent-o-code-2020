class Sled:
  '''Copyright the Toboggan Co.'''

  def __init__(self, filepath, x_increment, y_increment):
    self.x_pos = 0
    self.y_pos = 0
    self.x_increment = x_increment
    self.y_increment = y_increment
    self.trees_hit = 0
    Sled.init_tree_map(self, filepath)

  def run(filepath, x_increment, y_increment):
    sled = Sled(filepath, x_increment, y_increment)

    while not sled.finished():
      sled.sled()
    return sled.trees_hit

  def sled(self):
    self.x_pos = (self.x_pos + self.x_increment) % len(self.tree_map[0])
    self.y_pos += self.y_increment

    if self.hit_tree():
      self.trees_hit += 1

  def hit_tree(self):
    return self.tree_map[self.y_pos][self.x_pos] == "#"

  def finished(self):
    return (self.y_pos + 1) == len(self.tree_map)

  def init_tree_map(self, filepath):
    self.tree_map = []

    with open(filepath) as fp:
      line = fp.readline().strip()
      while line:
        self.tree_map.append(line)
        line = fp.readline().strip()

######## TESTS
print("Test: this should be 7")
print(Sled.run('./test_input.txt', 3, 1))

print("Part 1:")
print(Sled.run('./input.txt', 3, 1))

print("Part 2:")
print(Sled.run('./input.txt', 1, 1) * Sled.run('./input.txt', 3, 1) * Sled.run('./input.txt', 5, 1) * Sled.run('./input.txt', 7, 1) * Sled.run('./input.txt', 1, 2))
