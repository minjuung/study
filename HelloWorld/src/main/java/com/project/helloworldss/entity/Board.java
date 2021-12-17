package com.project.helloworldss.entity;

import lombok.*;
import org.hibernate.annotations.ColumnDefault;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Table(name = "hello_board")
@EntityListeners(AuditingEntityListener.class)
public class Board {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "b_id")
    private Long bId;

    @Column(name = "b_user_id")
    private String bUserId;

    @Column(name = "b_category")
    private String bCategory;

    @Column(name = "b_view")
    @ColumnDefault("0")
    private int bView;

    @Column(name = "b_title")
    private String bTitle;

    @Column(name = "b_content")
    private String bContent;

    @Column(name = "b_up")
    @ColumnDefault("0")
    private int bUp;

    @CreatedDate
    private LocalDateTime creatDate;

    @LastModifiedDate
    private LocalDateTime lastModifyData;
}