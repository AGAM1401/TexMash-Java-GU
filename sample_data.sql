-- ═══════════════════════════════════════════════════════════════════
-- TexMash Sample Data Seed Script (Clean Feed)
-- ═══════════════════════════════════════════════════════════════════

-- Seed Users for Login / Testing (Password: 'password123' for all accounts)
INSERT INTO users (id, password_hash, display_name, avatar_url, role, created_at) VALUES
('alex.21scse1010001@galgotiasuniversity.ac.in', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'Silent Wolf 427', 'https://api.dicebear.com/7.x/bottts/svg?seed=alex', 'STUDENT', 1700000000000),
('priya.22scse1010002@galgotiasuniversity.ac.in', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'Neon Hawk 819', 'https://api.dicebear.com/7.x/bottts/svg?seed=priya', 'STUDENT', 1700000100000),
('rahul.23scse1010003@galgotiasuniversity.ac.in', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'Cosmic Nova 105', 'https://api.dicebear.com/7.x/bottts/svg?seed=rahul', 'STUDENT', 1700000200000),
('tanya.21scse1010004@galgotiasuniversity.ac.in', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'Glitch Nexus 903', 'https://api.dicebear.com/7.x/bottts/svg?seed=tanya', 'STUDENT', 1700000300000);

-- Seed Mutual Mate Connection (Alex and Priya)
INSERT INTO user_mates (user_id, mate_id, created_at) VALUES
('alex.21scse1010001@galgotiasuniversity.ac.in', 'priya.22scse1010002@galgotiasuniversity.ac.in', 1700000500000),
('priya.22scse1010002@galgotiasuniversity.ac.in', 'alex.21scse1010001@galgotiasuniversity.ac.in', 1700000500000);

-- Seed Pending Mate Request (Rahul to Alex)
INSERT INTO mate_requests (sender_id, receiver_id, status, created_at) VALUES
('rahul.23scse1010003@galgotiasuniversity.ac.in', 'alex.21scse1010001@galgotiasuniversity.ac.in', 'PENDING', 1700000600000);
