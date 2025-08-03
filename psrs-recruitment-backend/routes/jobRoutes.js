const express = require('express');
const router = express.Router();
const {
  addJob,
  getAllJobs,
} = require('../controllers/jobController');

const { authenticateToken, authorizeRoles } = require('../middleware/authMiddleware');

// Add job — only admin/editor
router.post('/', authenticateToken, authorizeRoles('admin', 'editor'), addJob);

// Get all jobs — public
router.get('/', getAllJobs);

module.exports = router;
