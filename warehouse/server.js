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

// สร้าง schema และ model สำหรับพัสดุ
const parcelSchema = new mongoose.Schema({
  category: String,
  item: String,
  quantity: Number,
  user: String, // เก็บ username ของผู้ที่บันทึกพัสดุ
});

const Parcel = mongoose.model('Parcel', parcelSchema);

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
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1]; // รับ token จาก header ที่ส่งมาในรูปแบบ Bearer <token>

  if (!token) return res.status(403).send('No token provided');

  jwt.verify(token, process.env.JWT_SECRET, (err, decoded) => {
    if (err) return res.status(500).send('Failed to authenticate token');
    req.user = decoded; // เก็บข้อมูลผู้ใช้ที่ถูก decode จาก token
    next();
  });
};

// API สำหรับดึงข้อมูลผู้ใช้ทั้งหมด (ป้องกันด้วย JWT)
app.get('/users', verifyToken, async (req, res) => {
  try {
    const users = await User.find({});
    res.json(users); // ส่งข้อมูลผู้ใช้กลับไปยัง client
  } catch (err) {
    res.status(500).send('Error fetching users');
  }
});

// API สำหรับเพิ่มพัสดุ
app.post('/add-parcel', verifyToken, async (req, res) => {
  try {
    const { category, item, quantity } = req.body;

    // ตรวจสอบว่าข้อมูลครบถ้วน
    if (!category || !item || quantity == null) {
      return res.status(400).send('กรุณากรอกข้อมูลให้ครบถ้วน');
    }

    // ค้นหาพัสดุที่มีอยู่แล้วในฐานข้อมูล
    let parcel = await Parcel.findOne({ category, item, user: req.user.username });

    if (parcel) {
      // หากพัสดุมีอยู่แล้วในระบบ เพิ่มจำนวนพัสดุ
      parcel.quantity += quantity;
    } else {
      // หากพัสดุไม่มีในระบบ สร้างพัสดุใหม่
      parcel = new Parcel({
        category,
        item,
        quantity,
        user: req.user.username
      });
    }

    // บันทึกการเปลี่ยนแปลงในฐานข้อมูล
    await parcel.save();

    res.status(200).send('เพิ่มพัสดุสำเร็จ');
  } catch (err) {
    console.error('Error adding parcel:', err);
    res.status(500).send('Error adding parcel');
  }
});


// API สำหรับดึงข้อมูลพัสดุทั้งหมด (ป้องกันด้วย JWT)
app.get('/parcels', verifyToken, async (req, res) => {
  try {
    // ดึงพัสดุทั้งหมดที่ถูกบันทึก
    const parcels = await Parcel.find({});
    res.json(parcels); // ส่งข้อมูลพัสดุกลับไปยัง client
  } catch (err) {
    res.status(500).send('Error fetching parcels');
  }
});

// API สำหรับเบิกพัสดุ
app.post('/requisition-parcel', verifyToken, async (req, res) => {
  try {
    const { category, item, quantity } = req.body;

    // ตรวจสอบว่าข้อมูลครบถ้วน
    if (!category || !item || !quantity) {
      return res.status(400).send('กรุณากรอกข้อมูลให้ครบถ้วน');
    }

    // ค้นหาพัสดุที่ตรงตามเงื่อนไข
    const parcels = await Parcel.find({ category, item });
if (parcels.length === 0) {
  return res.status(404).send('ไม่พบพัสดุ');
}

// จัดการกับรายการพัสดุที่ค้นพบ
for (const parcel of parcels) {
  if (parcel.quantity >= quantity) {
    parcel.quantity -= quantity;
    await parcel.save(); // อัปเดตพัสดุ
    res.status(200).send('เบิกพัสดุสำเร็จ');
    return;
  } else {
    // หากพัสดุในรายการนี้มีจำนวนไม่เพียงพอ
    quantity -= parcel.quantity;
    parcel.quantity = 0;
    await parcel.save(); // อัปเดตพัสดุ
  }
}

    // หากจำนวนพัสดุที่ต้องการมากเกินกว่าที่มีอยู่
    res.status(400).send('จำนวนพัสดุไม่เพียงพอ');
  } catch (err) {
    console.error('Error requisitioning parcel:', err);
    res.status(500).send('Error requisitioning parcel');
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
