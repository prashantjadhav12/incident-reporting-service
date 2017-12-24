package com.irs.incident.reporting.service;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;

import com.irs.incident.reporting.dto.NoteDto;
import com.irs.incident.reporting.model.Note;
import com.irs.incident.reporting.model.repository.NoteRepository;

@Service
@Transactional(rollbackFor = Exception.class)
public class NoteService {
	
    private NoteRepository noteRepository;

    @Autowired
    NoteService(NoteRepository noteRepository) {
        this.noteRepository = noteRepository;
    }
    
    public List<Note> getAllNotes() {
        return noteRepository.findAll();
    }

    public Note createNote(NoteDto note) {
    	Note dbNode = new Note();
    	dbNode.setContent(note.getContent());
    	dbNode.setTitle(note.getTitle());
        return noteRepository.save(dbNode);
    }

    public ResponseEntity<Note> getNoteById(@PathVariable(value = "id") Long noteId) {
        Note note = noteRepository.findOne(noteId);
        if(note == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok().body(note);
    }

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

    public ResponseEntity<Note> deleteNote(@PathVariable(value = "id") Long noteId) {
        Note note = noteRepository.findOne(noteId);
        if(note == null) {
            return ResponseEntity.notFound().build();
        }

        noteRepository.delete(note);
        return ResponseEntity.ok().build();
    }

}
