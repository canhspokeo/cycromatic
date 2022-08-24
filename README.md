# Cycromatic

Cycromatic calculates cyclomatic complexity of Ruby programs.

* Cyclomatic Complexity - https://en.wikipedia.org/wiki/Cyclomatic_complexity

## Usage

Ideally you should cd to directory that contains ruby files to be calculated. 

Run `cycromatic` command to calculate complexity:

```
$ <path_to_root_dir_of_this_repo>/cycromatic ruby_program.rb -o results.html   # Specify paths to .rb files
$ <path_to_root_dir_of_this_repo>/cycromatic dir1 [dir2 ...] -o results.html   # Specify directory/directories including .rb files
```

`-o results.html` will output an `results.html` file in the executing directory. 

You can specify `--open` to open the `results.html` file when it's done.

## Calculation

It calculates complexities as the following:

* Basic block have complexity of 1 (base case)
* Branching construct have complexity of 1
* Loop construct have complexity of 1
* `&&` and `||` have complexity of 1
* Safe navigation operator have complexity of 1
* Passing iterator block does not introduce complexity

## Note
This is a modification of [cycromatic](https://github.com/soutaro/cycromatic) gem.
