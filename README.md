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

## Benchmarks

Both benchmarks run the same setup with the same DB data.

* `bundle exec ruby script/n_plus_m_benchmark_ips.rb` - runs N+M queries
* `bundle exec ruby script/single_queries_benchmark_ips.rb` - runs many small queries

### Setup

* MacBook Air M2
* macOS
* PostgreSQL v16 - _now configured to use the Unix socket, instead of the TCP socket default_
* SQLite 3.46.1

Both databases had:

* over 350 "Stuff" entries
* each had 12_000 "Comment" entries
* each had 5 "Reaction" entries

### N+M queries benchmark results 2024-10-16 - WARNING: _without indices_

Benchmark settings:

```
@stuff_limit = 20
@comment_limit = 10
@reactions_limit = 3
```

Result: _script/n_plus_m_benchmark_ips.rb_

```log
$> bundle exec ruby script/n_plus_m_benchmark_ips.rb

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

Run it multiple times as I could not believe _how large_ the difference is. **See below why that is.**

### Results 2024-10-19 with indices on the foreign keys

Same N+M queries benchmark as above.

> @rickychilcott pointed out that running this benchmark without indices on the foreign keys makes it rather unrealistic. Though, I only planned on doing a "stupid simple" benchmark, I thought he was right. And I am delighted about the results and feel a bit ashamed sharing the index-less version before.

_Adapted_ Benchmark settings:

* @stuff_limit = 200 _(10x)_
* @comment_limit = 500 _(50x)_
* @reactions_limit = 3 _(same)_

Result: _script/n_plus_m_benchmark_ips.rb_

```log
$> bundle exec ruby script/n_plus_m_benchmark_ips.rb

ruby 3.3.5 (2024-09-03 revision ef084cc8f4) [arm64-darwin23]
Warming up --------------------------------------
           postgres:     1.000 i/100ms
             sqlite:     1.000 i/100ms
Calculating -------------------------------------
           postgres:      0.018 (± 0.0%) i/s    (54.22 s/i) -      1.000 in  54.218976s
             sqlite:      0.031 (± 0.0%) i/s    (31.95 s/i) -      1.000 in  31.951276s

Comparison:
             sqlite::        0.0 i/s
           postgres::        0.0 i/s - 1.70x  slower
```

**That does not look as bad as the first very naive benchmark.**

Using the original bennchmark settings (but with indices) the difference was even smaller (only 1.54x slower).

### Many small queries benchmark results 2024-10-20

Result: _script/single_queries_benchmark_ips.rb_

```log
$> bundle exec ruby script/single_queries_benchmark_ips.rb

ruby 3.3.5 (2024-09-03 revision ef084cc8f4) [arm64-darwin23]
Warming up --------------------------------------
             sqlite:     1.000 i/100ms
           postgres:     1.000 i/100ms
Calculating -------------------------------------
             sqlite:      1.373 (± 0.0%) i/s  (728.42 ms/i) -      7.000 in   5.103646s
           postgres:      0.872 (± 0.0%) i/s     (1.15 s/i) -      5.000 in   5.734892s

Comparison:
             sqlite::        1.4 i/s
           postgres::        0.9 i/s - 1.57x  slower
```
