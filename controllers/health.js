async function getHealth (ctx, next) {
  ctx.body = 'up'
}

module.exports = {
  getHealth
}
