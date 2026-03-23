DROP DATABASE IF EXISTS Tietokanta;
CREATE DATABASE Tietokanta;
USE Tietokanta;

CREATE TABLE Hengitysharjoitukset (
    harjoitus_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    harjoitus VARCHAR(100) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Kayttajat (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    role ENUM('potilas', 'laakari', 'yllapitaja'),
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(100),
    age INT
);

CREATE TABLE HRV_mittaukset (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    rmssd FLOAT,
    hf_hrv FLOAT,
    pns_index FLOAT,
    sns_index FLOAT,
    FOREIGN KEY (user_id) REFERENCES Kayttajat(user_id)
);

CREATE TABLE Kyselyt (
    kysely_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    stressi INT,
    energia INT,
    unenlaatu INT,
    mieliala INT,
    vapaamuotoinen_vastaus VARCHAR(255),
    mittaus_id INT,
    FOREIGN KEY (user_id) REFERENCES Kayttajat(user_id),
    FOREIGN KEY (mittaus_id) REFERENCES HRV_mittaukset(id)
);

CREATE TABLE Seulontakysely (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    tsq INT,
    dsm5 INT,
    FOREIGN KEY (user_id) REFERENCES Kayttajat(user_id)
);

CREATE TABLE Ammattilainen_potilas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ammattilainen_id INT NOT NULL,
    potilas_id INT NOT NULL,
    FOREIGN KEY (ammattilainen_id) REFERENCES Kayttajat(user_id),
    FOREIGN KEY (potilas_id) REFERENCES Kayttajat(user_id)
);

-- Insert sample data

INSERT INTO Kayttajat (role, email, password)
VALUES ('potilas', 'test@test.com', '123');

INSERT INTO HRV_mittaukset (user_id, rmssd, hf_hrv)
VALUES (1, 45.2, 120.5);

