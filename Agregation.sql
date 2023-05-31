use summit;

-- 1 Affichez le nombre de personnes par corps d'emploi (title). Triez les enregistrements en ordre
-- croissant du nombre. (8 enregistrements)

select count(*) from s_emp as e
left join s_title as t
on e.title = t.title
GROUP BY e.title;

-- 2 Affichez le id et le nom de chaque département avec le total d’employés pour chacun ainsi que
-- le salaire moyen du département. Triez les enregistrements en ordre décroissant de salaire
-- moyen. (12 enregistrements)

select d.id, d.name,
(select count(*) from s_emp as e where e.dept_id = d.id ) as "Nombre d'employe",
(select AVG(e.salary) from s_emp as e where e.dept_id = d.id) as "Salaire moyen"
from s_dept as d;

-- 3 Affichez la moyenne du montant des achats des commandes de chaque client. Le nom du
-- client doit apparaître. (13 enregistrements)

select avg(o.total) as "Achat moyen",
(select name from s_customer as c1 where c1.id = c2.id) as Client
from s_ord as o
left join s_customer as c2
on c2.id = o.customer_id
GROUP BY c2.id;

-- 4 Affichez le salaire maximum, minimum, la moyenne ainsi que la somme. Renommez ces
-- colonnes MAXIMUM, MINIMUM, MOYENNE, SOMME. (1 enregistrement)

select min(salary) as Min, MAX(salary) as Max, AVG(salary) as Moyenne, sum(salary) as Somme from s_emp;

-- 5 Modifiez la requête précédente afin qu'elle affiche ces résultats pour chaque corps d'emploi.
-- (8 enregistrements)

select min(salary) as Min, MAX(salary) as Max, AVG(salary) as Moyenne, sum(salary) as Somme
from s_emp as e
left join s_title as t
on t.title = e.title
GROUP BY t.title;

-- 6 Affichez le nombre de supérieurs différents (manager_id) sans toutefois afficher leurs noms.
-- (1 enregistrement)

select count(manager_id) from s_emp;

-- 7 Affichez la différence entre le plus haut et le plus bas salaire. (1 enregistrement)

select (MAX(salary) - MIN(Salary)) as difference from s_emp;

-- 8 Pour chaque commande, affichez la quantité moyenne d'items commandés et le numéro de
-- commande. Vous ne devez faire afficher que les commandes dont la quantité moyenne
-- d'items est supérieure à 70. (4 enregistrements)

select AVG(i.quantity) as "moyenne d'objet", o.id from s_ord as o
left join s_item as i
on i.ord_id = o.id
GROUP BY o.id
having AVG(i.quantity) > 70;

-- 9 Combien y a-t-il d'enregistrements dans la table s_product ? Vous ne devez pas faire afficher
-- tous les enregistrements afin de le déterminer. (1 enregistrement)

select count(*) from s_product;

-- 10 Quel est le total des ventes par nom de vendeur (nom complet sur une seule colonne, séparé
-- d'une espace) ? L’affichage doit comporter également le numéro de vendeur (sales_rep_id ) et
-- le total des ventes pour chaque vendeur. (5 enregistrements)

select (select count(*) from s_ord as o where o.sales_rep_id = e.id) as "Nombre de vente",
CONCAT_WS(' ', first_name, last_name) as Vendeur,
e.id as "Numero de vendeur"
from s_emp as e
where (select count(*) from s_ord as o where o.sales_rep_id = e.id) > 0;

-- 11 Affichez le nombre de commandes qui existent par région. L'affichage doit contenir le nom de
-- chacune des régions avec le nombre total de commande pour chacune d'entre elle. (5
-- enregistrements)

select count(o.id) as "Nb commande",
r.name as Regions
from s_region as r
left join s_customer as c
on c.region_id = r.id
left join s_ord as o
on o.customer_id = c.id
GROUP BY r.name;

-- 12 Affichez le nombre d'employés embauchés par année. L'affichage doit contenir l'année
-- d'embauche avec le nombre d'employés embauchés pour chacune des années trouvées à
-- l'aide de la date d'embauche. (3 enregistrements)


select count(*) as "Nombre d'employe", YEAR(e1.start_date) as Annee from s_emp as e1 GROUP BY YEAR(e1.start_date);

-- 13 Affichez pour chacun des produits, la quantité totale commandée. L'affichage doit inclure
-- chaque nom de produit et la quantité totale commandée pour chacun de ces produits. Ne
-- retourner que les enregistrements dont la quantité totale commandée est supérieure à 500. (4
-- enregistrements)


select p.name as Produit,
sum(quantity) as "Qty"
from s_item as i
left join s_product as p
on i.product_id = p.id
GROUP BY p.name
having sum(quantity) > 500;

--14  Affichez le nom des employés avec le nombre de clients gérés par chaque employé. (5
-- enregistrements)

select CONCAT_WS(' ', first_name, last_name) as employe,
(select count(id) from s_customer as c where c.sales_rep_id = e.id) as "Nombre clients"
from s_emp as e
where (select count(id) from s_customer as c where c.sales_rep_id = e.id) > 0;



