
//1.
CREATE
(a:Continent{nomc:"Amerique", sup:42.55}),

(bo:Pays{nomp:"Bolivie",cap:"La Paz",sup:1.10,pop:11.6, iso3:"BOL", iso2:"BO"}),
(br:Pays{nomp:"Bresil",cap:"Brasilia",sup:8.51,pop:211.7, iso3:"BRA", iso2:"BR"}),
(co:Pays{nomp:"Colombie",cap:"Bogota",sup:1.14,pop:49.1, iso3:"COL", iso2:"CO"}),
(eq:Pays{nomp:"Equateur",cap:"Quito",sup:0.28,pop:16.9, iso3:"ECU", iso2:"EC"}),
(pe:Pays{nomp:"Perou",cap:"Lima",sup:1.28,pop:31.9, iso3:"PER", iso2:"PE"}),
(ve:Pays{nomp:"Venezuela",cap:"Caracas",sup:0.92,pop:28.4, iso3:"VEN", iso2:"VE"}),
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

(bo)-[:Situer]->(a),
(br)-[:Situer]->(a),
(co)-[:Situer]->(a),
(eq)-[:Situer]->(a),
(pe)-[:Situer]->(a),
(ve)-[:Situer]->(a),
		
(co)-[:Frontalier{lng:1643}]->(br), 		
(co)-[:Frontalier{lng:590}]->(eq), 		
(co)-[:Frontalier{lng:1496}]->(pe), 		
(co)-[:Frontalier{lng:2050}]->(ve), 

(pe)-[:Frontalier{lng:900}]->(bo), 		
(pe)-[:Frontalier{lng:2995}]->(br), 		
(pe)-[:Frontalier{lng:1496}]->(co), 		
(pe)-[:Frontalier{lng:1420}]->(eq), 

(br)-[:Frontalier{lng:3423}]->(bo), 		
(br)-[:Frontalier{lng:2995}]->(pe), 		
(br)-[:Frontalier{lng:2200}]->(ve), 		
(br)-[:Frontalier{lng:2200}]->(co), 

(ve)-[:Frontalier{lng:2050}]->(co), 		
(ve)-[:Frontalier{lng:2200}]->(br),

(eq)-[:Frontalier{lng:1420}]->(pe), 		
(eq)-[:Frontalier{lng:590}]->(co), 		
 	
(bo)-[:Frontalier{lng:900}]->(pe), 		
(bo)-[:Frontalier{lng:3423}]->(br), 		

		
(put)-[:Traverser]->(pe),		
(put)-[:Traverser]->(co),		
(put)-[:Traverser]->(br),			
(put)-[:Traverser]->(eq),	

(alg)-[:Traverser]->(pe),

(car)-[:Traverser]->(co),	

(gua)-[:Traverser]->(co),	

(gue)-[:Traverser]->(co),		
(gue)-[:Traverser]->(eq),	

(iga)-[:Traverser]->(co),	

(jur)-[:Traverser]->(pe),			
(jur)-[:Traverser]->(br),	

(pur)-[:Traverser]->(pe),		
(pur)-[:Traverser]->(br),	

(mad)-[:Traverser]->(bo),	
(mad)-[:Traverser]->(br),		

(tap)-[:Traverser]->(br),			
(tap)-[:Traverser]->(br),	

(san)-[:Traverser]->(co),		
(san)-[:Traverser]->(eq),	

(yag)-[:Traverser]->(ve),	

(caq)-[:Traverser]->(co),		
(caq)-[:Traverser]->(br),	

(neg)-[:Traverser]->(co),		
(neg)-[:Traverser]->(ve),		
(neg)-[:Traverser]->(eq),	

(uca)-[:Traverser]->(pe),

(ama)-[:Traverser]->(pe), 		
(ama)-[:Traverser]->(co),	
(ama)-[:Traverser]->(br), 	

(mar)-[:Traverser]->(pe), 	

(nap)-[:Traverser]->(eq), 		
(nap)-[:Traverser]->(pe), 		
		

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

// 2.
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

//Interrogation du graphe
//1 Obtenir le nœud correspondant à l’Amazone.
MATCH (f:Fleuve {nomf:"Amazone"}) RETURN f;

//2 Obtenir le sous-graphe du fleuve Amazone avec les pays qu’il traverse.
MATCH (f:Fleuve{nomf:"Amazone"})-[t:Traverser]->(p:Pays) RETURN *;

//3 Obtenir le continent des pays que traverse l’Amazone.
MATCH (:Fleuve{nomf:"Amazone"})-[:Traverser]->(:Pays)-[:Situer]->(c:Continent) RETURN c;

//4 Obtenir les fleuves qui traversent le Brésil.
//a)
MATCH (f:Fleuve)-[t:Traverser]->(:Pays {nomp:"Bresil"}) RETURN f;
//b)
MATCH (f:Fleuve)-[t:Traverser]->(:Pays {nomp:"Bresil"}) RETURN COLLECT(f);

//5 Obtenir les pays frontaliers du Brésil.
//a)
MATCH (p:Pays)-[:Frontalier]->(:Pays{nomp:"Bresil"}) RETURN p;
//b) 
MATCH (p:Pays)-[:Frontalier]->(:Pays{nomp:"Bresil"}) RETURN COLLECT(p);

//6 Pour chaque pays, construire la liste des fleuves qui le traverse.
MATCH (f:Fleuve)-[:Traverser]->(p:Pays)
RETURN p.nomp AS pays, COLLECT(f.nomf) AS fleuves;

//7 Obtenir les fleuves localisés dans un seul pays (c’est-à-dire qui prennent source et qui se jettent dans le même pays).
MATCH (f:Fleuve)-[:Source]->(:Pays)<-[:Jeter]-(f:Fleuve) RETURN f;

//8 Idem, mais en utilisant la relation :Traverser.
MATCH (p:Pays)<-[:Source]-(f:Fleuve)-[:Traverser]->(p)<-[:Jeter]-(f)
RETURN f;

//ou (pas recommande)

MATCH (f:Fleuve)-[:Source]->(p:Pays)
WHERE NOT EXISTS {
    MATCH (f)-[:Traverser]->(other:Pays)
    WHERE other <> p
}
AND EXISTS {
    MATCH (f)-[:Jeter]->(p)
}
RETURN f;


//9 Obtenir les pays où se jettent les affluents de l’Amazone.
MATCH (p:Pays)<-[:Jeter]-(:Fleuve)-[:Affluent]->(:Fleuve{nomf:"Amazone"}) RETURN p;

//10 Obtenir les pays que traverse l’Amazone et dans lesquels prend source un affluent de ce dernier.
MATCH (p:Pays)<-[:Jeter]-(:Fleuve)-[:Affluent]->(:Fleuve{nomf:"Amazone"}) RETURN p;

//11 Obtenir les pays frontaliers de la Colombie dans lesquels prend source un effluent du fleuve Putumayo.
MATCH(:Pays{nomp:"Colombie"})<-[:Frontalier]-(p:Pays)<-[:Source]-(:Fleuve)-[:Effluent]-(:Fleuve{nomf:"Putumayo"}) 
RETURN DISTINCT(p);

//12 Obtenir tous les affluents de l’Amazone ainsi que les affluents de ces affluents.
MATCH(:Fleuve{nomf:"Amazone"})<-[:Affluent*1..2]-(f:Fleuve)RETURN*;

//13 Obtenir le nombre d’affluents de l’Amazone
MATCH(:Fleuve{nomf:"Amazone"})<-[:Affluent*]-(f:Fleuve)
WITH COUNT(f) AS nbAff
RETURN nbAff;

//14 Obtenir le nombre de pays frontalier de la Colombie.
MATCH (p:Pays)-[:Frontalier]->(:Pays{nomp:"Colombie"})
RETURN COUNT(p);

//15 Obtenir la longueur totale des frontières du Pérou.
MATCH (:Pays)<-[f:Frontalier]-(p:Pays{nomp:"Perou"})
WITH SUM(f.lng) AS lT
RETURN lT;

//16 Obtenir le nombre de pays que traverse l’Amazone.
MATCH (p:Pays)<-[:Traverser]-(:Fleuve{nomf:"Amazone"}) RETURN COUNT(p);

//17 Obtenir la longueur totale de l’Amazone jusqu’aux sources de ces différents affluents.
MATCH(a:Fleuve{nomf:"Amazone"})<-[:Affluent*]-(f:Fleuve)
WITH a, SUM(f.lng) + a.lng AS long
RETURN long;

//18 Obtenir le fleuve le plus court. 
MATCH (f:Fleuve)
WITH f, f.lng AS L
WITH MIN(L) AS minL
MATCH (f:Fleuve)
WHERE f.lng = minL
RETURN f;

//19 Obtenir le fleuve qui traverse le plus de pays.
MATCH (f:Fleuve)-[:Traverser]->(p:Pays)
WITH f, COUNT(DISTINCT p) AS nbPays
WITH MAX(nbPays) AS maxPays
MATCH (f:Fleuve)-[:Traverser]->(p:Pays)
WITH f, COUNT(DISTINCT p) AS nbPays, maxPays
WHERE nbPays = maxPays
RETURN f;

//20 Obtenir les pays dans lesquels aucun fleuve ne prend sa source.
MATCH (p:Pays)
WHERE NOT EXISTS {
    MATCH (:Fleuve)-[:Source]->(p)
}
RETURN p;

//21 Obtenir les pays dans lesquels un seul fleuve prend source.
MATCH (p:Pays)<-[:Source]-(f:Fleuve)
WITH p, COUNT(f) AS nbFleuves
WHERE nbFleuves = 1
RETURN p;
