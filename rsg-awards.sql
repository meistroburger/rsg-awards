-- Create 'awards' table
CREATE TABLE IF NOT EXISTS `awards` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `description` TEXT
);

-- Create 'player_awards' table
CREATE TABLE IF NOT EXISTS `player_awards` (
    `citizenid` VARCHAR(255) NOT NULL,
    `award_name` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`citizenid`, `award_name`)
);


CREATE TABLE IF NOT EXISTS `player_activities` (
    `citizenid` VARCHAR(255) NOT NULL,
    `activity_name` VARCHAR(255) NOT NULL,
    `count` INT NOT NULL DEFAULT 0,
    PRIMARY KEY (`citizenid`, `activity_name`)
);

INSERT INTO `awards` (`name`, `description`) VALUES
('GoldProspectingBronze', 'Awarded for achieving Bronze level in Gold Prospecting.'),
('GoldProspectingSilver', 'Awarded for achieving Silver level in Gold Prospecting.'),
('GoldProspectingGold', 'Awarded for achieving Gold level in Gold Prospecting.'),
('WildHorsesBronze', 'Awarded for achieving Bronze level in Taming Wild Horses.'),
('WildHorsesSilver', 'Awarded for achieving Silver level in Taming Wild Horses.'),
('WildHorsesGold', 'Awarded for achieving Gold level in Taming Wild Horses.'),
('HuntingBronze', 'Awarded for achieving Bronze level in Hunting.'),
('HuntingSilver', 'Awarded for achieving Silver level in Hunting.'),
('HuntingGold', 'Awarded for achieving Gold level in Hunting.'),
('HerbalistBronze', 'Awarded for achieving Bronze level in Herbalism.'),
('HerbalistSilver', 'Awarded for achieving Silver level in Herbalism.'),
('HerbalistGold', 'Awarded for achieving Gold level in Herbalism.'),
('ThiefBronze', 'Awarded for achieving Bronze level in Thievery.'),
('ThiefSilver', 'Awarded for achieving Silver level in Thievery.'),
('ThiefGold', 'Awarded for achieving Gold level in Thievery.'),
('CriminalBronze', 'Awarded for achieving Bronze level in Criminal activities.'),
('CriminalSilver', 'Awarded for achieving Silver level in Criminal activities.'),
('CriminalGold', 'Awarded for achieving Gold level in Criminal activities.');

