INSERT INTO `database`.`characters` (`name`, `attack`, `defense`, `speed`, `hp`, `atk1`, `atk2`) VALUES ('Growlmon', '60', '40', '55', '45', 'Dino Kick', 'Fire Breath');
INSERT INTO `database`.`characters` (`name`, `attack`, `defense`, `speed`, `hp`, `atk1`, `atk2`) VALUES ('Garurumon', '55', '35', '60', '40', 'Freeze Fang', 'Claw Attack');
INSERT INTO `database`.`characters` (`name`, `attack`, `defense`, `speed`, `hp`, `atk1`, `atk2`) VALUES ('Angemon', '70', '50', '35', '45', 'Angel Slam', 'Air Blast');



INSERT INTO `database`.`map` (`location`, `x`, `y`, `down`) VALUES ('Coconut Forest', '186', '25', 'Crocodile Bridge');
INSERT INTO `database`.`map` (`location`, `x`, `y`, `up`, `down`) VALUES ('Crocodile Bridge', '196', '44', 'Coconut forest', 'Seamol City');
INSERT INTO `database`.`map` (`location`, `x`, `y`, `up`, `down`) VALUES ('Seamol City', '180', '65', 'Crocodile Bridge', 'The Zygons Tribe');
INSERT INTO `database`.`map` (`location`, `x`, `y`, `up`, `right`) VALUES ('The Zygons Tribe', '180', '94', 'Seamol City', 'Torchwood');
INSERT INTO `database`.`map` (`location`, `x`, `y`, `down`) VALUES ('The Silent Woods', '213', '77', 'Torchwood');
INSERT INTO `database`.`map` (`location`, `x`, `y`, `up`, `down`) VALUES ('Torchwood', '224', '94', 'The Silent Woods', 'Green City');
INSERT INTO `database`.`map` (`location`, `x`, `y`, `up`, `down`) VALUES ('Green City', '232', '109', 'Torchwood', 'The Amaya Throng');
INSERT INTO `database`.`map` (`location`, `x`, `y`, `up`, `down`, `left`) VALUES ('The Amaya Throng', '114', '156', 'Green City', 'Chimaki Hospital', 'The Hawks Cliff');
INSERT INTO `database`.`map` (`location`, `x`, `y`, `up`, `right`) VALUES ('The Hawks Cliff', '59', '177', 'The Screamers Prison', 'The Amaya Throng');
INSERT INTO `database`.`map` (`location`, `x`, `y`, `down`) VALUES ('The Screamers Prison', '30', '117', 'The Hawks Cliff');
INSERT INTO `database`.`map` (`location`, `x`, `y`, `up`, `down`) VALUES ('Chimaki Hospital', '114', '182', 'The Amaya Throng', 'The Ghosts Casle');
INSERT INTO `database`.`map` (`location`, `x`, `y`, `up`, `right`) VALUES ('The Ghosts Casle', '98', '201', 'Chimaki Hospital', 'Mountain City');
INSERT INTO `database`.`map` (`location`, `x`, `y`, `left`) VALUES ('Mountain City', '108', '201', 'The Ghosts Casle');
INSERT INTO `database`.`map` VALUES ('Home', '-15.00', '60.00', NULL, 'The Hawks Cliff', NULL, NULL, 'Look For Helping Items', 'Travel The Garden', NULL, NULL);

UPDATE `database`.`map` SET `x`='-15', `y`='60', `up`='', `down`='The Hawks Cliff', `act1`='Look For Helping Items', `act2`='Travel The Garden' WHERE `location`='Home';
DELETE FROM `database`.`map` WHERE `location`='The Screamers Prison';
UPDATE `database`.`map` SET `location`='The Screamers Prison', `act1`='Return To The Last Place You\'ve Been', `act2`='Clean Your Cell', `act3`='Do What The Screamers Tells You', `act4`='Ask For Pardon' WHERE `location`='Mountain City';
UPDATE `database`.`map` SET `act1`='Fight a Hawk', `act2`='Travel Around' WHERE `location`='The Hawks Cliff';
UPDATE `database`.`map` SET `act1`='Cross The River', `act2`='Fight The Amaya Manster', `act3`='Jump To The Throng' WHERE `location`='The Amaya Throng';
UPDATE `database`.`map` SET `act1`='Go To \'\'Greenvas\'\' Store', `act2`='Visit Fortune A  Teller', `act3`='Visit The Local Casino' WHERE `location`='Green City';
UPDATE `database`.`map` SET `act1`='Go To \'\'Torch\'\' Hotel', `act2`='Go To \'\'Woodens\'\' Store', `act3`='Go To \'\'Yammi\'\' Restaurant' WHERE `location`='Torchwood';
UPDATE `database`.`map` SET `act1`='Walk Slowly Around', `act2`='Walk Loudly Around', `act3`='Fight The Trees', `act4`='Try To Find The Treasure' WHERE `location`='The Silent Woods';
UPDATE `database`.`map` SET `act1`='Fight A Zygon', `act2`='Talk To The Tribe Chief' WHERE `location`='The Zygons Tribe';
UPDATE `database`.`map` SET `act1`='Consult The Mayer', `act2`='Help The Poor People Of The City', `act3`='Go To \'\'Pak\'\' Store', `act4`='Kill Some People Around' WHERE `location`='Seamol City';
UPDATE `database`.`map` SET `act1`='Jump From The Bridge', `act2`='Fight The Enormous Crocodile', `act3`='Swim Around' WHERE `location`='Crocodile Bridge';
UPDATE `database`.`map` SET `act1`='Fight The Coco Manster', `act2`='Travel Around' WHERE `location`='Coconut Forest';
UPDATE `database`.`map` SET `act1`='Return To The Last Place You\'ve Been', `act2`='Get An Injection', `act3`='Buy A Potion', `act4`='Take A pill' WHERE `location`='Chimaki Hospital';
UPDATE `database`.`map` SET `act1`='Fight A Ghost', `act2`='Scare The Ghosts' WHERE `location`='The Ghosts Casle';
UPDATE `database`.`map` SET `up`='Home' WHERE `location`='The Hawks Cliff';
UPDATE `database`.`map` SET `right`='The Screamers Prison' WHERE `location`='The Ghosts Casle';
UPDATE `database`.`map` SET `left`='The Zygons Tribe' WHERE `location`='Torchwood';

UPDATE `database`.`map` SET `act1`='Return Home' WHERE `location`='Chimaki Hospital';
UPDATE `database`.`map` SET `act1`='Return Home' WHERE `location`='The Screamers Prison';

UPDATE `database`.`map` SET `act2`='Visit A Fortune Teller' WHERE `location`='Green City';


UPDATE `database`.`map` SET `x`='68' WHERE `location`='The Amaya Throng';

UPDATE `database`.`map` SET `y`='120' WHERE `location`='The Hawks Cliff';

UPDATE `database`.`map` SET `x`='69', `y`='122' WHERE `location`='Chimaki Hospital';

UPDATE `database`.`map` SET `y`='143' WHERE `location`='The Ghosts Casle';

UPDATE `database`.`map` SET `x`='62' WHERE `location`='The Screamers Prison';

UPDATE `database`.`map` SET `x`='187' WHERE `location`='Green City';

UPDATE `database`.`map` SET `y`='36' WHERE `location`='Torchwood';

UPDATE `database`.`map` SET `x`='169' WHERE `location`='The Silent Woods';

UPDATE `database`.`map` SET `x`='135' WHERE `location`='The Zygons Tribe';

UPDATE `database`.`map` SET `x`='135.00', `y`='5' WHERE `location`='Seamol City';

UPDATE `database`.`map` SET `x`='151' WHERE `location`='Crocodile Bridge';

UPDATE `database`.`map` SET `y`='-33' WHERE `location`='Coconut Forest';


UPDATE `database`.`items` SET `location`='Seamol City' WHERE `item`='Blue Amulet' and`location`='Pak Store';
UPDATE `database`.`items` SET `location`='Seamol City' WHERE `item`='Blue Ring' and`location`='Pak Store';
UPDATE `database`.`items` SET `location`='Torchwood' WHERE `item`='Green Dragon Amulet' and`location`='Woodens Store';
UPDATE `database`.`items` SET `location`='Torchwood' WHERE `item`='Steel Sword' and`location`='Woodens Store';
UPDATE `database`.`items` SET `location`='Green City' WHERE `item`='Red Key' and`location`='Greenvas Store';

INSERT INTO `database`.`items` (`item`, `description`, `bonus1`, `bonus2`, `location`, `price`, `premium`) VALUES ('Blue Amulet', 'A Blue Amulet', '15% exp', '15 hp', 'Pak Store', '180', '0');
INSERT INTO `database`.`items` (`item`, `description`, `bonus1`, `bonus2`, `location`, `price`, `premium`) VALUES ('Blue Ring', 'A Blue Ring', '5% exp', '25 hp', 'Pak Store', '75', '0');
INSERT INTO `database`.`items` (`item`, `description`, `bonus1`, `bonus2`, `location`, `price`, `premium`) VALUES ('Green Dragon Amulet', 'A Green Dragon Amulet', '28% exp', '10 hp', 'Woodens Store', '270', '0');
INSERT INTO `database`.`items` (`item`, `description`, `bonus1`, `bonus2`, `location`, `price`, `premium`) VALUES ('Steel Sword', 'A Steel Sword', '30% exp', '35 hp', 'Woodens Store', '300', '0');

INSERT INTO `database`.`items` (`item`, `description`, `bonus1`, `bonus2`, `location`, `price`, `premium`) VALUES ('Red Key', 'A Red Key', '10% exp', '28 hp', 'Greenvas Store', '100', '0');

INSERT INTO `database`.`items` (`item`, `description`, `bonus1`, `bonus2`, `location`, `price`, `premium`) VALUES ('Starter Kit', 'Basic Item', '3% exp', '5 hp', 'Home', '100', '0');


UPDATE `database`.`items` SET `bonus1`='15 exp' WHERE `item`='Blue Amulet' and`location`='Seamol City';
UPDATE `database`.`items` SET `bonus1`='5 exp' WHERE `item`='Blue Ring' and`location`='Seamol City';
UPDATE `database`.`items` SET `bonus1`='28 exp' WHERE `item`='Green Dragon Amulet' and`location`='Torchwood';
UPDATE `database`.`items` SET `bonus1`='10 exp' WHERE `item`='Red Key' and`location`='Green City';
UPDATE `database`.`items` SET `bonus1`='5 exp' WHERE `item`='Starter Kit' and`location`='Home';
UPDATE `database`.`items` SET `bonus1`='30 exp' WHERE `item`='Steel Sword' and`location`='Torchwood';



