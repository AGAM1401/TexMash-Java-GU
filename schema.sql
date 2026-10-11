-- ═══════════════════════════════════════════════════════════════════
-- TexMash Database Schema (H2 / MySQL / PostgreSQL Compatible)
-- ═══════════════════════════════════════════════════════════════════

-- Drop existing tables to ensure clean state
DROP TABLE IF EXISTS user_mates;
DROP TABLE IF EXISTS mate_requests;
DROP TABLE IF EXISTS post_likes;
DROP TABLE IF EXISTS post_hashtags;
DROP TABLE IF EXISTS posts;
DROP TABLE IF EXISTS users;

-- 1. Users Table
CREATE TABLE users (
    id VARCHAR(100) PRIMARY KEY,
    password_hash VARCHAR(255) NOT NULL,
    display_name VARCHAR(100) NOT NULL,
    avatar_url VARCHAR(255) NOT NULL,
    role VARCHAR(20) DEFAULT 'STUDENT',
    created_at BIGINT NOT NULL
);

-- 2. Posts Table (Anonymous Thoughts)
CREATE TABLE posts (
    id VARCHAR(64) PRIMARY KEY,
    author_id VARCHAR(100) NOT NULL,
    content VARCHAR(500) NOT NULL,
    created_at BIGINT NOT NULL,
    CONSTRAINT fk_posts_author FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 3. Post Hashtags Table
CREATE TABLE post_hashtags (
    id INT AUTO_INCREMENT PRIMARY KEY,
    post_id VARCHAR(64) NOT NULL,
    tag VARCHAR(50) NOT NULL,
    CONSTRAINT fk_hashtags_post FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE
);
CREATE INDEX idx_hashtags_tag ON post_hashtags(tag);

-- 4. Post Likes ("Relate") Table
CREATE TABLE post_likes (
    post_id VARCHAR(64) NOT NULL,
    user_id VARCHAR(100) NOT NULL,
    created_at BIGINT NOT NULL,
    PRIMARY KEY (post_id, user_id),
    CONSTRAINT fk_likes_post FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
    CONSTRAINT fk_likes_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 5. Mate Requests Table (Pending Friend Invitations)
CREATE TABLE mate_requests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id VARCHAR(100) NOT NULL,
    receiver_id VARCHAR(100) NOT NULL,
    status VARCHAR(20) DEFAULT 'PENDING',
    created_at BIGINT NOT NULL,
    CONSTRAINT fk_matereq_sender FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_matereq_receiver FOREIGN KEY (receiver_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT uq_sender_receiver UNIQUE (sender_id, receiver_id)
);

-- 6. User Mates Table (Established Bidirectional Connections)
CREATE TABLE user_mates (
    user_id VARCHAR(100) NOT NULL,
    mate_id VARCHAR(100) NOT NULL,
    created_at BIGINT NOT NULL,
    PRIMARY KEY (user_id, mate_id),
    CONSTRAINT fk_mates_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_mates_mate FOREIGN KEY (mate_id) REFERENCES users(id) ON DELETE CASCADE
);
