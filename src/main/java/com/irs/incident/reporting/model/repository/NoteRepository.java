package com.irs.incident.reporting.model.repository;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.irs.incident.reporting.model.Note;

@Repository
public interface NoteRepository extends JpaRepository<Note, Long> {

}