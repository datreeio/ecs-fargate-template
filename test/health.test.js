/* global describe it */
require('chai').should()

const app = require('../app.js')
const request = require('supertest').agent(app.callback())

describe('health', function () {
  it('health should return up', async function () {
    const res = await request.get(`/health`)
    res.text.should.equal('up')
  })
})
