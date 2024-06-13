CREATE (n:Ligne {Nom: 'T1'})

CREATE (s1:Station {Nom: 'BEAUZELLE - AEROSCOPIA'}),
       (s2:Station {Nom: 'ANCELY'}),

MATCH (s:Station), (l:Ligne)
WHERE s.Nom = "PALAIS DE JUSTICE " AND l.Nom = "T1" 
CREATE (s)-[:Relier {position:1} ]->(l);


CREATE (l:Ligne {Nom:'T2'}),
(s1:Station {Nom:'NADOT'}),
(s1)-[:Relier {Position:14}]->(l),

MATCH (s:Station)
WHERE s.Nom='AEROPORT'
SET s:Station:Terminus;


MATCH (s1:Station {Nom: 'ANCELY'}), (s2:Station {Nom: 'NADOT'})
CREATE (s1)-[:Suivant]->(s2), (s2)-[:Précédent]->(s1);

MATCH (s:Station)
WHERE s.Nom='ANCELY'
SET s.Coordonnées = '43.61822059194139, 1.3969099594913592';

//1. Obtenir le nœud de la personne nommée Tom Hanks
MATCH (p:Person{name:"Tom Hanks"})
RETURN p;

//2. Obtenir les identifiants des nœuds correspondants à Tom Hanks et Charlize Theron.
MATCH (p:Person) 
WHERE p.name = "Tom Hanks" OR p.name = "Charlize Theron"
RETURN id(p);

//3. Obtenir le sous graphe du film intitulé Matrix avec les acteurs (ACTED_IN)
MATCH (m:Movie{title:"The Matrix"})<-[:ACTED_IN]-(a:Person)
RETURN m,a;

//4. Obtenir le sous graphe des films dans lesquels a joué (ACTED_IN) Tom Hanks
MATCH (m:Movie)<-[a:ACTED_IN]-(p:Person{name:"Tom Hanks"})
RETURN m,a,p;

//5. Obtenir le titre du film dans lequel Tom Hanks a joué (ACTED_IN) le rôle de Chuck Noland
MATCH (m:Movie)<-[a:ACTED_IN]-(p:Person{name: "Tom Hanks"})
WHERE "Chuck Noland" IN a.roles 
RETURN m.title;

//6. Obtenir le sous graphe des films dans lesquels Meg Ryan et Tom Cruise ont joué (ACTED_IN) un rôle
MATCH (p:Person{name:"Tom Cruise"})-[a:ACTED_IN]->(m:Movie)<-[aa:ACTED_IN]-(pp:Person{name: "Meg Ryan"})
RETURN p,a,m,aa,pp; 

//7. Obtenir les personnes qui ont joué (ACTED_IN) un rôle dans un film
MATCH (p:Person)-[:ACTED_IN]->(:Movie)
RETURN p; 

//8. Obtenir le sous graphe des personnes en relation avec le film Top Gun
MATCH (p:Person)-[r]->(m:Movie{title:"Top Gun"})
RETURN p,r,m;

//9. Obtenir le sous graphe des personnes en relation avec un film dans lequel a joué Tom Hanks
MATCH (p:Person)-[r]->(m:Movie)<-[aa:ACTED_IN]-(pp:Person{name:"Tom Hanks"})
RETURN p,r,m,aa,pp; 

//10. Obtenir les directeurs (DIRECTED) de films
MATCH (p:Person)-[d:DIRECTED]->(m:Movie)
RETURN p;

//11. Obtenir les films dirigés (DIRECTED) par Ron Howard
MATCH (p:Person{name:"Ron Howard"})-[d:DIRECTED]->(m:Movie)
RETURN m;

//12. Obtenir les acteurs (personnes ayant jouées un rôle dans un film) ayant joué (ACTED_IN) dans un film dirigé (DIRECTED) par Ron Howard 
//dans lequel Tom Hanks à joué (ACTED_IN)
MATCH (p:Person)-[a:ACTED_IN]->(m:Movie)<-[d:DIRECTED]-(pp:Person{name:"Ron Howard"})
RETURN p;

//13. Obtenir les films dirigés par Andy Wachowski (DIRECTED), écrit par Lana Wachowski (WROTE) et produits (PRODUCED) par Joel Silver (PRODUCED)
MATCH (p:Person{name:"Andy Wachowski"})-[:DIRECTED]->(m:Movie)<-[:WROTE]-(p)
WITH m
MATCH (pp:Person {name:"Joel Silver"})-[:PRODUCED]->(m) 
RETURN m;

//13. Reduction de MATCH 
MATCH (p:Person{name:"Andy Wachowski"})-[r:DIRECTED|WROTE]->(m:Movie)<-[:PRODUCED]-(pp:Person {name:"Joel Silver"})
WITH m, COUNT(r) as nbr
WHERE nbr=2
RETURN m;


//14. Obtenir les films dirigés (DIRECTED) et écrits (WROTE) par Andy et Lana Wachowski
MATCH(p:Person)-[:DIRECTED]->(m:Movie)<-[:WROTE]-(pp:Person) 
WHERE p.name = "Andy Wachowski" OR p.name="Lana Wachowski" 
AND pp.name = "Andy Wachowski"OR pp.name="Lana Wachowski" 
RETURN m;


//15. Obtenir les films dirigés (DIRECTED), écrits (WROTE) et produits (PRODUCED) par la même personne
MATCH (p:Person)-[prod:PRODUCED]->(m:Movie)<-[w:WROTE]-(p)
MATCH (p)-[d:DIRECTED]->(m)
RETURN m;

//15 Reduction de MATCH 
MATCH (p:Person)-[r:PRODUCED|DIRECTED|WROTE]->(m:Movie)
WITH p,m, COUNT(r) as nbr
WHERE nbr=3
RETURN m;

//16. Obtenir les acteurs qui ont joué (ACTED_IN) dans un film dirigé (DIRECTED), écrit (WROTE) et produit (PRODUCED) par la même personne
MATCH (p:Person)-[r:PRODUCED|DIRECTED|WROTE]->(m:Movie)<-[a:ACTED_IN]-(pp:Person)
WITH p,m, COUNT(r) as nbr,pp
WHERE nbr=3
RETURN pp; 
//Note : I Have tested this (16) and it works correctly 

//17. Obtenir les films dirigés (DIRECTED) par deux personnes différentes
MATCH(p:Person)-[d:DIRECTED]->(m:Movie)<-[dd:DIRECTED]-(pp:Person)
RETURN m; 

//18. Obtenir les acteurs qui ont joué dans un film dirigé (DIRECTED) par deux personnes différentes
MATCH (p:Person) - [a:ACTED_IN]->(m:Movie)
WHERE EXISTS {(p1:Person) - [d:DIRECTED]->(m:Movie)<-[d1:DIRECTED]-(p2:Person)}
RETURN p;


//18. Reduction de MATCH
MATCH (p:Person)-[d:DIRECTED]->(m:Movie)<-[a:ACTED_IN]-(pp:Person)
WITH m, COUNT(p) as nbr_directeurs, pp 
WHERE nbr_directeurs>=2
RETURN pp; 

//1. Obtenir le nombre d’acteurs
MATCH (p:Person)-[:ACTED_IN]->(m:Movie)
RETURN COUNT(DISTINCT p);

//2. Obtenir le nombre de producteurs
MATCH (p:Person)-[:PRODUCED]->(m:Movie)
RETURN COUNT(DISTINCT p);

//3. Obtenir le nombre moyen d’acteurs par film
MATCH (p:Person)-[:ACTED_IN]->(m:Movie)
WITH m, COUNT(DISTINCT p) as nbr_acteurs
RETURN AVG(nbr_acteurs) as nbr_moyen;

//4. Obtenir le nombre de personnes qui suivent Jessica Thompson
MATCH (p:Person)-[:FOLLOWS]->(pp:Person{name:"Jessica Thompson"})
RETURN COUNT(p);

//5. Obtenir le nombre de films dans lesquels Al Pacino a joué
MATCH (p:Person{name:"Al Pacino"})-[:ACTED_IN]->(m:Movie)
RETURN COUNT(m);

//6. Obtenir le nombre d’acteurs qui ont joué dans des films dans lesquels Al Pacino a joué
MATCH (p:Person{name:"Al Pacino"})-[:ACTED_IN]->(m:Movie)<-[:ACTED_IN]-(pp:Person)
RETURN COUNT(DISTINCT pp);

//7. Obtenir le nombre de rôles joués par Meg Ryan dans le film Joe Versus the Volcano
MATCH (p:Person{name:"Meg Ryan"})-[a:ACTED_IN]->(m:Movie{title:"Joe Versus the Volcano"})
RETURN SIZE(a.roles);

//8. Obtenir les acteurs qui ont joués plusieurs rôles dans un même film
MATCH (p:Person)-[a:ACTED_IN]->(m:Movie)
WHERE SIZE(a.roles)>1
RETURN DISTINCT p;

//9. Obtenir le nombre de rôles joués par Keanu Reeves
MATCH (p:Person{name:"Keanu Reeves"})-[a:ACTED_IN]->(m:Movie)
RETURN COUNT(SIZE(a.roles));

//10. Obtenir l’âge moyen des acteurs du film Top Gun
MATCH (p:Person)-[a:ACTED_IN]->(m:Movie{title:"Top Gun"})
RETURN 2024-AVG(p.born);

//11. Obtenir la liste des films dans lesquels a joué Tom Hanks
MATCH (p:Person{name:"Tom Hanks"})-[a:ACTED_IN]->(m:Movie)
RETURN collect(m);

//12. Obtenir la liste des films dans lesquels ont joué Tom Hanks et Gary Sinise
MATCH (:Person{name:"Tom Hanks"})-[:ACTED_IN]->(m:Movie)<-[:ACTED_IN]-(:Person{name:"Gary Sinise"})
RETURN collect(m);

//13. Obtenir les acteurs qui ont joué dans plus de 5 films
MATCH (p:Person)-[:ACTED_IN]->(m:Movie)
WITH p, COUNT(m) as nbr_films
WHERE nbr_films>5
RETURN p;

//14. Obtenir les acteurs qui ont joué plus de 5 rôles
MATCH (p:Person)-[a:ACTED_IN]->(:Movie)
WITH p, SUM(SIZE(a.roles)) AS nbRoles
WHERE nbRoles > 5
RETURN p;

//15. Obtenir les films dans lesquels ont joué 5 acteurs
MATCH (p:Person)-[a:ACTED_IN]->(m:Movie)
WITH m, COUNT(p) AS nbActeurs
WHERE nbActeurs = 5
RETURN m;

//16. Obtenir les films produits par 2 personnes
MATCH (p:Person)-[:PRODUCED]->(m:Movie)
WITH m, COUNT(p) AS nbProd
WHERE nbProd = 2
RETURN m.title AS films;

//17. Obtenir les acteurs qui ont joué entre 4 et 7 films
MATCH (p:Person)-[:ACTED_IN]->(m:Movie)
WITH p, COUNT(m) AS nbFilms
WHERE nbFilms >= 4 AND nbFilms <= 7
RETURN p AS acteurs;

//18. Obtenir les acteurs qui ont joué dans le même nombre de films que Al Pacino
MATCH (p:Person{name:"Al Pacino"})-[:ACTED_IN]->(m:Movie)
WITH COUNT(m) as nbPacino
MATCH (p:Person)-[:ACTED_IN]->(m:Movie)
WITH nbPacino, p,COUNT(m) as nbFilmsActeurs
WHERE nbFilmsActeurs = nbPacino AND p.name <> "Al Pacino" 
RETURN p;

//19. Obtenir les films qui ont le même nombre d’acteurs que dans Top Gun
MATCH (p:Person)-[a:ACTED_IN]->(m:Movie {title :"Top Gun"})
WITH m, count(p) AS nb
MATCH (p1:Person)-[a1:ACTED_IN]->(m1:Movie)
WITH m1,nb,count(p1) AS nb1
WHERE nb = nb1 
RETURN m1;

//20. Obtenir le film sur lequel le plus de personnes sont liées
MATCH (p:Person)-[]->(m:Movie)
WITH m,COUNT(DISTINCT p) as countLiens
WITH MAX(countLiens) as maxLiens
MATCH (p:Person)-[]->(m:Movie)
WITH COUNT(DISTINCT p) as liens, maxLiens, m
WHERE liens = maxLiens
RETURN m;

//21. Obtenir le film dans lequel le plus d’acteurs ont joué
MATCH (p:Person)-[:ACTED_IN]->(m:Movie)
WITH m,COUNT(DISTINCT p) as countLiens
WITH MAX(countLiens) as maxLiens
MATCH (p:Person)-[:ACTED_IN]->(m:Movie)
WITH COUNT(DISTINCT p) as liens, maxLiens, m
WHERE liens = maxLiens
RETURN m;

//22. Obtenir le film dans lequel l’acteur le plus jeune a joué
MATCH (p:Person)-[:ACTED_IN]->(m:Movie)
WITH MAX(p.born) as plusJeune
MATCH (p:Person)-[:ACTED_IN]->(m:Movie)
WHERE p.born = plusJeune
RETURN p;



// TP5
// Exercice 1 : Création du graphe
// Q1. Créer le graphe Neo4J comportant les informations géographiques fournies en annexe conformément au graphe structurel ci-dessous.
CREATE
// CONTINENTS
(a:Continent{nomc:"Amerique", sup:42.55}),
//PAYS
(bo:Pays{nomp:"Bolivie",cap:"La Paz",sup:1.10,pop:11.6, iso3:"BOL", iso2:"BO"}),
(br:Pays{nomp:"Bresil",cap:"Brasilia",sup:8.51,pop:211.7, iso3:"BRA", iso2:"BR"}),
(co:Pays{nomp:"Colombie",cap:"Bogota",sup:1.14,pop:49.1, iso3:"COL", iso2:"CO"}),
(eq:Pays{nomp:"Equateur",cap:"Quito",sup:0.28,pop:16.9, iso3:"ECU", iso2:"EC"}),
(pe:Pays{nomp:"Perou",cap:"Lima",sup:1.28,pop:31.9, iso3:"PER", iso2:"PE"}),
(ve:Pays{nomp:"Venezuela",cap:"Caracas",sup:0.92,pop:28.4, iso3:"VEN", iso2:"VE"}),
// FLEUVES
(ama:Fleuve{nomf:"Amazone",lng:7000,emb:"Ocean Atlantique"}),
(mar:Fleuve{nomf:"Maranon",lng:1570,emb:""}),
(nap:Fleuve{nomf:"Napo",lng:1480,emb:""}),
(put:Fleuve{nomf:"Putumayo",lng:1930,emb:""}),
(alg:Fleuve{nomf:"Algodon",lng:230,emb:""}),
(car:Fleuve{nomf:"Cara Parana",lng:260,emb:""}),
(gua:Fleuve{nomf:"Guamuez",lng:140,emb:""}),
(gue:Fleuve{nomf:"Gueppi",lng:110,emb:""}),
(iga:Fleuve{nomf:"Igara Parana",lng:440,emb:""}),
(san:Fleuve{nomf:"San Miguel",lng:240,emb:""}),
(yag:Fleuve{nomf:"Yagua",lng:330,emb:""}),
(caq:Fleuve{nomf:"Caqueta",lng:2420,emb:""}),
(neg:Fleuve{nomf:"Negro",lng:2250,emb:""}),
(uca:Fleuve{nomf:"Ucayali",lng:2670,emb:""}),
(jur:Fleuve{nomf:"Jurua",lng:3283,emb:""}),
(pur:Fleuve{nomf:"Purus",lng:3210,emb:""}),
(mad:Fleuve{nomf:"Madeira",lng:4207,emb:""}),
(tap:Fleuve{nomf:"Tapajos",lng:2291,emb:""}),
(xin:Fleuve{nomf:"Xingu",lng:2260,emb:""}),
// SITUER
(bo)-[:Situer]->(a),
(br)-[:Situer]->(a),
(co)-[:Situer]->(a),
(eq)-[:Situer]->(a),
(pe)-[:Situer]->(a),
(ve)-[:Situer]->(a),
// FRONTIERES (RELATION NON ORDONNEES DONC DANS LES DEUX SENS)
(pe)-[:Frontalier{lng:900}]->(bo), 		// PEROU - BOLIVIE
(pe)-[:Frontalier{lng:2995}]->(br), 		// PEROU - BRESIL
(pe)-[:Frontalier{lng:1496}]->(co), 		// PEROU - COLOMBIE
(pe)-[:Frontalier{lng:1420}]->(eq), 		// PEROU - EQUATEUR
(co)-[:Frontalier{lng:1643}]->(br), 		// COLOMBIE - BRESIL
(co)-[:Frontalier{lng:590}]->(eq), 		// COLOMBIE - EQUATEUR
(co)-[:Frontalier{lng:1496}]->(pe), 		// COLOMBIE - PEROU
(co)-[:Frontalier{lng:2050}]->(ve), 		// COLOMBIE - VENEZUELA
(br)-[:Frontalier{lng:3423}]->(bo), 		// BRESIL - BOLIVIE
(br)-[:Frontalier{lng:2995}]->(pe), 		// BRESIL - PEROU
(br)-[:Frontalier{lng:2200}]->(ve), 		// BRESIL - VENEZUELA
(br)-[:Frontalier{lng:2200}]->(co), 		// BRESIL - COLOMBIE
(eq)-[:Frontalier{lng:1420}]->(pe), 		// EQUATEUR - PEROU
(eq)-[:Frontalier{lng:590}]->(co), 		// EQUATEUR - COLOMBIE
(ve)-[:Frontalier{lng:2050}]->(co), 		// VENEZUELA - COLOMBIE
(ve)-[:Frontalier{lng:2200}]->(br), 		// VENEZUELA - BRESIL
(bo)-[:Frontalier{lng:900}]->(pe), 		// BOLIVIE - PEROU
(bo)-[:Frontalier{lng:3423}]->(br), 		// BOLIVIE - BRESIL
// TRAVERSER
(ama)-[:Traverser]->(pe), 		// AMAZONE - PEROU
(ama)-[:Traverser]->(co),		// AMAZONE - COLOMBIE
(ama)-[:Traverser]->(br), 		// AMAZONE - BRESIL
(mar)-[:Traverser]->(pe), 		// MARANON - PEROU
(nap)-[:Traverser]->(eq), 		// NAPO - PEROU
(nap)-[:Traverser]->(pe), 		// NAPO - EQUATEUR
(put)-[:Traverser]->(pe),		// PUTUMAYO - PEROU
(put)-[:Traverser]->(co),		// PUTUMAYO - COLOMBIE
(put)-[:Traverser]->(br),			// PUTUMAYO - BRESIL
(put)-[:Traverser]->(eq),		// PUTUMAYO - EQUATEUR
(alg)-[:Traverser]->(pe),		// ALGODON - PEROU
(car)-[:Traverser]->(co),		// CARA PARANA - COLOMBIE
(gua)-[:Traverser]->(co),		// GUAMUEZ - COLOMBIE
(gue)-[:Traverser]->(co),		// GUEPPI - COLOMBIE
(gue)-[:Traverser]->(eq),		// GUEPPI - EQUATEUR
(iga)-[:Traverser]->(co),		// IGARA PARANA - COLOMBIE
(san)-[:Traverser]->(co),		// SAN MIGUEL - COLOMBIE
(san)-[:Traverser]->(eq),		// SAN MIGUEL - EQUATEUR
(yag)-[:Traverser]->(ve),		// YAGUA - VENEZUELA
(caq)-[:Traverser]->(co),		// CAQUETA - COLOMBIE
(caq)-[:Traverser]->(br),		// CAQUETA - BRESIL
(neg)-[:Traverser]->(co),		// NEGRO - COLOMBIE
(neg)-[:Traverser]->(ve),		// NEGRO - BRESIL
(neg)-[:Traverser]->(eq),		// NEGRO - EQUATEUR
(uca)-[:Traverser]->(pe),		// UCAYALI - PEROU
(jur)-[:Traverser]->(pe),			// JURUA - PEROU
(jur)-[:Traverser]->(br),			// JURUA - BRESIL
(pur)-[:Traverser]->(pe),		// PURUS - PEROU
(pur)-[:Traverser]->(br),			// PURUS - BRESIL
(mad)-[:Traverser]->(bo),		// MADEIRA - BOLIVIE
(mad)-[:Traverser]->(br),		// MADEIRA - BRESIL
(tap)-[:Traverser]->(br),			// TAPAJOS - BRESIL
(tap)-[:Traverser]->(br),			// XINGU - BRESIL
// SOURCE
(ama)-[:Source]->(pe),
(mar)-[:Source]->(pe),
(nap)-[:Source]->(eq),
(put)-[:Source]->(co),
(alg)-[:Source]->(pe),
(car)-[:Source]->(co),
(gua)-[:Source]->(co),
(gue)-[:Source]->(eq),
(iga)-[:Source]->(co),
(san)-[:Source]->(eq),
(yag)-[:Source]->(ve),
(caq)-[:Source]->(co),
(neg)-[:Source]->(co),
(uca)-[:Source]->(pe),
(jur)-[:Source]->(pe),
(pur)-[:Source]->(pe),
(mad)-[:Source]->(bo),
(tap)-[:Source]->(br),
(xin)-[:Source]->(br),
// JETER
(ama)-[:Jeter]->(br),
(mar)-[:Jeter]->(pe),
(nap)-[:Jeter]->(pe),
(put)-[:Jeter]->(br),
(alg)-[:Jeter]->(pe),
(car)-[:Jeter]->(co),
(gua)-[:Jeter]->(co),
(gue)-[:Jeter]->(co),
(iga)-[:Jeter]->(co),
(san)-[:Jeter]->(co),
(yag)-[:Jeter]->(ve),
(caq)-[:Jeter]->(br),
(neg)-[:Jeter]->(br),
(uca)-[:Jeter]->(pe),
(jur)-[:Jeter]->(br),
(pur)-[:Jeter]->(br),
(mad)-[:Jeter]->(br),
(tap)-[:Jeter]->(br),
(xin)-[:Jeter]->(br);

// Q2 Modifier le graphe Neo4J afin de prendre en compte la relation DRAINER. Pour se faire vous devez ajouter deux types de relations :effluent, :affluent
MATCH
(ama:Fleuve{nomf:"Amazone"}),
(mar:Fleuve{nomf:"Maranon"}),
(nap:Fleuve{nomf:"Napo"}),
(put:Fleuve{nomf:"Putumayo"}),
(alg:Fleuve{nomf:"Algodon"}),
(car:Fleuve{nomf:"Cara Parana"}),
(gua:Fleuve{nomf:"Guamuez"}),
(gue:Fleuve{nomf:"Gueppi"}),
(iga:Fleuve{nomf:"Igara Parana"}),
(san:Fleuve{nomf:"San Miguel"}),
(yag:Fleuve{nomf:"Yagua"}),
(caq:Fleuve{nomf:"Caqueta"}),
(neg:Fleuve{nomf:"Negro"}),
(uca:Fleuve{nomf:"Ucayali"}),
(jur:Fleuve{nomf:"Jurua"}),
(pur:Fleuve{nomf:"Purus"}),
(mad:Fleuve{nomf:"Madeira"}),
(tap:Fleuve{nomf:"Tapajos"}),
(xin:Fleuve{nomf:"Xingu"})
// AFFLUENT
CREATE
(mar)-[:Affluent]->(ama),
(nap)-[:Affluent]->(ama),
(put)-[:Affluent]->(ama),
(caq)-[:Affluent]->(ama),
(neg)-[:Affluent]->(ama),
(uca)-[:Affluent]->(ama),
(jur)-[:Affluent]->(ama),
(pur)-[:Affluent]->(ama),
(mad)-[:Affluent]->(ama),
(tap)-[:Affluent]->(ama),
(xin)-[:Affluent]->(ama),
(alg)-[:Affluent]->(put),
(car)-[:Affluent]->(put),
(gua)-[:Affluent]->(put),
(gue)-[:Affluent]->(put),
(iga)-[:Affluent]->(put),
(san)-[:Affluent]->(put),
(yag)-[:Affluent]->(put),
(caq)-[:Affluent]->(put),
// EFFLUENT
(mar)<-[:Effluent]-(ama),
(nap)<-[:Effluent]-(ama),
(put)<-[:Effluent]-(ama),
(caq)<-[:Effluent]-(ama),
(neg)<-[:Effluent]-(ama),
(uca)<-[:Effluent]-(ama),
(jur)<-[:Effluent]-(ama),
(pur)<-[:Effluent]-(ama),
(mad)<-[:Effluent]-(ama),
(tap)<-[:Effluent]-(ama),
(xin)<-[:Effluent]-(ama),
(alg)<-[:Effluent]-(put),
(car)<-[:Effluent]-(put),
(gua)<-[:Effluent]-(put),
(gue)<-[:Effluent]-(put),
(iga)<-[:Effluent]-(put),
(san)<-[:Effluent]-(put),
(yag)<-[:Effluent]-(put),
(caq)<-[:Effluent]-(put);

// Exercice 2 : Interrogation du graphe
//Q1 Obtenir le nœud correspondant à l’Amazone.
MATCH (f:Fleuve {nomf:"Amazone"}) RETURN f;

//Q2 Obtenir le sous-graphe du fleuve Amazone avec les pays qu’il traverse.
MATCH (f:Fleuve{nomf:"Amazone"})-[t:Traverser]->(p:Pays) RETURN *;

//Q3 Obtenir le continent des pays que traverse l’Amazone.
MATCH (:Fleuve{nomf:"Amazone"})-[:Traverser]->(:Pays)-[:Situer]->(c:Continent) RETURN c;

//Q4 Obtenir les fleuves qui traversent le Brésil.
MATCH (f:Fleuve)-[:Traverser]->(:Pays {nomp:"Bresil"}) RETURN f;

//Q5 Obtenir les pays frontaliers du Brésil.
MATCH (p:Pays)-[:Frontalier]->(:Pays{nomp:"Bresil"}) RETURN p;

//Q6 Obtenir les fleuves localisés dans un seul pays (c’est-à-dire qui prennent source et qui se jettent dans le même pays).
MATCH (f:Fleuve)-[:Source]->(:Pays)<-[:Jeter]-(f:Fleuve) RETURN f;

//Q7 Obtenir les pays où se jettent les affluents de l’Amazone.
MATCH (p:Pays)<-[:Jeter]-(:Fleuve)-[:Affluent]->(:Fleuve{nomf:"Amazone"}) RETURN p;

//Q8 Obtenir les pays que traverse l’Amazone et dans lesquels prend source un affluent de ce dernier.
MATCH (p:Pays)<-[:Jeter]-(:Fleuve)-[:Affluent]->(:Fleuve{nomf:"Amazone"}) RETURN p;

//Q9 Obtenir les pays frontaliers de la Colombie dans lesquels prend source un effluent du fleuve Putumayo.
MATCH(:Pays{nomp:"Colombie"})<-[:Frontalier]-(p:Pays)<-[:Source]-(:Fleuve)-[:Effluent]-(:Fleuve{nomf:"Putumayo"}) 
RETURN DISTINCT(p);

//Q10 Obtenir tous les affluents de l’Amazone ainsi que les affluents de ces affluents.
MATCH(:Fleuve{nomf:"Amazone"})<-[:Affluent*1..2]-(f:Fleuve)RETURN*;

//Q11 Obtenir le nombre d’affluents de l’Amazone
MATCH(:Fleuve{nomf:"Amazone"})<-[:Affluent*]-(f:Fleuve)
WITH COUNT(f) AS nbAff
RETURN nbAff;

//Q12 Obtenir le nombre de pays frontalier de la Colombie.
MATCH (p:Pays)-[:Frontalier]->(:Pays{nomp:"Colombie"})
RETURN COUNT(p);

//Q13 Obtenir la longueur totale des frontières du Pérou.
MATCH (:Pays)<-[f:Frontalier]-(p:Pays{nomp:"Perou"})
WITH SUM(f.lng) AS lngTotale
RETURN lngTotale;

//Q14 Obtenir le nombre de pays que traverse l’Amazone.
MATCH (p:Pays)<-[:Traverser]-(:Fleuve{nomf:"Amazone"}) RETURN COUNT(p);

//Q15 Obtenir la longueur totale de l’Amazone jusqu’aux sources de ces différents affluents.
MATCH(a:Fleuve{nomf:"Amazone"})<-[:Affluent*]-(f:Fleuve)
WITH a, SUM(f.lng) + a.lng AS lng
RETURN lng;

//Q16 Obtenir le fleuve le plus court. 
MATCH (f:Fleuve)
WITH f, f.lng AS lng
WITH MIN(lng) AS minLng
MATCH (f:Fleuve)
WHERE f.lng = minLng
RETURN f;

//Q17 Obtenir le fleuve qui traverse le plus de pays.
MATCH (f:Fleuve)-[:Traverser]->(p:Pays)
WITH f, COUNT(DISTINCT p) AS nbPays
WITH MAX(nbPays) AS maxPays
MATCH (f:Fleuve)-[:Traverser]->(p:Pays)
WITH f, COUNT(DISTINCT p) AS nbPays, maxPays
WHERE nbPays = maxPays
RETURN f;

//Q18 Pour chaque pays, construire la liste des fleuves qui le traverse.
MATCH (f:Fleuve)-[:Traverser]->(p:Pays)
RETURN p.nomp AS pays, COLLECT(f.nomf) AS fleuves;

//Q19 Pour chaque fleuve, construire la liste des pays qu’il traverse.
MATCH (f:Fleuve)-[:Traverser]->(p:Pays)
RETURN f.nomf AS fleuves, COLLECT(p.nomp) AS pays;

 


--COURS:

(n)-[:Ecrire | :Editer]->(m)
• Relations de nom Ecrire ou de nom Editer de n vers m

 (n)-[*]->(m)
• Chemin de longueur variable de n’importe quel nombre de relations de n vers m

(n)-[*2..4]->(m)
• Chemin de longueur variable de 2, 3 ou 4 relations de n vers m 

shortestPath((n)-[*2..4]->(m))
• Un seul chemin le plus 

 allShortestPaths((n)-[*2..4]->(m))
• Tous les chemins les plus courts

//Noeuds
id(n)
• Identifiant interne (clé) du nœud n

nodes(path)
• Liste des nœuds des chemins

// Relations
 id(r)
• Identifiant interne (clé) de la relation r

MATCH p = (n)-[*]->(m)
• Chemin (path) représenté par p

length(path)
• Longueur (nombre de relations) des chemins

relationships(path)
• Liste des relations des chemins


//UNWIND 

MATCH (j:Joueur)-[:Appartenir]->(e:Equipe)
WITH e.nome AS nome, COLLECT(j.nom) AS les_joueurs
UNWIND les_joueurs AS un_joueur
RETURN nome, un_joueur

// IN 
WITH [0, 1, 2, 3, 4, 5, 6, 7, 8, 9] AS list
RETURN 1 IN list AS result

//ISEMPTY 
MATCH (j:Joueur)-[:Appartenir]->(e:Equipe)
WHERE j.age > 26
WITH e.nome AS nome, COLLECT(j.nom) AS les_joueurs
WHERE NOT ISEMPTY(les_joueurs)
RETURN *;

//ALL 
MATCH (j:Joueur)-[:Appartenir]->(e:Equipe)
WITH e.nome AS nome, COLLECT(j.nom) AS les_joueurs
WHERE ALL(x IN les_joueurs WHERE x.age > 20)
RETURN *;

MATCH p = (j:Joueur)-[:Appartenir]->(e:Equipe)
WHERE ALL(x IN nodes(p) WHERE x.age > 20 OR x.nome = "France")
RETURN *;

//ANY - NONE - SINGLE 
MATCH (j:Joueur)-[:Appartenir]->(e:Equipe)
WITH e.nome AS nome, COLLECT(j.nom) AS les_joueurs
WHERE ANY/NONE/SINGLE(x IN les_joueurs WHERE x.age > 25)
RETURN *;

//EXISTS 
Opérateur EXISTS : Retourne vrai si une correspondance pour le motif
existe dans le graphe

MATCH (j:Joueur)
WHERE EXISTS((j)-[:Appartenir]->())
RETURN j.nomj;


EXAM/// 

MATCH (a:Artiste)-[:CONSTITUER]->(g:Artiste:Groupe {nom: 'BTS'})
RETURN a.nom

MATCH (g:Artiste:Groupe)-[:INTERPRETER]->(c:Chanson {titre: 'Dynamite'})-[:COMPORTER]->(al:Album {titre: 'Be'})
RETURN g.nom

MATCH (p:Personne)-[:ECRIRE]->(c:Chanson)<-[:COMPOSER]-(p)
RETURN c.titre

MATCH (i:Personne)-[:INTERPRETER]->(c:Chanson {titre: 'Dynamite'}),
      (a:Personne)-[:ECRIRE]->(c),
      (co:Personne)-[:COMPOSER]->(c)
RETURN i.nom AS Interprete, a.nom AS Auteur, co.nom AS Compositeur


MATCH (g:Artiste:Groupe)-[:INTERPRETER]->(c:Chanson)<-[:INTERPRETER]-(p:Personne)-[:CONSTITUER]->(g)
RETURN c.titre


MATCH (al:Album)-[:COMPORTER]->(c:Chanson)
WITH al, COUNT(c) AS nbChansons
WHERE nbChansons = 12
RETURN al.titre









