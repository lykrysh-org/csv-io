# csv-io

* Inserts rows from a csv file
* Outputs rows into a csv file (coming up)

> Here used a simple customer-order example **with foreign keys**.

## Dependencies

[luarocks](http://luarocks.org:8080/)<br>
[luasql](https://keplerproject.github.io/luasql/) -- GPL [licensed](https://keplerproject.github.io/luasql/license.html)<br>
Postgres with user access

## Usage

    psql -U [username] -d [databasename] -a -f create_tables.sql
    // chmod +x insert.lua
    insert.lua [data.csv] [databasename]

## Reference

[a handy tutorial](https://keplerproject.github.io/luasql/examples.html)
