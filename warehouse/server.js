// นำเข้าโมดูลที่ต้องการ
require('dotenv').config(); // โหลดตัวแปรจากไฟล์ .env
const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const cors = require('cors');
const jwt = require('jsonwebtoken'); // นำเข้า jsonwebtoken

// สร้างแอปพลิเคชัน Express
const app = express();
app.use(cors());
app.use(bodyParser.json());

// เชื่อมต่อกับ MongoDB
const MONGO_URI = process.env.MONGO_URI; // ใช้ตัวแปร MONGO_URI จากไฟล์ .env

mongoose.connect(MONGO_URI, {

})
.then(() => console.log('MongoDB connected successfully'))
.catch(err => console.error('Error connecting to MongoDB:', err));

// สร้าง schema และ model สำหรับผู้ใช้
const userSchema = new mongoose.Schema({
  username: { type: String, unique: true },
  password: String,
});

const User = mongoose.model('User', userSchema);

// API สำหรับสมัครสมาชิก
app.post('/signup', async (req, res) => {
  try {
    const { username, password } = req.body;
    // ตรวจสอบว่าผู้ใช้มีอยู่แล้วหรือไม่
    const existingUser = await User.findOne({ username });
    if (existingUser) {
      return res.status(400).send('Username already exists');
    }
    const newUser = new User({ username, password });
    await newUser.save();
    res.status(200).send('User signed up successfully');
  } catch (err) {
    console.error('Error signing up user:', err);
    res.status(500).send('Error signing up user');
  }
});

// API สำหรับล็อกอิน
app.post('/login', async (req, res) => {
  try {
    const { username, password } = req.body;
    const user = await User.findOne({ username, password });
    if (!user) {
      return res.status(401).send('Invalid username or password');
    }
    // สร้าง JWT token
    const token = jwt.sign({ username: user.username }, process.env.JWT_SECRET, { expiresIn: '1h' });
    res.json({ token });
  } catch (err) {
    console.error('Error logging in:', err);
    res.status(500).send('Error logging in');
  }
});

// Middleware เพื่อตรวจสอบ JWT token
const verifyToken = (req, res, next) => {
  const token = req.headers['authorization'];
  if (!token) return res.status(403).send('No token provided');
  jwt.verify(token, process.env.JWT_SECRET, (err, decoded) => {
    if (err) return res.status(500).send('Failed to authenticate token');
    req.user = decoded; // ใช้ decoded payload ในการจัดการข้อมูลผู้ใช้
    next();
  });
};

// API สำหรับดึงข้อมูลผู้ใช้ทั้งหมด
app.get('/users', async (req, res) => {
    try {
      const users = await User.find({});
      res.status(200).json(users);
    } catch (err) {
      console.error('Error fetching users:', err);
      res.status(500).send('Error fetching users');
    }
  });

// Route ที่ป้องกันโดย JWT
app.get('/protected', verifyToken, (req, res) => {
  res.status(200).send('This is a protected route');
});

// เริ่มต้นเซิร์ฟเวอร์
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
