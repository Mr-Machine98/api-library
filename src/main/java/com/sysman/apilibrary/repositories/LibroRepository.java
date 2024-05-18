package com.sysman.apilibrary.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.sysman.apilibrary.entities.Libro;

@Repository
public interface LibroRepository extends JpaRepository<Libro, Long> {

}
