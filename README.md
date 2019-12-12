# AtomCrasher


## Setup

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`

## Start the Server

  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Crash the BEAM

Visit [`localhost:4000`](http://localhost:4000) and enter a positive number into the atom creation form and watch the atom count increase. 

If the server goes over the atom count (usually by more than a few) the VM will exit and dump a `erl_crash.dump` log.

The exiting process's output will look something like this...

```
no more index entries in atom_tab (max=1048576)

Crash dump is being written to: erl_crash.dump...done
```
## Setting the Atom Limit

The atom limit is settable via the `+t` erlang flag.

The Elixir command for setting the limit to 50000 atoms:

```
iex --erl "+t 50000" -S mix phx.server
```

