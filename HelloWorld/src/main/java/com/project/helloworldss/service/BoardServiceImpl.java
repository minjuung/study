package com.project.helloworldss.service;

import com.project.helloworldss.entity.Board;
import com.project.helloworldss.repository.BoardRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Slf4j
public class BoardServiceImpl implements BoardService{

    private final BoardRepository boardRepository;

    @Override
    public void save(Board board) {
        boardRepository.save(board);
    }

    public List<Board> findAll() {
        return boardRepository.findAll();
    }


    @Override
    public void deleteById(Long bId) {
        boardRepository.deleteById(bId);
    }



    public Optional<Board> findById(Long bId) {
        return boardRepository.findById(bId);
    }

    @Transactional
    public int updateView(Long id) {
        return boardRepository.updateView(id);
    }
}
