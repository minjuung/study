package com.project.helloworldss.service;

import com.project.helloworldss.entity.Member;

public interface MemberService {

    void save(Member member);

    void deleteById(Long mId);

    int login(String id, String password);

//    Optional<Member> findByLoginId(String loginId);
}
