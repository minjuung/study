package com.project.helloworldss.service;

import com.project.helloworldss.entity.Board;

public interface BoardService {

    void save(Board board);

    void deleteById(Long bId);

}
