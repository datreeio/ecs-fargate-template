const Router = require('koa-router')
const router = new Router()
const healthController = require('../controllers/health')

router.get('/health', healthController.getHealth)
module.exports = router.routes()
