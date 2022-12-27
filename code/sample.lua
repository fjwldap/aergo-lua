import './db-1.2.0.lua'

function constructor()
  init_table()
end

function init_table()
  db.exec("create table if not exists customer(id text, passwd text, name text, birth text, mobile text)")
end

function select(id)
  local rs = db.query("select * from customer where id = ?",id)
  while rs:next() do
    local col1, col2, col3, col4, col5 = rs:get()
    local user = {
      id = col1,
      passwd = col2,
      name = col3,
      birth = col4,
      mobile = col5
    }
    return user
  end
end

function insert(id,passwd,name,birth,mobile)
  local stmt = db.prepare("insert into customer (id,passwd,name,birth,mobile) values(?,?,?,?,?)")
  stmt:exec(id,passwd,name,birth,mobile)
end

abi.register(select,insert)
