package com.sysman.apilibrary.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.sysman.apilibrary.entities.Autor;
import com.sysman.apilibrary.entities.Libro;
import com.sysman.apilibrary.repositories.AutorRepository;
import com.sysman.apilibrary.repositories.LibroRepository;

import jakarta.transaction.Transactional;

@Service
public class LibroServices {
	
	private LibroRepository libroRepo;
	private AutorRepository autorRepo;

    LibroServices(LibroRepository libroRepo, AutorRepository autorRepo) {
        this.libroRepo = libroRepo;
        this.autorRepo = autorRepo;
    }
    
    /**
     * Devuelve todos los libros.
     * @return List : Lista de tipo Libro.
     * */
    public List<Libro> findAll() {
    	return this.libroRepo.findAll();
    }
    
    /**
     * Devuelve el libro dependiendo del id porporcionado.
     * @param id Es el id principal del libro.
     * @return Object : tipo Libro.
     * */
    public Libro findById(Long id) {
    	Optional<Libro> optLibro = this.libroRepo.findById(id);
    	if (optLibro.isPresent()) {
			return optLibro.get();
		} else {
			return null;
		}
	}
    
    /**
     * Guarda el Libro en la BD.
     * @return Object : retorna el libro creado.
     * */
    @Transactional
    public Optional<?> save(Libro libro) {
    	
    	if (libro.getId() == null || !existsById(libro.getId())) {
    		
    		List<Autor> autores = new ArrayList<Autor>();
    		
    		for (Autor autor : libro.getAutores()) {
				Optional<Autor> a = this.autorRepo.findById(autor.getId());
				if(a.isPresent()) autores.add(a.get());
			}
    		
    		libro.setAutores(autores);
    		Optional<Libro> optLibro = Optional.of(this.libroRepo.save(libro));
    		
    		// Guardamos tambie'n en forma bidireccional
    		for (Autor autor : autores) {
				autor.getLibros().add(libro);
				this.autorRepo.save(autor);
			}
    		
			return optLibro;
			
		} else {
			return Optional.empty();
		}
	}
    
    
    /**
     * Actualiza el libro existente en la BD
     * @param id : Es el id del libro
     * @return Object : Retorna objeto de tipo libro
     * */
    public Optional<?> update(Libro libro) {
    	if (libro.getId() == null) {
			return Optional.of("El id está vacio. Por favor escribelo en el atributo del JSON.");
		} else if (libro.getId() != null && existsById(libro.getId())) {
			
			Libro libroActual = this.libroRepo.findById(libro.getId()).get();
			libroActual.setTitulo(libro.getTitulo());
			libroActual.setFechaPublicacion(libro.getFechaPublicacion());
			libroActual.setTipo(libro.getTipo());
			libroActual.setAutores(libro.getAutores());
			
			return Optional.of(this.libroRepo.save(libroActual));
		} else {
			return Optional.empty();
		}
	}
    
    /**
     * Elimina el libro de la BD.
     * @param id : El id del libro a eliminar.
     * */
    @Transactional
    public void delete(Long id) {
		this.libroRepo.deleteById(id);
	}
    
    /**
     * Verifica si existe el libro
     * @return Boolean
     * */
    public Boolean existsById(Long id) {
		return this.libroRepo.existsById(id);
	}
}
