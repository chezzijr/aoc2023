use std::collections::HashSet;
use std::env;
use std::fs;

fn part1(input: &str) {
    let sum: i32 = input
        .lines()
        .map(|line| {
            let v: Vec<&str> = line
                .split_whitespace()
                .filter(|&token| token == "|" || token.parse::<i32>().is_ok())
                .collect();
            let mut flag: bool = false;
            let mut num: i32 = 0;
            let mut visited: HashSet<&str> = HashSet::new();
            for token in v {
                if token == "|" {
                    flag = true;
                } else {
                    if !flag {
                        visited.insert(token);
                    } else if visited.contains(token) {
                        if num == 0 {
                            num = 1;
                        } else {
                            num *= 2;
                        }
                    }
                }
            }
            num
        })
        .sum();
    println!("Part 2: {:?}", sum);
}

fn part2(input: &str) {
    let num_lines: usize = input.lines().count();
    let mut occ = vec![1; num_lines as usize];
    for (i, line) in input.lines().enumerate() {
        let v: Vec<&str> = line
            .split_whitespace()
            .filter(|&token| token == "|" || token.parse::<usize>().is_ok())
            .collect();
        let mut flag: bool = false;
        let mut num: usize = 0;
        let mut visited: HashSet<&str> = HashSet::new();
        for token in v {
            if token == "|" {
                flag = true;
            } else {
                if !flag {
                    visited.insert(token);
                } else if visited.contains(token) {
                    num += 1;
                }
            }
        }
        for j in 1..=num {
            if i + j < num_lines {
                occ[i + j as usize] += occ[i];
            }
        }
    }
    let sum: i32 = occ.iter().sum();
    println!("Part 1: {:?}", sum);
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let contents = fs::read_to_string(args[1].clone()).expect("Error reading file");
    part1(&contents);
    part2(&contents);
}
