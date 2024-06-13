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

