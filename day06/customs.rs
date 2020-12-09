use std::fs::File;
use std::io::{self, BufRead};
use std::path::Path;
use std::collections::HashMap;

fn main() {
  let mut total_yes_count = 0;

  if let Ok(lines) = read_lines("./input.txt") {
    let mut group_yeses: HashMap<char, i32> = HashMap::new();

    for line in lines {
      if let Ok(ip) = line {
        // TODO: It'd be better to break everything in here into a function like
        // "process_line(ip)" or something
        let end_of_group = ip.trim().is_empty();
        if end_of_group {
          let group_yes_count = group_yeses.keys().len();
          println!("Group yes count: {}", group_yes_count);
          total_yes_count += group_yes_count;
          group_yeses = HashMap::new();
        } else {
          // Add each character in the line to group_yeses
          let char_vec: Vec<char> = ip.chars().collect();
          for c in char_vec {
            group_yeses.insert(c, 1);
          }
        }

        println!("{}", ip);
      }
    }
    let group_yes_count = group_yeses.keys().len();
    println!("Group yes count: {}", group_yes_count);
    total_yes_count += group_yes_count; // Add the final group score
  }

  println!("{}", total_yes_count);
}

// The output is wrapped in a Result to allow matching on errors
// Returns an Iterator to the Reader of the lines of the file.
fn read_lines<P>(filename: P) -> io::Result<io::Lines<io::BufReader<File>>>
where P: AsRef<Path>, {
  let file = File::open(filename)?;
  Ok(io::BufReader::new(file).lines())
}
