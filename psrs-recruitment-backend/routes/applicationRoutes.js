const express = require('express');
const router = express.Router();
const {
  applyToJob,
  getAllApplications,
} = require('../controllers/applicationController');

const { authenticateToken } = require('../middleware/authMiddleware');

// Anyone logged in can apply
router.post('/', authenticateToken, applyToJob);

// Only admin/editor can view all applications (optional)
router.get('/', authenticateToken, getAllApplications);

module.exports = router;
