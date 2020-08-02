'use strict';
module.exports = function (app) {
  var classesList = require('../controllers/classesListControllers');

  app.route('/classes').get(classesList.IncomingClasses);
};
