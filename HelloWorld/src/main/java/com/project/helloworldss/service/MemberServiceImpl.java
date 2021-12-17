package com.project.helloworldss.service;

import com.project.helloworldss.entity.Member;
import com.project.helloworldss.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Objects;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {

    private final MemberRepository memberRepository;

    @Override
    public void save(Member member) {
        memberRepository.save(member);
    }

    @Override
    public void deleteById(Long mId) {
    }

    @Override
    public int login(String loginid, String password) {
        Optional<Member> first = memberRepository.findAll().stream()
                .filter(m -> Objects.equals(m.getUserId(), loginid))
                .findFirst();
        Member member = first.filter(m -> Objects.equals(m.getUserPwd(), password))
                .orElse(null);
        if (member == null) {
            System.out.println("실패");
            return 1;
        } else {
            System.out.println("성공");
            return 0;
        }

    }
}
