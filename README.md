# README

* Ruby 3.3.5
* Rails 8.0.0-beta1
* SQLite3
* PostgreSQL

> Rails 8 was used "out of the box" without any extra tweaks or optimizations.

## Installation

* `git clone`
* `bundle install`
* `bin/rails db:create`
* `bin/rails db:migrate`
* `bin/rails db:seeds` _(maybe adjust the amount first, the seeds run rather slow)_

## Benchmark

Both benchmarks run the same code - which does lots of N+M queries - but format the output differntly:

* `bundle execute ruby script/benchmark.rb`
* `bundle execute ruby script/benchmark_ips.rb`

### Results 2024-10-16

* MacBook Air M2
* macOS
* PostgreSQL v16
* SQLite 3.46.1

Both databases had:

* over 350 "Stuff" entries
* each had 12_000 "Comment" entries
* each had 5 "Reaction" entries

Benchmark settings:

```
@stuff_limit = 20
@comment_limit = 10
@reactions_limit = 3
```

Result: _script/benchmark.rb_

```log
$> bundle exec ruby script/benchmark.rb

           user       system     total     real
postgres:  0.737008   0.161267   0.898275  (270.334925)
sqlite:    5.057899   0.094649   5.152548  (  5.480717)
```

Result: _script/benchmark_ips.rb_

```log
$> bundle exec ruby script/benchmark_ips.rb

ruby 3.3.5 (2024-09-03 revision ef084cc8f4) [arm64-darwin23]
Warming up --------------------------------------
           postgres:     1.000 i/100ms
             sqlite:     1.000 i/100ms
Calculating -------------------------------------
           postgres:      0.004 (± 0.0%) i/s   (281.05 s/i) -      1.000 in 281.047595s
             sqlite:      0.192 (± 0.0%) i/s     (5.21 s/i) -      1.000 in   5.208491s

Comparison:
             sqlite::        0.2 i/s
           postgres::        0.0 i/s - 53.96x  slower
```

Run it multiple times as I could not believe _how large_ the difference is.
