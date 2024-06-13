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
WITH SIZE(a.roles) as nbr_roles
RETURN COUNT(nbr_roles);

//10. Obtenir l’âge moyen des acteurs du film Top Gun
MATCH (p:Person)-[a:ACTED_IN]->(m:Movie{title:"Top Gun"})
RETURN 2024-AVG(p.born);

//11. Obtenir la liste des films dans lesquels a joué Tom Hanks
MATCH (p:Person{name:"Tom Hanks"})-[a:ACTED_IN]->(m:Movie)
RETURN m.title;

//12. Obtenir la liste des films dans lesquels ont joué Tom Hanks et Gary Sinise
MATCH (p:Person{name:"Tom Hanks"})-[a:ACTED_IN]->(m:Movie)<-[a:ACTED_IN]-(pp:Person{name:"Gary Sinise"})
RETURN m.title;???

//13. Obtenir les acteurs qui ont joué dans plus de 5 films
//14. Obtenir les acteurs qui ont joué plus de 5 rôles
//15. Obtenir les films dans lesquels ont joué 5 acteurs
//16. Obtenir les films produits par 2 personnes
//17. Obtenir les acteurs qui ont joué entre 4 et 7 films
//18. Obtenir les acteurs qui ont joué dans le même nombre de films que Al Pacino
//19. Obtenir les films qui ont le même nombre d’acteurs que dans Top Gun
//20. Obtenir le film sur lequel le plus de personnes sont liées
//21. Obtenir le film dans lequel le plus d’acteurs ont joué
//22. Obtenir le film dans lequel l’acteur le plus jeune a joué