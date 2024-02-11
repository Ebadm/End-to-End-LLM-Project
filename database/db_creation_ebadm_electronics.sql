-- Create the database
CREATE DATABASE retail_electronics;
USE retail_electronics;

-- Create the electronics_items table
CREATE TABLE electronics_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    category ENUM('Smartphone', 'Laptop', 'Tablet', 'Headphones') NOT NULL,
    brand ENUM('Apple', 'Samsung', 'Sony', 'Dell', 'HP') NOT NULL,
    color ENUM('Black', 'White', 'Silver', 'Grey') NOT NULL,
    price DECIMAL(7,2) CHECK (price BETWEEN 50 AND 3000),
    stock_quantity INT NOT NULL,
    UNIQUE KEY category_brand_color (category, brand, color)
);

-- Create the discounts table
CREATE TABLE discounts (
    discount_id INT AUTO_INCREMENT PRIMARY KEY,
    item_id INT NOT NULL,
    pct_discount DECIMAL(5,2) CHECK (pct_discount BETWEEN 0 AND 100),
    FOREIGN KEY (item_id) REFERENCES electronics_items(item_id)
);

-- Create a stored procedure to populate the electronics_items table
DELIMITER $$
CREATE PROCEDURE PopulateElectronicsItems()
BEGIN
    DECLARE counter INT DEFAULT 0;
    DECLARE max_records INT DEFAULT 100;
    DECLARE category ENUM('Smartphone', 'Laptop', 'Tablet', 'Headphones');
    DECLARE brand ENUM('Apple', 'Samsung', 'Sony', 'Dell', 'HP');
    DECLARE color ENUM('Black', 'White', 'Silver', 'Grey');
    DECLARE price DECIMAL(7,2);
    DECLARE stock INT;

    -- Seed the random number generator
    SET SESSION rand_seed1 = UNIX_TIMESTAMP();

    WHILE counter < max_records DO
        -- Generate random values
        SET category = ELT(FLOOR(1 + RAND() * 4), 'Smartphone', 'Laptop', 'Tablet', 'Headphones');
        SET brand = ELT(FLOOR(1 + RAND() * 5), 'Apple', 'Samsung', 'Sony', 'Dell', 'HP');
        SET color = ELT(FLOOR(1 + RAND() * 4), 'Black', 'White', 'Silver', 'Grey');
        SET price = FLOOR(50 + RAND() * 2951); -- Adjusting price range for electronics
        SET stock = FLOOR(5 + RAND() * 96); -- Adjusting stock range

        -- Attempt to insert a new record
        -- Duplicate category, brand, color combinations will be ignored due to the unique constraint
        BEGIN
            DECLARE CONTINUE HANDLER FOR 1062 BEGIN END;  -- Handle duplicate key error
            INSERT INTO electronics_items (category, brand, color, price, stock_quantity)
            VALUES (category, brand, color, price, stock);
            SET counter = counter + 1;
        END;
    END WHILE;
END$$
DELIMITER ;

-- Call the stored procedure to populate the electronics_items table
CALL PopulateElectronicsItems();

-- Insert records into the discounts table
-- Note: Ensure that the item_ids match those in your electronics_items table
INSERT INTO discounts (item_id, pct_discount)
VALUES
(1, 5.00),
(2, 10.00),
(3, 15.00),
(4, 20.00),
(5, 25.00),
(6, 10.00),
(7, 30.00),
(11, 35.00),
(9, 40.00),
(10, 50.00);
