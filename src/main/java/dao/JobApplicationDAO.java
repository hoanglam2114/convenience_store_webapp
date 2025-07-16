/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.DistrictApply;
import model.Gender;
import model.JobApplications;
import model.SourceAds;

/**
 *
 * @author admin
 */
public class JobApplicationDAO extends DBContext {

    public List<JobApplications> getAllJobApplication() {
        List<JobApplications> listJobs = new ArrayList<>();
        String sql = "SELECT [id]\n"
                + "      ,[fullname]\n"
                + "      ,[email]\n"
                + "      ,[phone]\n"
                + "      ,[dateOfBirth]\n"
                + "      ,[gender_ID]\n"
                + "      ,[currentAddress]\n"
                + "      ,[districtApply_ID]\n"
                + "      ,[InterviewDate]\n"
                + "      ,[source_ID]\n"
                + "  FROM [dbo].[JobApplications]\n"
                + "  WHERE 1=1";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                JobApplications p = new JobApplications();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("fullname"));
                p.setEmail(rs.getString("email"));
                p.setPhone(rs.getString("phone"));
                p.setDateofbirth(rs.getDate("dateOfBirth").toLocalDate());
                Gender jt = getGenderById(rs.getInt("gender_ID"));
                p.setGender(jt);
                p.setCurrent_address(rs.getString("currentAddress"));
                DistrictApply wu = getDistrictById(rs.getInt("districtApply_ID"));
                p.setInterview_date(rs.getDate("InterviewDate").toLocalDate());
                SourceAds sa = getSourcesById(rs.getInt("source_ID"));
                p.setSource(sa);
                listJobs.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return listJobs;
    }

    public SourceAds getSourcesById(int source_id) {
        String sql = "select * from [dbo].[SourceAds] where source_ID = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, source_id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                SourceAds wu = new SourceAds(rs.getInt("source_ID"),
                        rs.getString("source_Name")
                );
                return wu;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<SourceAds> getAllSourceAds() {
        List<SourceAds> list = new ArrayList<>();
        String sql = "select * from [dbo].[SourceAds]";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                SourceAds wu = new SourceAds(rs.getInt("source_ID"),
                        rs.getString("source_Name")
                );
                list.add(wu);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public DistrictApply getDistrictById(int district_id) {
        String sql = "select * from [dbo].[DistrictApply] where districtApply_ID = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, district_id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                DistrictApply pc = new DistrictApply(rs.getInt("districtApply_ID"),
                        rs.getString("districtApply_Name"));
                return pc;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<DistrictApply> getAllDistricts() {
        List<DistrictApply> list = new ArrayList<>();
        String sql = "select * from [dbo].[DistrictApply]";

        try {
            PreparedStatement st = connection.prepareStatement(sql);

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                DistrictApply pc = new DistrictApply(rs.getInt("districtApply_ID"),
                        rs.getString("districtApply_Name"));
                list.add(pc);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public Gender getGenderById(int gender_id) {
        String sql = "select * from [dbo].[Gender] where gender_ID = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, gender_id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Gender wi = new Gender(rs.getInt("gender_ID"),
                        rs.getString("gender_Name"));
                return wi;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<Gender> getAllGenders() {
        List<Gender> list = new ArrayList<>();
        String sql = "select * from [dbo].[Gender]";

        try {
            PreparedStatement st = connection.prepareStatement(sql);

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Gender wi = new Gender(rs.getInt("gender_ID"),
                        rs.getString("gender_Name"));
                list.add(wi);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public void insertJobApplication(JobApplications p) {
        String sql = "INSERT INTO JobApplications VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, p.getName());
            st.setString(2, p.getEmail());
            st.setString(3, p.getPhone());
            st.setDate(4, java.sql.Date.valueOf(p.getDateofbirth()));
            st.setInt(5, p.getGender().getId());
            st.setString(6,p.getCurrent_address() );
            st.setInt(7, p.getDistrict_apply().getId());
            st.setDate(8, java.sql.Date.valueOf(p.getInterview_date()));
            st.setInt(9, p.getSource().getId());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

}
