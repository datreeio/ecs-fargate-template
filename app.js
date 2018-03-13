const routes = require('./routes')
const bodyParser = require('koa-bodyparser')
const Koa = require('koa')
const app = new Koa()

app.use(bodyParser())
app.use(routes)

module.exports = app
