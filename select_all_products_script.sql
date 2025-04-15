-- Selectionne tous les produits - Affiche les colonnes description, attributs, categories, quantités et prix
SELECT
	p.name,
    p.description,
    GROUP_CONCAT(DISTINCT CONCAT(a.name, ': ', av.attribute_value) SEPARATOR ', ') AS attributes,
    GROUP_CONCAT(DISTINCT c.name SEPARATOR ', ') AS categories,
    pv.quantity,
    COALESCE(pv.specific_price, p.base_price) AS price    
FROM products as p
	JOIN product_variants as pv ON p.id = pv.product_id
    JOIN product_variant_attributes as pva ON pv.id = pva.product_variant_id
    JOIN attribute_values as av ON pva.attribute_value_id = av.id
    JOIN attribute_types as a ON av.attribute_id = a.id
    JOIN product_categories as pc ON pc.product_id = p.id
    JOIN categories as c ON c.id = pc.category_id
GROUP BY
	p.id, pv.id
;
