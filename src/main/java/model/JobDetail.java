/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class JobDetail {

    private int id;
    private int jobid;
    private String texttitle;
    private String textcontent;
    private int sortorder;
    private String[] contentList;

    public JobDetail() {
    }

    public JobDetail(int id, int jobid, String texttitle, String textcontent, int sortorder) {
        this.id = id;
        this.jobid = jobid;
        this.texttitle = texttitle;
        this.textcontent = textcontent;
        this.sortorder = sortorder;
    }

    public JobDetail(int jobid, String texttitle, String textcontent, int sortorder) {
        this.jobid = jobid;
        this.texttitle = texttitle;
        this.textcontent = textcontent;
        this.sortorder = sortorder;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getJobid() {
        return jobid;
    }

    public void setJobid(int jobid) {
        this.jobid = jobid;
    }

    public String getTexttitle() {
        return texttitle;
    }

    public void setTexttitle(String texttitle) {
        this.texttitle = texttitle;
    }

    public String getTextcontent() {
        return textcontent;
    }

    public void setTextcontent(String textcontent) {
        this.textcontent = textcontent;
    }

    public int getSortorder() {
        return sortorder;
    }

    public void setSortorder(int sortorder) {
        this.sortorder = sortorder;
    }

    public String[] getContentList() {
        return contentList;
    }

    public void setContentList(String[] contentList) {
        this.contentList = contentList;
    }

    @Override
    public String toString() {
        return "JobDetail{" + "id=" + id + ", jobid=" + jobid + ", texttitle=" + texttitle + ", textcontent=" + textcontent + ", sortorder=" + sortorder + '}';
    }

}
