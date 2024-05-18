package com.sysman.apilibrary.entities;

import java.time.LocalDate;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "libros")
@ToString(exclude = {"autores"})
public class Libro {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	private String titulo;
	
	@Column(name = "fecha_publicacion", columnDefinition = "DATE")
	private LocalDate fechaPublicacion;
	
	private String tipo;
	
	@ManyToMany(mappedBy = "libros", cascade = CascadeType.ALL)
	private List<Autor> autores;
	
	
	
}
