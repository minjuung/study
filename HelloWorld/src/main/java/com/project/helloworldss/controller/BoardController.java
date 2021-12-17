package com.project.helloworldss.controller;

import com.project.helloworldss.entity.Board;
import com.project.helloworldss.service.BoardServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.List;
import java.util.Optional;

@Controller
@RequiredArgsConstructor
@Slf4j
public class BoardController {

    private final BoardServiceImpl boardService;

    @PostMapping("/bbs/bbswrite")
    public String save(Board board) {
        Board board1 = Board.builder()
                .bUserId(board.getBUserId())
                .bTitle(board.getBTitle())
                .bContent(board.getBContent())
                .bCategory(board.getBCategory())
                .build();
        boardService.save(board1);

        return "index";
    }

    @GetMapping("/bbs/bbswrite")
    public String bbsForm() {
        return "/bbs/writeForm";
    }

    @GetMapping("/bbs/delete")
    public String bbsDeleteForm() {
        return "/bbs/deleteBbs";
    }



    @PostMapping("/bbs")
    public String delete(Long bId) {
        boardService.deleteById(bId);

        return "index";
    }


    @GetMapping("/bbs")
    public String findAllBbs(Model model) {
        List<Board> boards = boardService.findAll();
        model.addAttribute("bbsList", boards);
        log.info("게시판 리스트 로딩 완료");
        return "/bbs/viewBbs";
    }

    @GetMapping("/bbs/{bId}")
    public String findById(Model model, @PathVariable Long bId) {
        Optional<Board> byId = boardService.findById(bId);
        //bId로 특정 게시글 정보 조회
        model.addAttribute("bbs", byId);
        //조회수 증가
        model.addAttribute("view", boardService.updateView(bId));
        return "/bbs/detailBbs";
    }
}
