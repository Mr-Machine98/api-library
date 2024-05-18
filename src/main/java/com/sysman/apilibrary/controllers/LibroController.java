package com.sysman.apilibrary.controllers;

import java.util.List;
import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sysman.apilibrary.entities.Libro;
import com.sysman.apilibrary.services.LibroServices;

@RestController
@RequestMapping("/api/libros")
public class LibroController {
	
	private LibroServices libroService;
	
	LibroController(LibroServices libroService) {
        this.libroService = libroService;
    }
	
	@GetMapping("/all")
	public ResponseEntity<List<Libro>> findAll() {
		return ResponseEntity
				.ok(this.libroService.findAll());
	}
	
	@GetMapping("/{id}")
	public ResponseEntity<Libro> findById(@PathVariable(name = "id") Long id) {
		return ResponseEntity.ofNullable(this.libroService.findById(id));
	}
	
	@PostMapping
	public ResponseEntity<?> save(@RequestBody Libro libro) {
		Optional<?> optLibro = this.libroService.save(libro);
		return ResponseEntity.ok(
			optLibro.isPresent() ? optLibro.get() : "No se pudo guardar el libro, ya existe en la BD!."
		);
	}
	
	@DeleteMapping("/{id}")
	public ResponseEntity<?> delete(@PathVariable(name = "id") Long id) {
		this.libroService.delete(id);
		return ResponseEntity.ok().build();
	}
	
	@PutMapping
	public ResponseEntity<?> update(@RequestBody Libro libro) {
		Optional<?> opt = this.libroService.update(libro);
		if (opt.isPresent()) {
			return ResponseEntity.status(HttpStatus.OK).body(opt.get());
		} else {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("El libro no existe. Por favor crea el libro para poder actualizarlo!");
		}
	}
}
