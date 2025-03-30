USE STUDI_sport_shop;

-- Insérer des catégories
INSERT INTO categories (name) VALUES 
('Chaussure'), 
('Vêtement'), 
('Accessoire');

-- Insérer des marques
INSERT INTO brands (name) VALUES 
('Scarpa'), 
('BlackDiamond'), 
('SuperDry'),
('K2');

-- Insérer des produits
INSERT INTO products (name, description, base_price, category_id, brand_id) VALUES 
('Gripamax', 'La grimpe précise', 250.00, 1, 1),
('Climboss', 'Permet de courir sur les murs', 160.00, 1, 2),
('Pullo', 'Comfort et chaleur', 60.00, 2, 3),
('Gourdass', 'Pratique pour boire', 25.50, 3, 4),
('Hellmet', 'Protège ta tête !', 65.00, 3, 4);

-- Insérer des variantes de produits
INSERT INTO product_variants (product_id, quantity, specific_price) VALUES 
(1, 10, NULL),
(1, 5, NULL),
(2, 15, NULL),
(2, 17, NULL),
(3, 19, NULL), -- ID 5
(3, 20, NULL),
(4, 15, NULL),
(4, 12, 30.00),
(5, 7, NULL),
(5, 12, NULL); -- ID 10

-- Insérer des types d'attribut
INSERT INTO attributes (name) VALUES 
('Pointure'), 
('Taille'),
('Capacité'),
('Couleur');

-- Insérer des attributs
INSERT INTO attribute_values (value, attribute_id) VALUES 
('42', 1), 
('43', 1),
('45', 1),
('M', 2), 
('L', 2), -- ID 5
('30', 3),
('40', 3),
('Blanc', 4),
('Noir', 4);

-- Insèrer des associations variante / attribut

INSERT INTO variant_attributes (product_variant_id, attribute_value_id) VALUES
(1, 1),
(2, 2),
(3, 2),
(4, 3),
(5, 4),
(6, 5),
(7, 6),
(8, 7),
(9, 4),
(9, 8),
(10, 4),
(10, 9);

-- Insérer des utilisateurs
INSERT INTO users (email, password) VALUES 
('john.doe@email.fr', 'hashedpassword123'), 
('mr.toutlemonde@email.com', 'securepass456');

-- Insérer des clients
INSERT INTO clients (firstname, lastname, phone_number, user_id) VALUES 
('John', 'Doe', '0634567890', 1), 
('David', 'Smith', '0987654321', 2);

-- Insérer des adresses
INSERT INTO addresses (street, additionnal_info, zipcode, city, type, is_default, client_id) VALUES 
('123 rue des Trois Fontaines', 'Appartement PROREL', '05330', 'Saint-Chaffrey', 'BILLING', TRUE, 1),
('456 rue du Clochet', NULL, '05320', 'Chantemerle', 'SHIPPING', TRUE, 1),
('789 rue des norottes', NULL, '91310', 'Leuville sur Orge', 'SHIPPING', TRUE, 2);

-- Insérer des commandes
INSERT INTO orders (client_id, shipping_address_id, billing_address_id, status) VALUES 
(1, 2, 1, 'PENDING'), 
(2, 3, 3, 'PAID');

-- Insérer des détails de commande
INSERT INTO order_details (quantity, order_id, product_variant_id) VALUES 
(1, 1, 1), 
(1, 1, 5),
(2, 2, 7);

-- Insérer des types de paiement
INSERT INTO payment_types (name) VALUES 
('CREDIT_CARD'), 
('PAYPAL'), 
('BANK_TRANSFER');

-- Insérer des paiements
INSERT INTO payments (amount, status, details, order_id, payment_type_id) VALUES 
(310.00, 'COMPLETED', '{"paypal_id": "PAYPAL-789456"}', 2, 2);
