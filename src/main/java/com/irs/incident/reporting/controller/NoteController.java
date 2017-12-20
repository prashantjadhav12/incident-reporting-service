package com.irs.incident.reporting.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.irs.incident.reporting.model.Note;

import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/api")
public class NoteController {

    @Autowired
    com.irs.incident.reporting.model.repository.NoteRepository noteRepository;

    // Get All Notes
    @GetMapping("/notes")
    public List<Note> getAllNotes() {
        return noteRepository.findAll();
    }

    // Create a new Note

    // Get a Single Note

    // Update a Note

    // Delete a Note		
}
