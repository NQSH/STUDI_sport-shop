-- Selectionne tous les produits, dont la description, les attributs, les quantités et le prix unitaire
SELECT
	p.name,
    p.description,
    GROUP_CONCAT(CONCAT(a.name, ': ', av.value) SEPARATOR ', ') AS attributes,
    pv.quantity,
    COALESCE(pv.specific_price, p.base_price) AS price    
FROM products p
	JOIN product_variants pv ON p.id = pv.product_id
    JOIN variant_attributes va ON pv.id = va.product_variant_id
    JOIN attribute_values av ON va.attribute_value_id = av.id
    JOIN attributes a ON av.attribute_id = a.id
GROUP BY
	p.id, pv.id
;
