package com.project.helloworldss.dto;


import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public abstract class BoardResponse {

    @JsonProperty("bid")
    private int bid;
    @JsonProperty("bup")
    private int bup;
    @JsonProperty("bview")
    private int bview;
    @JsonProperty("bcontent")
    private String bcontent;
    @JsonProperty("bcategory")
    private String bcategory;
    @JsonProperty("btitle")
    private String btitle;
    @JsonProperty("lastModifyData")
    private String lastmodifydata;
    @JsonProperty("creatDate")
    private String creatdate;
}
