var exec = require('cordova/exec');

exports.echo = function(success, error) {
  exec(success, error, 'DetectTestFlight', 'echo', []);
};
