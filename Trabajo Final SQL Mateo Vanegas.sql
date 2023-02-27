create table peliculas (
id_pelicula int not null,
titulo varchar (255) not null,
duracion time not null,
año smallint (4) not null,
sinopsis varchar  (255),
primary key (id_pelicula));

create table directores (
id_director int not null,
nombre_director varchar (255) not null,
año_nacimiento_director smallint(4) not null,
primary key (id_director));

create table actores (
id_actor int not null,
nombre_actor varchar (255) not null,
año_nacimiento_actor smallint(4) not null,
primary key (id_actor));


create table usuarios (
id_usuario int not null,
nombre_usuario varchar (255) not null,
apellido_usuario varchar (255) not null,
usuario_login varchar (50) not null,
usuario_contraseña varchar (50) not null,
primary key (id_usuario));

CREATE TABLE acciones (
  `id_accion` INT NOT NULL auto_increment ,
  `accion` VARCHAR(200) NULL,
  `fecha` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_accion`));

create table reseña (
id_reseña int not null,
id_pelicula int not null,
foreign key (id_pelicula) references peliculas(id_pelicula),
puntaje_imdb decimal,
primary key (id_reseña));

create table genero (
id_genero int not null,
genero varchar (255) not null,
primary key (id_genero));

create table genero_peliculas (
id_genero int not null,
foreign key (id_genero) references genero (id_genero),
id_pelicula int not null,
foreign key (id_pelicula) references peliculas(id_pelicula),
titulo_pelicula varchar (255) not null
);

create table dirigido_por (
id_pelicula int not null,
foreign key (id_pelicula) references peliculas(id_pelicula),
id_director int not null,
foreign key (id_director) references directores(id_director),
titulo_pelicula varchar (255) not null
);

create table actuo_en (
id_actor int not null,
foreign key (id_actor) references actores(id_actor),
id_pelicula int not null,
foreign key (id_pelicula) references peliculas(id_pelicula),
titulo_pelicula varchar (255) not null
);

create table reproducciones (
id_usuario int not null,
foreign key (id_usuario) references usuarios(id_usuario),
id_pelicula int not null,
foreign key (id_pelicula) references peliculas(id_pelicula),
titulo_pelicula varchar (255) not null,
reproducciones int not null
);


/*Trigger para solicitar titulo obligatorio*/
DELIMITER $$
CREATE DEFINER = CURRENT_USER TRIGGER `titulo_obligatorio` BEFORE INSERT ON `peliculas` FOR EACH ROW
BEGIN
if new.titulo is null then
set new.titulo = "Titulo Obligatorio";
END IF;
END
$$
DELIMITER ;

/*Trigger que almacena todas las acciones tomadas en la tabla peliculas en la tabla acciones*/

DELIMITER $$
CREATE DEFINER = CURRENT_USER TRIGGER `log_peliculas` AFTER INSERT ON `peliculas` FOR EACH ROW
BEGIN
insert into acciones (accion) value (concat("Se registró la pelicula:", new.titulo, "ID:", " ", new.id_pelicula ));
END$$
DELIMITER ;

SET @@AUTOCOMMIT=0;
SET FOREIGN_KEY_CHECKS=off;SET SQL_SAFE_UPDATES = 0;


start transaction;
insert into peliculas (id_pelicula, titulo, duracion, año, sinopsis) 
values 
(1,"Breve Encuentro", "1:26:00", 1945, "Al encontrarse con un extraño en una estación de tren, una mujer siente la tentación de engañar a su marido."),
(2,"Casablanca", "1:42:00", 1942, "Un cínico expatriado norteamericano, dueño de un café, se debate entre ayudar o no a su antigua amante y a su marido fugitivo a escapar de los nazis en el Marruecos frances."),
(3,"Antes del Amanecer", "1:41:00", 1995, "Un joven y una mujer se conocen en un tren en Europa y terminan pasando una noche juntos en Viena. Desafortunadamente, ambos saben que esta será probablemente la única noche que estén juntos."),
(4,"Antes del Atardecer", "1:20:00", 2004, "Nueve años después de conocerse, Jesse y Celine se reencuentran durante la gira del libro de Jesse en Francia."),
(5,"Al Final de la Escapada", "1:30:00", 1960, "Un ladrón de poca monta roba un coche y asesina de manera impulsiva a un motorista de la policía. Buscado por las autoridades, se reúne con una estudiante estadounidense de periodismo y trata de convencerla para que huya con él a Italia."),
(6,"Deseando Amar", "1:38:00", 2000, "Dos vecinos forman un fuerte vínculo después de que ambos sospechen de actividades extramatrimoniales de sus cónyuges. Sin embargo, acuerdan mantener su vínculo platónico para no cometer errores similares."),
(7,"El Apartamento", "2:05:00", 1960, "Al encontrarse con un extraño en una estación de tren, una mujer siente la tentación de engañar a su marido."),
(8,"Hannah y sus Hermanas", "1:47:00", 1986, "En el año que transcurre entre dos días de Acción de Gracias, el marido de Hanna se enamora de su hermana Lee, y su hipocondríaco exmarido empieza a salir con su hermana Holly."),
(9,"¡Olvídate de Mí!", "1:48:00", 2004, "Cuando su relación se deteriora, una pareja se somete a un proceso médico para borrar el uno al otro de su memoria."),
(10,"Una Habitación con Vistas", "1:48:00", 1985, "Lucy conoce a George en una pensión de Florencia y ambos comparten un breve romance antes de que Lucy regrese a casa, donde se compromete con Cecil. Sin embargo, no pasa mucho tiempo antes de que George vuelva a entrar en su vida.");
savepoint spp1;
-- release savepoint spp1
-- commit
start transaction;
insert into peliculas (id_pelicula,titulo, duracion, año, sinopsis) 
values 
(11,"Chinatown", "2:10:00", 1974, "Un detective privado, contratado para desenmascarar a un adúltero en Los Ángeles de los años 30, se ve envuelto en una red de engaños, corrupción y asesinato."),
(12,"Sed de mal", "1:35:00", 1958, "Una perversa historia de asesinato, secuestro y corrupción policial en una ciudad mexicana fronteriza."),
(13,"Vértigo", "2:18:00", 1958, "Un antiguo detective de la policía de San Francisco lucha contra sus demonios personales y se obsesiona con la inquietantemente bella mujer por la que ha sido contratado para seguirle el rastro, que podría estar profundamente perturbada."),
(14,"Malas tierras", "1:34:00", 1973, "Una adolescente ingenua de un pueblo de mala muerte, y su novio engominado, más mayor, cometen una ola de asesinatos en los páramos de Dakota del sur."),
(15,"Rashomon", "1:28:00", 1950, "Se narra la violación de una novia y el asesinato de su marido samurái desde el punto de vista de un bandido, de la novia, del fantasma del samurái y de un leñador."),
(16,"Perdición", "1:47:00", 1944, "Un vendedor de seguros de Los Ángeles se deja seducir por un ama de casa para participar en un plan de fraude y asesinato que despierta las sospechas de su colega, un investigador."),
(17,"Asesino implacable", "1:52:00", 1971, "Cuando su hermano muere en circunstancias misteriosas en un accidente automovilístico, el gángster londinense Jack Carter viaja a Newcastle para investigar."),
(18,"Pulp Fiction", "2:34:00", 1994, "Las vidas de dos mafiosos, un boxeador, la esposa de un gánster y un par de bandidos se entrelazan en cuatro historias de violencia y redención."),
(19,"Caché. Escondido", "1:57:00", 2005, "Un matrimonio se ve aterrorizado por una serie de videos de vigilancia que les están dejando en el porche delantero."),
(20,"Uno de los nuestros", "2:25:00", 1990, "La historia de Henry Hill y su vida en la mafia, abarcando su relación con su esposa Karen Hill y sus socios mafiosos Jimmy Conway y Tommy DeVito en el sindicato del crimen italoamericano.");
savepoint spp2;
-- release savepoint spp2
commit;


--  Sentencia Rollback, Commit
/*Start transaction;
Delete from peliculas  where id_pelicula = 4;
Delete from peliculas  where id_pelicula = 5;
Delete from peliculas  where id_pelicula = 6;
-- Rollback
-- commit
/* insert into peliculas (id_pelicula, titulo, duracion, año, sinopsis) 
values
(4,"Antes del Atardecer", "1:20:00", 2004, "Nueve años después de conocerse, Jesse y Celine se reencuentran durante la gira del libro de Jesse en Francia."),
(5,"Al Final de la Escapada", "1:30:00", 1960, "Un ladrón de poca monta roba un coche y asesina de manera impulsiva a un motorista de la policía. Buscado por las autoridades, se reúne con una estudiante estadounidense de periodismo y trata de convencerla para que huya con él a Italia."),
(6,"Deseando Amar", "1:38:00", 2000, "Dos vecinos forman un fuerte vínculo después de que ambos sospechen de actividades extramatrimoniales de sus cónyuges. Sin embargo, acuerdan mantener su vínculo platónico para no cometer errores similares."); */

select * from peliculas;

-- Sentencia Savepoint
start transaction;
insert into directores (id_director, nombre_director, año_nacimiento_director) values 
(1,"David Lean", "1908"),
(2,"Michael Curtiz", "1886"),
(3,"Richard Linklater", "1960"),
(4,"Jean-Luc Godard", "1930"),
(5,"Kar-Wai Wong", "1956"),
(6,"Billy Wilder", "1906"),
(7,"Woody Allen", "1935"),
(8,"James Ivory", "1928"),
(9,"Michel Gondry", "1963");
savepoint spd1;
-- release savepoint spd1
-- commit
start transaction;
insert into directores (id_director, nombre_director, año_nacimiento_director) values 
(10,"Roman Polanski", "1933"),
(11,"Orson Welles", "1915"),
(12,"Alfred Hitchcock", "1899"),
(13,"Terrence Malick", "1943"),
(14,"Akira Kurosawa", "1910"),
(15,"Mike Hodges", "1932"),
(16,"Qentin Tarantino", "1963"),
(17,"Michael Haneke", "1942"),
(18,"Martin Scorssese", "1942");
savepoint spd2;
-- release savepoint spd2
-- commit


start transaction;
insert into actores (id_actor, nombre_actor, año_nacimiento_actor) values 
(1,"Celia Johnson", 1908),
(2,"Trevor Howard", 1913),
(3,"Stanley Holloway", 1890),
(4,"Humphrey Bogart", 1899),
(5,"Ingrid Bergman", 1915),
(6,"Paul Henreid", 1908),
(7,"Ethan Hawke", 1970),
(8,"Julie Delpy", 1969),
(9,"Vernon Dobtcheff", 1934),
(10,"Jean-Paul Belmondo", 1933),
(11,"Jean Seberg", 1938),
(12,"Daniel Boulanger", 1922),
(13,"Tony Chiu-Wai Leung", 1962),
(14,"Maggie Cheung", 1964),
(15,"Jack Lemmon", 1925),
(16,"Shirley MacLaine", 1934),
(17,"Fred MacMurray", 1908),
(18,"Mia Farrow", 1945),
(19,"Dianne Wiest", 1946),
(20,"Michael Caine", 1933),
(21,"Jim Carrey", 1962),
(22,"Kate Winslet", 1975),
(23,"Tom Wilkinson", 1948),
(24,"Helena Bonham Carter", 1966),
(25,"Julian Sands", 1958),
(26,"Maggie Smith", 1934);
savepoint spa1;
-- release savepoint spa1
-- commit
start transaction;
insert into actores (id_actor, nombre_actor, año_nacimiento_actor) values 
(27,"Jack Nicholson", 1937),
(28,"Faye Dunaway", 1941),
(29,"Charlton Heston", 1923),
(30,"Orson Welles", 1915),
(31,"James Stewart", 1908),
(32,"Kim Novak", 1933),
(33,"Martin Sheen", 1940),
(34,"Sissy Spacek", 1949),
(35,"Toshirô Mifune", 1920),
(36,"Machiko Kyô", 1924),
(37,"Fred MacMurray", 1908),
(38,"Barbara Stanwyck", 1907),
(39,"Ian Hendry", 1931),
(40,"John Travolta", 1954),
(41,"Uma Thurman", 1970),
(42,"Daniel Auteuil", 1950),
(43,"Juliette Binoche", 1964),
(44,"Robert De Niro", 1943),
(45,"Ray Liotta", 1954);
savepoint spa2;
-- release savepoint spa2
-- commit

start transaction; 
insert into usuarios (id_usuario, nombre_usuario, apellido_usuario, usuario_login, usuario_contraseña)
values
(1, "Juanito", "Perez" "jperez90" "ilovecinema"),
(2, "Ricardo", "Zapata" "richiez95" "inception25"),
(3, "Daniela", "Martinez" "danimarti78" "woody78"),
(4, "Juliana", "Ochoa" "ochoj22" "robbertpattinson"),
(5, "Felipe", "Mesa" "mesa9520" "iloveyouanne"),
(6, "Estefania", "Moscato" "estefimosca" "coppola71"),
(7, "Camila", "Upegui" "DiCaprio99" "bradpitt2000"),
(8, "Antonio", "Estrada" "antonioestrada70" "akirakurosawa"),
(9, "Adriana", "Ruiz" "ruizadri45" "casablanca45"),
(10, "Angelica", "Ponce" "aponce04" "vengadores");
savepoint spu1;
-- release savepoint spa1
-- commit

start transaction;
insert into reseña (id_reseña, id_pelicula, puntaje_imdb) values
(1,1, 8.0),
(2,2, 8.5),
(3,3, 8.1),
(4,4, 8.1),
(5,5, 7.7),
(6,6, 8.1),
(7,7, 8.3),
(8,8, 7.9),
(9,9, 8.3),
(10,10, 7.2);
savepoint spr1;
-- release savepoint spr1
-- commit
start transaction;
insert into reseña (id_reseña, id_pelicula, puntaje_imdb) values
(11,11, 8.2),
(12,12, 8.0),
(13,13, 8.3),
(14,14, 7.7),
(15,15, 8.2),
(16,16, 8.3),
(17,17, 7.3),
(18,18, 8.9),
(19,19, 7.3),
(20,20, 8.7);
savepoint spr2;
-- release savepoint spr2
-- commit

start transaction;
insert into genero (id_genero,genero) values
(1,"Romance"),
(2, "Crimen"),
(3,"Comedia"),
(4,"Accion"),
(5,"Drama"),
(6,"Ciencia Ficcion y Fantasia"),
(7,"Terror");
savepoint spg1;
-- release savepoint spg1
-- commit

start transaction;
insert into genero_peliculas (id_genero, id_pelicula, titulo_pelicula) values 
(1,1, "Breve Encuentro"),
(1,2, "Casablanca"),
(1,3, "Antes del Amanecer"),
(1,4, "Antes del Atardecer"),
(1,5, "Al Final de la Escapada"),
(1,6, "Deseando Amar"),
(1,7, "El Apartamento"),
(1,8, "Hannah y sus Hermanas"),
(1,9, "¡Olvídate de Mí!"),
(1,10, "Una Habitación con Vistas");
savepoint spgp1;
-- release savepoint spgp1
-- commit
start transaction;
insert into genero_peliculas (id_genero, id_pelicula, titulo_pelicula) values 
(2,11, "Chinatown"),
(2,12, "Sed de mal"),
(2,13, "Vértigo"),
(2,14, "Malas Tierras"),
(2,15, "Rashomon"),
(2,16, "Perdición"),
(2,17, "Asesino implacable"),
(2,18, "Pulp Fiction"),
(2,19, "Caché. Escondido"),
(2,20, "Uno de los nuestros");
savepoint spgp2;
-- release savepoint spgp2
-- commit

start transaction;
insert into dirigido_por (id_pelicula, id_director, titulo_pelicula) values 
(1,1, "Breve Encuentro"),
(2,2, "Casablanca"),
(3,3, "Antes del Amanecer"),
(4,3, "Antes del Atardecer"),
(5,4,"Al Final de la Escapada"),
(6,5, "Deseando Amar"),
(7,6, "El Apartamento"),
(8,7, "Hannah y sus Hermanas"),
(9,8, "¡Olvídate de Mí!"),
(10,9, "Una Habitación con Vistas");
savepoint spdp1;
-- release savepoint spdp1
-- commit
start transaction;
insert into dirigido_por (id_pelicula, id_director, titulo_pelicula) values 
(11,10, "Chinatown"),
(12,11, "Sed de mal"),
(13,12, "Vértigo"),
(14,13, "Malas Tierras"),
(15,14,"Rashomon"),
(16,6, "Perdición"),
(17,15, "Asesino implacable"),
(18,16, "Pulp Fiction"),
(19,17, "Caché. Escondido"),
(20,18, "Uno de los nuestros");
savepoint spdp2;
-- release savepoint spdp2
-- commit
start transaction;
insert into actuo_en (id_actor, id_pelicula, titulo_pelicula) values
(1,1, "Breve Encuentro"),
(2,1, "Breve Encuentro"),
(3,1, "Breve Encuentro"),
(4,2, "Casablanca"),
(5,2, "Casablanca"),
(6,2, "Casablanca"),
(7,3, "Antes del Amanecer"),
(8,3, "Antes del Amanecer"),
(9,4, "Antes del Atardecer"),
(10,5, "Al Final de la Escapada"),
(11,5, "Al Final de la Escapada"),
(12,5, "Al Final de la Escapada"),
(13,6, "Deseando Amar"),
(14,6, "Deseando Amar"),
(15,7, "El Apartamento"),
(16,7, "El Apartamento"),
(17,7, "El Apartamento"),
(18,8, "Hannah y sus Hermanas"),
(19,8, "Hannah y sus Hermanas"),
(20,8, "Hannah y sus Hermanas"),
(21,9, "¡Olvídate de Mí!"),
(22,9, "¡Olvídate de Mí!"),
(23,9, "¡Olvídate de Mí!"),
(24,10, "Una Habitación con Vistas"),
(25,10, "Una Habitación con Vistas"),
(26,10, "Una Habitación con Vistas");
savepoint spae1;
-- release savepoint spae1
-- commit
start transaction;
insert into actuo_en (id_actor, id_pelicula, titulo_pelicula) values
(27,11, "Chinatown"),
(28,11, "Chinatown"),
(29,12, "Sed de mal"),
(30,12, "Sed de mal"),
(31,13, "Vértigo"),
(32,13, "Vértigo"),
(33,14, "Malas Tierras"),
(34,14, "Malas Tierras"),
(35,15, "Rashomon"),
(36,15, "Rashomon"),
(37,16, "Perdición"),
(38,16, "Perdición"),
(39,17, "Asesino implacable"),
(20,17, "Asesino implacable"),
(40,18, "Pulp Fiction"),
(41,18, "Pulp Fiction"),
(42,19, "Caché. Escondido"),
(43,19, "Caché. Escondido"),
(44,20, "Uno de los nuestros"),
(45,20, "Uno de los nuestros");
savepoint spae2;
-- release savepoint spae2
-- commit

start transaction;
insert into reproducciones (id_usuario, id_pelicula, titulo_pelicula, reproducciones) values 
(1,1, "Breve Encuentro", 0),
(1,2, "Casablanca", 2),
(1,3, "Antes del Amanecer", 1),
(1,4, "Antes del Atardecer", 3),
(1,5, "Al Final de la Escapada", 0),
(1,6, "Deseando Amar", 1),
(1,7, "El Apartamento", 2),
(1,8, "Hannah y sus Hermanas", 4),
(1,9, "¡Olvídate de Mí!", 0),
(1,10, "Una Habitación con Vistas", 1);
savepoint sprp1;
-- release savepoint spgp1
-- commit
start transaction;
insert into reproducciones (id_usuario, id_pelicula, titulo_pelicula, reproducciones) values 
(1,11, "Chinatown", 5),
(1,12, "Sed de mal", 4),
(1,13, "Vértigo", 3),
(1,14, "Malas Tierras", 1),
(1,15, "Rashomon", 5),
(1,16, "Perdición", 6),
(1,17, "Asesino implacable", 2),
(1,18, "Pulp Fiction", 3),
(1,19, "Caché. Escondido", 0),
(1,20, "Uno de los nuestros", 1);
savepoint sprp2;
-- release savepoint sprp2
-- commit


start transaction;
insert into reproducciones (id_usuario, id_pelicula, titulo_pelicula, reproducciones) values 
(2,1, "Breve Encuentro", 1),
(2,2, "Casablanca", 0),
(2,3, "Antes del Amanecer", 3),
(2,4, "Antes del Atardecer", 2),
(2,5, "Al Final de la Escapada", 0),
(2,6, "Deseando Amar", 4),
(2,7, "El Apartamento", 0),
(2,8, "Hannah y sus Hermanas", 1),
(2,9, "¡Olvídate de Mí!", 0),
(2,10, "Una Habitación con Vistas", 2);
savepoint sprp3;
-- release savepoint spgp3
-- commit
start transaction;
insert into reproducciones (id_usuario, id_pelicula, titulo_pelicula, reproducciones) values 
(2,11, "Chinatown", 2),
(2,12, "Sed de mal", 0),
(2,13, "Vértigo", 3),
(2,14, "Malas Tierras", 2),
(2,15, "Rashomon", 0),
(2,16, "Perdición", 0),
(2,17, "Asesino implacable", 2),
(2,18, "Pulp Fiction", 1),
(2,19, "Caché. Escondido", 1),
(2,20, "Uno de los nuestros", 0);
savepoint sprp4;
-- release savepoint sprp4
-- commit

start transaction;
insert into reproducciones (id_usuario, id_pelicula, titulo_pelicula, reproducciones) values 
(3,1, "Breve Encuentro", 0),
(3,2, "Casablanca", 1),
(3,3, "Antes del Amanecer", 2),
(3,4, "Antes del Atardecer", 1),
(3,5, "Al Final de la Escapada", 2),
(3,6, "Deseando Amar", 0),
(3,7, "El Apartamento", 2),
(3,8, "Hannah y sus Hermanas", 1),
(3,9, "¡Olvídate de Mí!", 1),
(3,10, "Una Habitación con Vistas", 1);
savepoint sprp5;
-- release savepoint spgp5
-- commit
start transaction;
insert into reproducciones (id_usuario, id_pelicula, titulo_pelicula, reproducciones) values 
(3,11, "Chinatown", 1),
(3,12, "Sed de mal", 2),
(3,13, "Vértigo", 0),
(3,14, "Malas Tierras", 1),
(3,15, "Rashomon", 2),
(3,16, "Perdición", 8),
(3,17, "Asesino implacable", 0),
(3,18, "Pulp Fiction", 0),
(3,19, "Caché. Escondido", 0),
(3,20, "Uno de los nuestros", 1);
savepoint sprp6;
-- release savepoint sprp6
-- commit

start transaction;
insert into reproducciones (id_usuario, id_pelicula, titulo_pelicula, reproducciones) values 
(4,1, "Breve Encuentro", 4),
(4,2, "Casablanca", 1),
(4,3, "Antes del Amanecer", 2),
(4,4, "Antes del Atardecer", 0),
(4,5, "Al Final de la Escapada", 1),
(4,6, "Deseando Amar", 0),
(4,7, "El Apartamento", 2),
(4,8, "Hannah y sus Hermanas", 0),
(4,9, "¡Olvídate de Mí!", 0),
(4,10, "Una Habitación con Vistas", 0);
savepoint sprp6;
-- release savepoint spgp6
-- commit
start transaction;
insert into reproducciones (id_usuario, id_pelicula, titulo_pelicula, reproducciones) values 
(4,11, "Chinatown", 5),
(4,12, "Sed de mal", 4),
(4,13, "Vértigo", 3),
(4,14, "Malas Tierras", 1),
(4,15, "Rashomon", 5),
(4,16, "Perdición", 6),
(4,17, "Asesino implacable", 2),
(4,18, "Pulp Fiction", 3),
(4,19, "Caché. Escondido", 0),
(4,20, "Uno de los nuestros", 1);
savepoint sprp6;
-- release savepoint sprp6
-- commit

start transaction;
insert into reproducciones (id_usuario, id_pelicula, titulo_pelicula, reproducciones) values 
(5,1, "Breve Encuentro", 1),
(5,2, "Casablanca", 4),
(5,3, "Antes del Amanecer", 0),
(5,4, "Antes del Atardecer", 2),
(5,5, "Al Final de la Escapada", 1),
(5,6, "Deseando Amar", 0),
(5,7, "El Apartamento", 1),
(5,8, "Hannah y sus Hermanas", 5),
(5,9, "¡Olvídate de Mí!", 8),
(5,10, "Una Habitación con Vistas", 0);
savepoint sprp7;
-- release savepoint spgp7
-- commit
start transaction;
insert into reproducciones (id_usuario, id_pelicula, titulo_pelicula, reproducciones) values 
(5,11, "Chinatown", 1),
(5,12, "Sed de mal", 2),
(5,13, "Vértigo", 0),
(5,14, "Malas Tierras", 0),
(5,15, "Rashomon", 0),
(5,16, "Perdición", 0),
(5,17, "Asesino implacable", 2),
(5,18, "Pulp Fiction", 8),
(5,19, "Caché. Escondido", 2),
(5,20, "Uno de los nuestros", 10);
savepoint sprp8;
-- release savepoint sprp8
-- commit

start transaction;
insert into reproducciones (id_usuario, id_pelicula, titulo_pelicula, reproducciones) values 
(6,1, "Breve Encuentro", 10),
(6,2, "Casablanca", 12),
(6,3, "Antes del Amanecer", 11),
(6,4, "Antes del Atardecer", 13),
(6,5, "Al Final de la Escapada", 20),
(6,6, "Deseando Amar", 10),
(6,7, "El Apartamento", 8),
(6,8, "Hannah y sus Hermanas", 4),
(6,9, "¡Olvídate de Mí!", 25),
(6,10, "Una Habitación con Vistas", 12);
savepoint sprp9;
-- release savepoint spgp9
-- commit
start transaction;
insert into reproducciones (id_usuario, id_pelicula, titulo_pelicula, reproducciones) values 
(6,11, "Chinatown", 0),
(6,12, "Sed de mal", 1),
(6,13, "Vértigo", 3),
(6,14, "Malas Tierras", 0),
(6,15, "Rashomon", 0),
(6,16, "Perdición", 0),
(6,17, "Asesino implacable", 0),
(6,18, "Pulp Fiction", 2),
(6,19, "Caché. Escondido", 0),
(6,20, "Uno de los nuestros", 1);
savepoint sprp10;
-- release savepoint sprp10
-- commit

start transaction;
insert into reproducciones (id_usuario, id_pelicula, titulo_pelicula, reproducciones) values 
(7,1, "Breve Encuentro", 0),
(7,2, "Casablanca", 1),
(7,3, "Antes del Amanecer", 1),
(7,4, "Antes del Atardecer", 0),
(7,5, "Al Final de la Escapada", 0),
(7,6, "Deseando Amar", 0),
(7,7, "El Apartamento", 2),
(7,8, "Hannah y sus Hermanas", 4),
(7,9, "¡Olvídate de Mí!", 0),
(7,10, "Una Habitación con Vistas", 1);
savepoint sprp11;
-- release savepoint spgp11
-- commit
start transaction;
insert into reproducciones (id_usuario, id_pelicula, titulo_pelicula, reproducciones) values 
(7,11, "Chinatown", 5),
(7,12, "Sed de mal", 4),
(7,13, "Vértigo", 3),
(7,14, "Malas Tierras", 1),
(7,15, "Rashomon", 5),
(7,16, "Perdición", 6),
(7,17, "Asesino implacable", 2),
(7,18, "Pulp Fiction", 3),
(7,19, "Caché. Escondido", 5),
(7,20, "Uno de los nuestros", 1);
savepoint sprp12;
-- release savepoint sprp12
-- commit

start transaction;
insert into reproducciones (id_usuario, id_pelicula, titulo_pelicula, reproducciones) values 
(8,1, "Breve Encuentro", 1),
(8,2, "Casablanca", 12),
(8,3, "Antes del Amanecer", 3),
(8,4, "Antes del Atardecer", 5),
(8,5, "Al Final de la Escapada", 4),
(8,6, "Deseando Amar", 1),
(8,7, "El Apartamento", 2),
(8,8, "Hannah y sus Hermanas", 0),
(8,9, "¡Olvídate de Mí!", 10),
(8,10, "Una Habitación con Vistas", 1);
savepoint sprp13;
-- release savepoint spgp13
-- commit
start transaction;
insert into reproducciones (id_usuario, id_pelicula, titulo_pelicula, reproducciones) values 
(8,11, "Chinatown", 15),
(8,12, "Sed de mal", 14),
(8,13, "Vértigo", 13),
(8,14, "Malas Tierras", 1),
(8,15, "Rashomon", 15),
(8,16, "Perdición", 16),
(8,17, "Asesino implacable", 12),
(8,18, "Pulp Fiction", 13),
(8,19, "Caché. Escondido", 0),
(8,20, "Uno de los nuestros", 11);
savepoint sprp14;
-- release savepoint sprp14
-- commit

start transaction;
insert into reproducciones (id_usuario, id_pelicula, titulo_pelicula, reproducciones) values 
(9,1, "Breve Encuentro", 0),
(9,2, "Casablanca", 2),
(9,3, "Antes del Amanecer", 1),
(9,4, "Antes del Atardecer", 3),
(9,5, "Al Final de la Escapada", 0),
(9,6, "Deseando Amar", 1),
(9,7, "El Apartamento", 2),
(9,8, "Hannah y sus Hermanas", 4),
(9,9, "¡Olvídate de Mí!", 0),
(9,10, "Una Habitación con Vistas", 1);
savepoint sprp15;
-- release savepoint spgp15
-- commit
start transaction;
insert into reproducciones (id_usuario, id_pelicula, titulo_pelicula, reproducciones) values 
(9,11, "Chinatown", 0),
(9,12, "Sed de mal", 1),
(9,13, "Vértigo", 0),
(9,14, "Malas Tierras", 1),
(9,15, "Rashomon", 0),
(9,16, "Perdición", 1),
(9,17, "Asesino implacable", 0),
(9,18, "Pulp Fiction", 1),
(9,19, "Caché. Escondido", 0),
(9,20, "Uno de los nuestros", 1);
savepoint sprp16;
-- release savepoint sprp16
-- commit

start transaction;
insert into reproducciones (id_usuario, id_pelicula, titulo_pelicula, reproducciones) values 
(10,1, "Breve Encuentro", 0),
(10,2, "Casablanca", 3),
(10,3, "Antes del Amanecer", 3),
(10,4, "Antes del Atardecer", 3),
(10,5, "Al Final de la Escapada", 5),
(10,6, "Deseando Amar", 1),
(10,7, "El Apartamento", 6),
(10,8, "Hannah y sus Hermanas", 4),
(10,9, "¡Olvídate de Mí!", 10),
(10,10, "Una Habitación con Vistas", 1);
savepoint sprp17;
-- release savepoint sprp17
-- commit
start transaction;
insert into reproducciones (id_usuario, id_pelicula, titulo_pelicula, reproducciones) values 
(10,11, "Chinatown", 15),
(10,12, "Sed de mal", 0),
(10,13, "Vértigo", 3),
(10,14, "Malas Tierras", 0),
(10,15, "Rashomon", 0),
(10,16, "Perdición", 1),
(10,17, "Asesino implacable", 2),
(10,18, "Pulp Fiction", 12),
(10,19, "Caché. Escondido", 1),
(10,20, "Uno de los nuestros", 1);
savepoint sprp18;
-- release savepoint sprp18
-- commit
 select * from reproducciones; 


/*Vista peliculas dirigidas por*/
create view pelicula_dirigida as
(select distinct titulo as pelicula, nombre_director as director from peliculas p join dirigido_por dp on (p.titulo = dp.titulo_pelicula) join directores d on (d.id_director = dp.id_director));

select * from pelicula_dirigida;

/*Vista peliculas aclamadas por la critica con un puntaje mayor a 7.5 en imdb*/
create view aclamadas_critica as
(select distinct titulo as pelicula, puntaje_imdb as puntaje from peliculas p join reseña r on (p.id_pelicula = r.id_pelicula)

where puntaje_imdb > 7.5)
order by puntaje_imdb;

select * from aclamadas_critica;

/*Vista actores que participaron en la pelicula*/
create view actores_peliculas as
(select distinct nombre_actor as actor, titulo as pelicula from peliculas p join actuo_en ae on (p.titulo = ae.titulo_pelicula) join actores a on (a.id_actor = ae.id_actor));

select * from actores_peliculas;


/*Vista genero de las peliculas*/
create view genero_pelicula as
(select distinct genero, titulo as pelicula from peliculas p join genero_peliculas gp on (p.titulo = gp.titulo_pelicula) join genero g on (g.id_genero = gp.id_genero));

select * from genero_pelicula;

/*Vista peliculas que salieron en los ultimos 50 años*/
create view peliculas_nuevas as
(select distinct titulo as pelicula, año  from peliculas where (año > 1973))
order by año;

select * from peliculas_nuevas;

/*Funcion para saber que director corresponde a cada ID*/
DELIMITER $$
CREATE FUNCTION `directores` (director int)
RETURNS varchar (255)
deterministic reads sql data
BEGIN

RETURN 
(select nombre_director from directores where id_director = director);
END$$

DELIMITER ;

/*Funcion para saber que actor corresponde a cada ID*/
DELIMITER $$
CREATE FUNCTION `actores` (actor int)
RETURNS varchar (255)
deterministic reads sql data
BEGIN

RETURN 
(select nombre_actor from actores where id_actor = actor);
END $$
DELIMITER //


select * from acciones;