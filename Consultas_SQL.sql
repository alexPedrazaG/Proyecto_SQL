/*
 * 2.Muestra los nombres de todas las películas con una clasificación por edades de ‘R’
 */
select f.title as "nombre_pelicula" 
from film f 
where f.rating ='R';


/*
 * 3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.
 */
select concat(a.first_name , ' ', a.last_name) as "nombre_completo_actor" 
from actor a 
where a.actor_id between 30 and 40;


/*
 * 4. Obtén las películas cuyo idioma coincide con el idioma original.
 */
select distinct f.original_language_id --f.title as "nombre_pelicula" 
from film f;
--No se puede realizar este ejercicio porque el valor del campo original_language_id es nulo
--Si no tendría que hacer un inner join contra la tabla language y cruzar por language_id y original_language_id


/*
 * 5. Ordena las películas por duración de forma ascendente.
 */
select f.title as "nombre_pelicula", f.length as "duracion"
from film f
order by f.length asc;


/*
 * 6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su
apellido.
 */
select concat(a.first_name , ' ', a.last_name) as "nombre_completo_actor" 
from actor a 
where a.last_name='ALLEN';


/*
 * 7. Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y 
  muestra la clasificación junto con el recuento.
 */
select count(*), f.rating as "clasificacion" 
from film f
group by f.rating 
order by count(*) asc;


/*
 * 8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una
duración mayor a 3 horas en la tabla film.
 */
select f.title as "nombre_pelicula"
from film f
where (f.rating='PG-13' or f.length > 180);


/*
 * 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.
 */
select STDDEV(f.replacement_cost) AS "desviacion_estandar"
from film f;


/*
 * 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.
 */
select max(f.length) AS "mayor_duracion_pelicula",
min(f.length) AS "menor_duracion_pelicula"
from film f;


/*
 * 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
 */
select r.rental_id as "Alquiler", p.amount as "Coste"
from film f;


/*
 * 12. Encuentra el título de las películas en la tabla “film” que no sean ni 
 * ‘NC-17’ ni ‘G’ en cuanto a su clasificación.
 */
select f.title as "nombre_pelicula"
from film f
where f.rating not in ('NC-17', 'G');


/*
 * 13. Encuentra el promedio de duración de las películas para cada
clasificación de la tabla film y muestra la clasificación junto con el
promedio de duración.
 */
select AVG(f.length) as "Promedio_duracion", f.rating as "clasificacion" 
from film f
group by f.rating
order by "Promedio_duracion";


/*
 * 14. Encuentra el título de todas las películas que tengan una duración mayor
a 180 minutos.
 */
select f.title as "nombre_pelicula"
from film f
where f.length > 180;


/*
 * 15. ¿Cuánto dinero ha generado en total la empresa?
 */
-- Entiendo que son dos empresas
select s.store_id ,sum(p.amount) as "total_por_empresa"
from store s 
inner join customer c on s.store_id=c.store_id 
inner join payment p on c.customer_id =p.customer_id
group by s.store_id 
order by s.store_id;


/*
 * 16. Muestra los 10 clientes con mayor valor de id.
 */
select *
from customer c 
order by c.customer_id  desc
limit 10;


/*
 * 17. Encuentra el nombre y apellido de los actores que aparecen en la
película con título ‘Egg Igby’.
 */
select concat(a.first_name , ' ', a.last_name) as "nombre_completo_actor" 
from actor a  
inner join film_actor fa on a.actor_id = fa.actor_id
inner join film f on fa.film_id =f.film_id
where f.title ='EGG IGBY';


/*
 * 18. Selecciona todos los nombres de las películas únicos.
 */
select distinct f.title as "nombre_pelicula" 
from film f
order by nombre_pelicula ;


/*
 * 19. Encuentra el título de las películas que son comedias y tienen una
duración mayor a 180 minutos en la tabla “film”.
 */
select f.title as "nombre_pelicula"
from film f
inner join film_category fc on f.film_id = fc.film_id
inner join category c on fc.category_id = c.category_id
where c.name='Comedy' and f.length > 180;


/*
 * 20. Encuentra las categorías de películas que tienen un promedio de
duración superior a 110 minutos y muestra el nombre de la categoría
junto con el promedio de duración
 */
select conjunto.name, conjunto."Promedio_mas_110"
from(
select c.name, AVG(f.length) as "Promedio_mas_110"
from film f
inner join film_category fc on f.film_id = fc.film_id
inner join category c on fc.category_id = c.category_id
group by c.name
) as conjunto
where conjunto."Promedio_mas_110" > 110
order by conjunto."Promedio_mas_110";


/*
 * 21. ¿Cuál es la media de duración del alquiler de las películas?
 */
select avg(EXTRACT(DAY FROM(r.return_date - r.rental_date))) AS diferencia_dias
from rental r;


/*
 * 22. Crea una columna con el nombre y apellidos de todos los actores y actrices.
 */
select *, concat(a.first_name , ' ', a.last_name) as "nombre_completo_actor" 
from actor a;


/*
 * 23. Números de alquiler por día, ordenados por cantidad de alquiler de
forma descendente.
 */
select Count(r.rental_id) as "Numero_alquiler" , rental_date::DATE AS "fecha"
from rental r 
group by rental_date::DATE
order by Count(r.rental_id) desc;


/*
 * 24. Encuentra las películas con una duración superior al promedio.
 */
SELECT f.title AS "nombre_pelicula"
FROM film f
WHERE f.length > (SELECT AVG(length) as "Promedio_pelicula" FROM film);


/*
 * 25. Averigua el número de alquileres registrados por mes.
 */
select Count(r.rental_id) as "Numero_alquiler" , extract(month from rental_date::DATE) AS "fecha_mes"
from rental r 
group by extract(month from rental_date::DATE)
order by "fecha_mes";


/*
 * 26. Encuentra el promedio, la desviación estándar y varianza del total
pagado.
 */
SELECT 
    AVG(p.amount) AS "promedio",                
    STDDEV(p.amount) AS "desviacion_estandar",  
    VARIANCE(p.amount) AS "varianza "           
FROM payment p;


/*
 * 27. ¿Qué películas se alquilan por encima del precio medio?
 */
select f.title AS "nombre_pelicula" , amount_mayor.amount as "Precio"
from(
SELECT p.rental_id ,p.amount
FROM payment p
WHERE p.amount > (SELECT AVG(amount) as "Promedio_pelicula" FROM payment)) as "amount_mayor"
inner join rental r on amount_mayor.rental_id=r.rental_id
inner join inventory i on r.inventory_id = i.inventory_id
inner join film f on i.film_id = f.film_id; 


/*
 * 28. Muestra el id de los actores que hayan participado en más de 40
películas.
 */
SELECT fa.actor_id as "actores_mas40_pelis"
FROM film_actor fa
group by fa.actor_id
having count(fa.actor_id) > 40
order by fa.actor_id;


/*
 * 29. Obtener todas las películas y, si están disponibles en el inventario,
mostrar la cantidad disponible.
 */
select f.title AS "nombre_pelicula","count_pelis"."Numero_pelis"
from film f 
inner join (
SELECT count(i.film_id) as "Numero_pelis", i.film_id
FROM inventory i 
group by i.film_id) as "count_pelis"
on f.film_id =count_pelis.film_id;


/*
 * 30. Obtener los actores y el número de películas en las que ha actuado.
 */
select concat(a.first_name , ' ', a.last_name) as "nombre_completo_actor" ,
"count_pelis"."Numero_pelis"
from actor a  
inner join (
SELECT count(fa.film_id) as "Numero_pelis", fa.actor_id 
FROM film_actor fa 
group by fa.actor_id ) as "count_pelis"
on a.actor_id =count_pelis.actor_id
order by "count_pelis"."Numero_pelis";


/*
 * 31. Obtener todas las películas y mostrar los actores que han actuado en
ellas, incluso si algunas películas no tienen actores asociados.
 */
select f.title as "nombre_pelicula" ,
concat(a.first_name , ' ', a.last_name) as "nombre_completo_actor" 
from film f 
left join film_actor fa on f.film_id = fa.film_id
left join actor a on fa.actor_id =a.actor_id;


/*
 * 32. Obtener todos los actores y mostrar las películas en las que han
actuado, incluso si algunos actores no han actuado en ninguna película.
 */
select f.title as "nombre_pelicula" ,
concat(a.first_name , ' ', a.last_name) as "nombre_completo_actor" 
from actor a
left join film_actor fa on a.actor_id =fa.actor_id
left join film f on fa.film_id = f.film_id ;


/*
 * 33. Obtener todas las películas que tenemos y todos los registros de
alquiler.
 */
select f.title as "nombre_pelicula" ,
r.rental_id as "registros_alquiler" 
from film f 
left join inventory i on f.film_id = i.film_id
full join rental r on i.inventory_id =r.inventory_id;


/*
 * 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
 */
select concat(c.first_name , ' ', c.last_name) as "nombre_completo_cliente" ,
"Total_gasto"
from customer c 
inner join
(select p.customer_id, sum(p.amount) as "Total_gasto"
from payment p 
group by p.customer_id 
order by "Total_gasto" desc limit 5) as "total_gasto"
on c.customer_id ="total_gasto".customer_id
order by "Total_gasto" desc;


/*
 * 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'
 */
select *
from actor a 
where a.first_name = 'JOHNNY';


/*
 * 36. Renombra la columna “first_name” como Nombre y “last_name” como
Apellido.
 */
select a.first_name as "Nombre",
a.last_name as "Apellido"
from actor a ;


/*
 * 37. Encuentra el ID del actor más bajo y más alto en la tabla actor. 
 */
select Min(a.actor_id) as "Id_actor_bajo",
Max(a.actor_id) as "Id_actor_alto"
from actor a ;


/*
 * 38. Cuenta cuántos actores hay en la tabla “actorˮ. 
 */
select count(distinct a.actor_id)
from actor a;


/*
 * 39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.
 */
select *
from actor a
order by a.last_name desc;


/*
 * 40. Selecciona las primeras 5 películas de la tabla "film".
 */
select f.title as "nombre_pelicula" 
from film f 
limit 5;


/*
 * 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. 
 * ¿Cuál es el nombre más repetido?
 */
select a.first_name as "Nombre", COUNT(*) as "cantidad_repetido"
from actor a
group by a.first_name
having COUNT(*) = (
    select MAX(cantidad_nombre_repetido)
    from (
        select COUNT(*) as "cantidad_nombre_repetido"
        from actor
        group by first_name
    ) as "nombre_mas_repetido"
)
order by "cantidad_repetido" desc;


/*
 * 42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
 */
select r.rental_id as "Todos_alquileres",
concat(c.first_name,' ',c.last_name) as "Clientes"
from rental r 
inner join customer c on r.customer_id =c.customer_id


/*
 * 43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
 */
select r.rental_id as "Todos_alquileres",
concat(c.first_name,' ',c.last_name) as "Clientes"
from customer c
left join rental r on r.customer_id =c.customer_id


/*
 * 44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? 
 * Deja después de la consulta la contestación.
 */
select count(*)
from film_category fc 
cross join category c
/*
 * Al hacer un CROSS JOIN sin una condición que lo limite, va a generar todas las combinaciones posibles entre
 *  las filas de film_category y category. Provocará que tendremos un gran volumen de datos que no nos aporta información.
 */


/*
 * 45. Encuentra los actores que han participado en películas de la categoría 'Action'.
 */
select concat(a.first_name,' ',a.last_name) as "Actores"
from actor a
inner join film_actor fa on a.actor_id = fa.actor_id
inner join film f on fa.film_id = f.film_id
inner join film_category fc on f.film_id = fc.film_id
inner join category c on fc.category_id = c.category_id
where c.name='Action'


/*
 * 46. Encuentra todos los actores que no han participado en películas.
 */
select distinct concat(a.first_name,' ',a.last_name) as "Actores", a.actor_id
from actor a
left join film_actor fa on a.actor_id = fa.actor_id
where fa.actor_id IS NULL;


/*
 * 47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
 */
select concat(a.first_name,' ',a.last_name) as "Actor", 
       count(fa.film_id) as "Numero_peliculas"
from actor a
left join film_actor fa on a.actor_id = fa.actor_id
group by a.actor_id
order by "Numero_peliculas";


/*
 * 48. Crea una vista llamada "actor_num_peliculas" que muestre los nombres de los actores
 *  y el número de películas en las que han participado.
 */
CREATE VIEW "actor_num_peliculas" as
select concat(a.first_name,' ',a.last_name) as "Actor", 
       count(fa.film_id) as "Numero_peliculas"
from actor a
left join film_actor fa on a.actor_id = fa.actor_id
group by a.actor_id
order by "Numero_peliculas";

select * from "actor_num_peliculas";


/*
 * 49. Calcula el número total de alquileres realizados por cada cliente.
 */
select count(r.rental_id) as "Todos_alquileres",
concat(c.first_name,' ',c.last_name) as "Clientes"
from rental r 
inner join customer c on r.customer_id =c.customer_id
group by "Clientes"
order by "Todos_alquileres";


/*
 * 50. Calcula la duración total de las películas en la categoría 'Action'.
 */
select sum(f.length) as "Duracion_Total"
from film f 
inner join film_category fc on f.film_id =fc.film_id
inner join category c on fc.category_id = c.category_id
where c.name='Action';


/*
 * 51. Crea una tabla temporal llamada "cliente_rentas_temporal" para almacenar el total de alquileres por cliente.
 */
create temporary table cliente_rentas_temporal as
select 
    c.customer_id,
    concat(c.first_name, ' ', c.last_name) as "Cliente",
    sum(p.amount) as "Alquiler_Total"
from customer c
inner join payment p on c.customer_id = p.customer_id
group by c.customer_id, c.first_name, c.last_name
order by Alquiler_Total desc;

select * from "cliente_rentas_temporal"


/*
 * 52. Crea una tabla temporal llamada "peliculas_alquiladas" que almacene 
 * las películas que han sido alquiladas al menos 10 veces.
 */
create temporary table peliculas_alquiladas as
select 
    f.film_id,
    f.title as "Pelicula",
    count(r.rental_id) as "Total_Alquileres"
from film f
inner join inventory i on f.film_id = i.film_id
inner join rental r on i.inventory_id = r.inventory_id
group by f.film_id, f.title
having count(r.rental_id) >= 10;

select * from "peliculas_alquiladas"


/*
 * 53. Encuentra el título de las películas que han sido alquiladas por el 
 * cliente con el nombre 'Tammy Sanders' y que aún no se han devuelto. Ordena los 
 * resultados alfabéticamente por título de película.
 */
select distinct f.title as "Pelicula"
from rental r
inner join customer c on r.customer_id = c.customer_id
inner join inventory i on r.inventory_id = i.inventory_id
inner join film f on i.film_id = f.film_id
where concat(c.first_name, ' ', c.last_name)='TAMMY SANDERS'
and r.return_date is null
order by "Pelicula"


/*
 * 54. Encuentra los nombres de los actores que han actuado en al menos una película 
 * que pertenece a la categoría 'Sci-Fi'. Ordena los resultados alfabéticamente por 
 * apellido.
 */
select a.first_name || ' ' || a.last_name as "Nombre_actor"
from actor a
inner join film_actor fa on fa.actor_id = a.actor_id
inner join film f on fa.film_id = f.film_id
inner join film_category fc on fc.film_id = f.film_id
inner join category c on c.category_id = fc.category_id
where c.name = 'Sci-Fi'
group by a.first_name, a.last_name
order by a.last_name;


/*
 * 55. Encuentra el nombre y apellido de los actores que han actuado en películas 
 * que se alquilaron después de que la película 'Spartacus Cheaper' se alquilara 
 * por primera vez. Ordena los resultados alfabéticamente por apellido.
 */
select distinct concat(a.first_name, ' ', a.last_name) as "Nombre_actor"
from rental r
inner join inventory i on r.inventory_id = i.inventory_id
inner join film f on i.film_id = f.film_id
inner join film_actor fa on fa.film_id = f.film_id
inner join actor a on a.actor_id = fa.actor_id
where r.rental_date > (
    select min(r.rental_date ) as "Pelicula_primera_vez"
    FROM rental r
    inner join inventory i on r.inventory_id = i.inventory_id
    inner join film f on i.film_id = f.film_id
    where f.title = 'SPARTACUS CHEAPER'
)
order by "Nombre_actor";


/*
 * 56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna 
 * película de la categoría 'Music'.
 */
select distinct concat(a.first_name, ' ', a.last_name) as "Nombre_actor"
from actor a
where not exists (
    select 1
    from film_actor fa
    inner join film_category fc on fa.film_id = fc.film_id
    inner join category c on fc.category_id = c.category_id
    where fa.actor_id = a.actor_id
    and c.name = 'Music'
)
order by "Nombre_actor";


/*
 * 57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
 */
select f.title as "Peliculas"
from rental r 
inner join inventory i on r.inventory_id =i.inventory_id
inner join film f on i.film_id = f.film_id
where extract(day inner (r.return_date - r.rental_date)) > 8
order by "Peliculas";


/*
 * 58. Encuentra el título de todas las películas que son de la misma categoría que 'Animation'.
 */
select distinct f.title as "Peliculas"
from film f
inner join film_category fc on f.film_id = fc.film_id
inner join category c on fc.category_id = c.category_id
where c.name='Animation'


/*
 * 59. Encuentra los nombres de las películas que tienen la misma duración que la película con el 
 * título 'Dancing Fever'. Ordena los resultados alfabéticamente por título de película.
 */
select distinct f.title as "Peliculas"
from film f
where f.length = (
	select f2.length
	from film f2
	where f2.title ='DANCING FEVER')
order by "Peliculas"


/*
 * 60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. 
 * Ordena los resultados alfabéticamente por apellido.
 */
select 
    c.first_name || ' ' || c.last_name as "Nombre_cliente"
from film f
inner join inventory i on f.film_id = i.film_id
inner join rental r on i.inventory_id = r.inventory_id
inner join customer c on r.customer_id = c.customer_id
group by c.first_name, c.last_name
having count(distinct f.film_id) >= 7
order by c.last_name;


/*
 * 61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el 
 * nombre de la categoría junto con el recuento de alquileres.
 */
select c.name as "Categoria", count(r.rental_id) as "Recuento_alquiler"
from category c 
inner join film_category fc on c.category_id = fc.category_id
inner join film f on fc.film_id = f.film_id
inner join inventory i on f.film_id = i.film_id
inner join rental r on i.inventory_id = r.inventory_id
group by c.name


/*
 * 62. Encuentra el número de películas por categoría estrenadas en 2006.
 */
select c.name as "Categoria", count(f.film_id) as "Recuento_peliculas"
from category c 
inner join film_category fc on c.category_id = fc.category_id
inner join film f on fc.film_id = f.film_id
where f.release_year =2006
group by c.name


/*
 * 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
 */
select concat(s.first_name, ' ', s.last_name) as "Nombre_trabajador",
s2.store_id as "Tienda"
from staff s 
cross join store s2


/*
 * 64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID 
 * del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
 */
select c.customer_id, concat(c.first_name, ' ', c.last_name) as "Nombre_Cliente",
count(r.rental_id) as "Recuento_alquiler"
from customer c 
inner join rental r on c.customer_id= r.customer_id 
group by c.customer_id, "Nombre_Cliente"
order by c.customer_id

