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
    @PostMapping("/notes")
    public Note createNote(@Valid @RequestBody Note note) {
        return noteRepository.save(note);
    }

    // Get a Single Note
    @GetMapping("/notes/{id}")
    public ResponseEntity<Note> getNoteById(@PathVariable(value = "id") Long noteId) {
        Note note = noteRepository.findOne(noteId);
        if(note == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok().body(note);
    }

    // Update a Note
    @PutMapping("/notes/{id}")
    public ResponseEntity<Note> updateNote(@PathVariable(value = "id") Long noteId, 
                                           @Valid @RequestBody Note noteDetails) {
        Note note = noteRepository.findOne(noteId);
        if(note == null) {
            return ResponseEntity.notFound().build();
        }
        note.setTitle(noteDetails.getTitle());
        note.setContent(noteDetails.getContent());

        Note updatedNote = noteRepository.save(note);
        return ResponseEntity.ok(updatedNote);
    }

    // Delete a Note	
    @DeleteMapping("/notes/{id}")
    public ResponseEntity<Note> deleteNote(@PathVariable(value = "id") Long noteId) {
        Note note = noteRepository.findOne(noteId);
        if(note == null) {
            return ResponseEntity.notFound().build();
        }

        noteRepository.delete(note);
        return ResponseEntity.ok().build();
    }
}
