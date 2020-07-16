import assert from 'assert';
import http from 'http';
import server from '../lib/index.js';

describe('Example Node Server', () => {
  it('should return 200', done => {
    http.get('http://localhost:3000', res => {
      console.log('res', res.statusCode);
      assert.equal(200, res.statusCode);
      server.close();
      done();
    });
  });
});
