# REST API PERFORMANCE

## Introduction

Over the last year I have written REST APIs with various technologies and wanted to compare some of them. I created 5 identical clients with Elysia, Express, Rocket, Phoenix and Flask. I tested them on the simplest endpoint `/get` which returns a `"Hello World"` text message.

Each tested locally on a 2023 Macbook Air M2.

I used [Ali](https://github.com/nakabonne/ali) for generating 10000 requests per second for each client.

## Technologies

### Node, JavaScript, Express

- Node: 20.5.1
- Express: 4.18.2

### Bun, TypeScript, Elysia

- Bun: 1.0.18
- Elysia: 0.7.30

### Python, Flask, Bjoern

- Python: 3.11.5
- Flask: 3.0.0
- Bjoern: 3.2.2

### Rust, Rocket

- Rust: 1.74.0
- Rocket: 0.5.0

### Erlang, Elixir, Phoenix

- Erlang: 26
- Elixir: 1.15.7
- Phoenix: 1.7.10

## Test details

Each test was run for 10 minutes with 10000 requests per second which approximately sums up to 6 000 000 requests in total.

|             | status code 200 | status code 0 | success rate | total latency |
| ----------- | --------------- | ------------- | ------------ | ------------- |
| **rocket**  | 5999993         | 7             | 0,99999883   | 12m 12s       |
| **elysia**  | 5999949         | 51            | 0,99999150   | 17m 41s       |
| **flask**   | 5999852         | 148           | 0,99997533   | 21m 54s       |
| **phoenix** | 5998778         | 1222          | 0,99979633   | 20m 50s       |
| **express** | 5998840         | 1159          | 0,99980683   | 32m 5s        |

Above are the most interesting results from all the runs. You can see whole reports in `/reports`

### Rust

Rust with Rocket is clearly and unsurprisingly a winner. Rocket still is quite some time away from the 1.0 release but it already should be production ready.

### JS/TS Bun Node

It is worth noting that technically Elysia and Express are both JavaScript frameworks, the main difference is with runtimes used to run the code. BunJS is a modern JS/TS runtime for which Elysia is optimized for. Express traditionally is run on NodeJS.

With Express ran on Bun we can see that it's Bun doing most of the heavy-lifting:

|                  | status code 200 | status code 0 | success rate | total latency |
| ---------------- | --------------- | ------------- | ------------ | ------------- |
| **elysia**       | 5999949         | 51            | 0,99999150   | 17m 41s       |
| **bun express**  | 5999657         | 343           | 0,99994283   | 20m 19s       |
| **node express** | 5998840         | 1159          | 0,99980683   | 32m 5s        |

### Python

How is Python that fast? It isn't, Bjoern is a WSGI server written with C. I tried running Flask with Waitress first, a WSGI server recommended by the Flask team in the official docs, but the results were stunningly bad:

|                    | status code 200 | status code 0 | success rate | total latency |
| ------------------ | --------------- | ------------- | ------------ | ------------- |
| **flask bjoern**   | 5999852         | 148           | 0,99997533   | 21m 54s       |
| **flask waitress** | 5927382         | 72618         | 0,98789700   | 17h 8m 8s     |

### Elixir

Phoenix has been a disappointment on every side. It didn't deliver with stability nor speed. It is a REST framework, but it is designed for fullstack web applications. Generating a bare REST project is cumbersome and not very effective in the end (as you can see by comparing the language chart in this repo, Elixir projects are bloated).

To generate a regular phoenix project the following command is used:
`mix phx.new`

I had to use this one:
`mix phx.new --no-ecto --no-assets --no-dashboard --no-html --no-live --no-mailer`

It might work great for bigger projects but for this experiment it was an overkill.
