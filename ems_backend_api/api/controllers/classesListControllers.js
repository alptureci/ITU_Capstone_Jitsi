var classes = require('../models/classesListModel.js');
exports.IncomingClasses = function (req, res) {
  res.json(classes.classesList);
};
