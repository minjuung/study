package com.project.helloworldss.entity;

import lombok.*;

import javax.persistence.*;

@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Table(name = "HELLO_MEMBER")
public class Member {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "m_uuid")
    private Long mUuid;

    @Column(name = "m_id", unique = true)
    private String userId;

    @Column(name = "m_pw")
    private String userPwd;

    @Column(name = "m_grade")
    private int userGrade;

    @Column(name = "m_email")
    private String userEmail;
}
