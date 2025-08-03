const db = require('../config/db');

const addJob = async (req, res) => {
  const { title, department, location, salary } = req.body;

  if (!title || !department || !location || !salary) {
    return res.status(400).json({ message: 'All fields are required.' });
  }

  try {
    await db.query(
      'INSERT INTO jobs (title, department, location, salary) VALUES (?, ?, ?, ?)',
      [title, department, location, salary]
    );

    res.status(201).json({ message: 'Job added successfully.' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Failed to add job.' });
  }
};

const getAllJobs = async (req, res) => {
  try {
    const [jobs] = await db.query('SELECT * FROM jobs');
    res.json(jobs);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Failed to fetch jobs.' });
  }
};

module.exports = {
  addJob,
  getAllJobs,
};
