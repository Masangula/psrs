const db = require('../config/db');

const getLocationPriorityScore = (location) => {
  if (location.toLowerCase() === 'remote') return 3;
  if (location.toLowerCase() === 'dar es salaam') return 2;
  return 1;
};

const applyToJob = async (req, res) => {
  const { name, email, job_id, resume } = req.body;

  if (!name || !email || !job_id || !resume) {
    return res.status(400).json({ message: 'All fields are required.' });
  }

  try {
    // Check for duplicate
    const [existing] = await db.query(
      'SELECT * FROM applications WHERE email = ? AND job_id = ?',
      [email, job_id]
    );
    if (existing.length > 0) {
      return res.status(409).json({ message: 'You have already applied to this job.' });
    }

    // Fetch job location
    const [jobRows] = await db.query('SELECT * FROM jobs WHERE id = ?', [job_id]);
    const job = jobRows[0];
    if (!job) return res.status(404).json({ message: 'Job not found.' });

    // Calculate scores
    const resume_score = Math.floor(Math.random() * 10) + 1;
    const location_score = getLocationPriorityScore(job.location);
    const final_score = resume_score + location_score;

    // Insert application
    await db.query(
      `INSERT INTO applications
      (name, email, resume, job_id, resume_score, location_score, final_score)
      VALUES (?, ?, ?, ?, ?, ?, ?)`,
      [name, email, resume, job_id, resume_score, location_score, final_score]
    );

    res.status(201).json({
      message: 'Application processed successfully.',
      summary: {
        name,
        position: job.title,
        resume_score,
        location_score,
        final_score,
      },
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Application failed.' });
  }
};

const getAllApplications = async (req, res) => {
  try {
    const [rows] = await db.query(`
      SELECT 
        a.name AS candidate_name,
        a.email,
        j.title AS job_title,
        j.location,
        a.resume_score,
        a.location_score,
        a.final_score
      FROM applications a
      JOIN jobs j ON a.job_id = j.id
    `);

    res.json(rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Failed to fetch applications.' });
  }
};

module.exports = {
  applyToJob,
  getAllApplications,
};
