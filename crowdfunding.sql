CREATE TABLE Role (
    role_id INT PRIMARY KEY,
    role_name VARCHAR(50) UNIQUE
);

CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(150) UNIQUE,
    password_hash VARCHAR(255),
    role_id INT,
    is_verified BOOLEAN,
    created_at TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES Role(role_id)
);

CREATE TABLE User_Profile (
    profile_id INT PRIMARY KEY,
    user_id INT UNIQUE,
    bio TEXT,
    profile_photo_url TEXT,
    country VARCHAR(100),
    status VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) UNIQUE,
    description TEXT
);

CREATE TABLE Campaign (
    campaign_id INT PRIMARY KEY,
    user_id INT,
    category_id INT,
    title VARCHAR(255),
    description TEXT,
    goal_amount DECIMAL(12,2),
    raised_amount DECIMAL(12,2),
    deadline DATE,
    status VARCHAR(50),
    created_at TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

CREATE TABLE Reward_Tier (
    reward_id INT PRIMARY KEY,
    campaign_id INT,
    title VARCHAR(255),
    description TEXT,
    price DECIMAL(12,2),
    quantity_limit INT,
    estimated_delivery DATE,
    FOREIGN KEY (campaign_id) REFERENCES Campaign(campaign_id)
);

CREATE TABLE Contribution (
    contribution_id INT PRIMARY KEY,
    reward_id INT,
    user_id INT,
    amount DECIMAL(12,2),
    payment_status VARCHAR(50),
    contribution_date TIMESTAMP,
    FOREIGN KEY (reward_id) REFERENCES Reward_Tier(reward_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Transaction (
    transaction_id INT PRIMARY KEY,
    contribution_id INT,
    payment_method VARCHAR(50),
    processed_at TIMESTAMP,
    status VARCHAR(50),
    FOREIGN KEY (contribution_id) REFERENCES Contribution(contribution_id)
);

CREATE TABLE Updates (
    update_id INT PRIMARY KEY,
    campaign_id INT,
    title VARCHAR(255),
    content TEXT,
    created_at TIMESTAMP,
    FOREIGN KEY (campaign_id) REFERENCES Campaign(campaign_id)
);

CREATE TABLE Comment (
    comment_id INT PRIMARY KEY,
    campaign_id INT,
    user_id INT,
    content TEXT,
    created_at TIMESTAMP,
    FOREIGN KEY (campaign_id) REFERENCES Campaign(campaign_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Notification (
    notification_id INT PRIMARY KEY,
    user_id INT,
    message TEXT,
    is_read BOOLEAN,
    sent_at TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Report (
    report_id INT PRIMARY KEY,
    reporter_id INT,
    target_user_id INT,
    target_campaign_id INT,
    reason TEXT,
    status VARCHAR(50),
    created_at TIMESTAMP,
    FOREIGN KEY (reporter_id) REFERENCES Users(user_id),
    FOREIGN KEY (target_user_id) REFERENCES Users(user_id),
    FOREIGN KEY (target_campaign_id) REFERENCES Campaign(campaign_id)
);

CREATE TABLE Verification_Request (
    request_id INT PRIMARY KEY,
    user_id INT,
    document_url TEXT,
    status VARCHAR(50),
    created_at TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
