-- Escribir una consulta SQL que obtenga los títulos de los libros junto con el nombre completo del autor, ordenados por fecha de publicación descendente.
select 
	l.titulo,
	l.fecha_publicacion,
	a.nombre
		from autores_libros al join libros l on al.id_libro = l.id
			join autores a on a.id = al.id_autor
		order by l.fecha_publicacion desc;