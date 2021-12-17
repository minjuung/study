package com.project.helloworldss.controller;

import com.project.helloworldss.entity.Member;
import com.project.helloworldss.service.MemberServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/members")
@RequiredArgsConstructor
public class MemberController {

    private final MemberServiceImpl memberService;

    @GetMapping()
    public String viewLogin() {
        return "/members/joinForm";
    }

    @PostMapping("/join")
    public String register(Member member) {
        Member saveMember = Member.builder()
                .userId(member.getUserId())
                .userPwd(member.getUserPwd())
                .userEmail(member.getUserEmail())
                .userGrade(0)
                .build();
        memberService.save(saveMember);

        return "index";
    }

    @GetMapping("/login")
    public String viewLoginForm() {
        return "/members/loginForm";
    }

    @PostMapping("/login")
    public String login(HttpServletRequest request, Member member) {
        HttpSession session = request.getSession();
        int login = memberService.login(member.getUserId(), member.getUserPwd());

        if (login == 1) {
            return "loginForm";
        } else {
            session.setAttribute("sessionId", member.getUserId());
            return "redirect:/";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.invalidate();
        return "redirect:/";
    }
}
